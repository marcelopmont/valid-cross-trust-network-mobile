# Fluxo de Compartilhamento de Credencial (Estado Atual)

> Baseado no codigo-fonte em 2026-03-30. Este documento descreve o fluxo **implementado**, nao o planejado.

---

## Visao Geral

O compartilhamento de credencial permite que um **holder** (usuario) selecione campos especificos de uma ou mais credenciais na cloud wallet e os apresente a um **verifier** (verificador), com privacidade garantida por **selective disclosure BBS+** e **encriptacao DIDComm v2**.

```
                                 VTN Backend
                         ┌────────────────────────────┐
  Holder App             │                            │          Verifier App
  (Valid ID)             │  1. Decrypt VC             │          (Mercado X, etc.)
       │                 │  2. BBS+ derive            │               │
       │  POST /present. │  3. Sign VP (Ed25519)      │  WS push      │
       ├────────────────→│  4. Encrypt (ECDH-ES)      │──────────────→│
       │                 │  5. Deliver to inbox       │               │
       │                 │                            │               │
       │                 │  ┌──────────────────────┐  │               │
       │                 │  │ Verifier Module      │  │               │
       │                 │  │ (in-process)         │  │               │
       │                 │  │ - Decrypt            │  │               │
       │                 │  │ - Verify VP proof    │  │               │
       │                 │  │ - Verify VC proofs   │  │               │
       │                 │  │ - Check revocation   │  │               │
       │                 │  │ - Check expiration   │  │               │
       │                 │  └──────────────────────┘  │               │
       │                 └────────────────────────────┘               │
```

---

## Atores

| Ator | Descricao | Autenticacao |
|------|-----------|-------------|
| **Holder** | Usuario com credenciais na cloud wallet (Valid ID) | JWT (local-auth, role `user`) |
| **Verifier Client** | Estabelecimento que quer verificar dados (ex: Mercado X) | JWT proprio (verifier-auth) |
| **VTN** | Plataforma que orquestra tudo (issuer + middleware) | Chaves em KMS (Ed25519, X25519, BBS+) |

---

## Endpoints Envolvidos

| # | Metodo | Path | Auth | Modulo |
|---|--------|------|------|--------|
| 1 | `POST` | `/api/v1/verifier/auth/login` | Public | Verifier |
| 2 | `GET` | `/api/v1/verifier/qr` | Verifier JWT | Verifier |
| 3 | `POST` | `/api/v1/presentations` | Holder JWT | Presentation |
| 4 | `POST` | `/api/v1/verifier/didcomm/inbox` | Public | Verifier |
| 5 | `WS` | `/api/v1/verifier/ws?challenge={nonce}&token={jwt}` | Verifier JWT | Verifier |
| 6 | `GET` | `/api/v1/verifier/:slug/.well-known/did.jsonl` | Public | Verifier |

---

## Fluxo Completo (DIDComm - delivery `didcomm`)

### Fase 1: Setup do Verifier

```
Verifier App                          VTN
     │                                 │
     │  POST /verifier/auth/login      │
     │  { username, password }         │
     ├────────────────────────────────→│
     │  ← { access_token, clientId }   │
     │                                 │
     │  GET /verifier/qr               │
     │  Authorization: Bearer {jwt}    │
     ├────────────────────────────────→│
     │  ← { challenge, qrPayload }     │
     │                                 │
     │  WS /verifier/ws                │
     │  ?challenge={nonce}             │
     │  &token={jwt}                   │
     ├─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ →│  (WebSocket aberto, aguardando resultado)
     │                                 │
```

**QR Payload gerado (exibido como QR Code):**

```json
{
  "verifierDid": "did:webvh:domain:verifier:mercado-x",
  "requestedFields": ["fullName", "isAdult"],
  "purpose": "Verificacao de idade",
  "challenge": "nonce-a1b2c3d4e5f6..."
}
```

A sessao e armazenada **in-memory** no `VerifierService` (`Map<challenge, VerificationSession>`).

### Fase 2: Holder Escaneia QR e Autoriza

O holder (Valid ID) escaneia o QR, visualiza os campos solicitados, seleciona de qual credencial vem cada campo, e autoriza.

O app monta o request:

```json
{
  "verifierDid": "did:webvh:domain:verifier:mercado-x",
  "credentials": [
    {
      "credentialId": "f47ac10b-58cc-4372-a567-0e02b2c3d479",
      "fields": ["fullName", "isAdult"]
    }
  ],
  "challenge": "nonce-a1b2c3d4e5f6...",
  "domain": "did:webvh:domain:verifier:mercado-x",
  "delivery": "didcomm"
}
```

> **Importante:** `credentialId` e UUID puro (sem prefixo `urn:uuid:`). Validado com `@IsUUID()`.

### Fase 3: VTN Processa a Apresentacao

```
POST /api/v1/presentations
Authorization: Bearer {holder_jwt}
```

**Pipeline do `PresentationService.createPresentation()`:**

```
 1. Gera presentationId (UUID)
 2. Deduplica selecoes (merge de fields se mesmo credentialId)
 3. Resolve holder:
    a. Hash CPF do JWT (SHA-256)
    b. Busca subject pelo cpfHash
 4. Para cada credential selecionada:
    a. Valida credencial:
       - Existe no banco?
       - Pertence ao holder (subjectId)?
       - Nao esta revogada?
       - Nao esta expirada?
    b. Busca registro na cloud wallet (cloudWalletRecords)
    c. Obtem wallet key do KMS (por DID do holder)
    d. Decripta VC (AES-256-GCM)
    e. Garante que @context inclui contexto do schema
       (fix para VCs emitidas antes do context fix — necessario
       para canonicalizacao JSON-LD do BBS+)
    f. Valida que todos os fields existem no credentialSubject
    g. Deriva prova BBS+ com selective disclosure
       - selectivePointers: ["/credentialSubject/fullName", "/credentialSubject/isAdult"]
    h. Descarta VC decriptada da memoria (null assignment)
 5. Resolve DID do verifier (DID resolver plugavel)
 6. Assina VP:
    a. Monta VP: { @context, type, holder, verifiableCredential }
    b. Cria proofConfig (Ed25519, eddsa-jcs-2022, challenge, domain)
    c. Hash: JCS(proofConfig) → SHA-256 = hash1
    d. Hash: JCS(VP body) → SHA-256 = hash2
    e. Concatena: hash1 || hash2
    f. Assina com Ed25519 (via KeyProvider)
    g. Codifica assinatura: z + base58btc
 7. Entrega via DIDComm (se delivery="didcomm"):
    a. Monta DIDComm plaintext (present-proof/3.0)
    b. Busca X25519 privada do sender (VTN) no KeyProvider
    c. Extrai X25519 publica do recipient (verifier DID Doc)
    d. Encripta com ECDH-ES + AES-256-GCM (via DIDCommService)
    e. Entrega ao VerifierInbox (chamada direta in-process)
 8. Registra audit log (fire-and-forget)
 9. Registra billing event (fire-and-forget)
10. Retorna PresentationResponseDto
```

### Fase 4: Verifier Processa a Mensagem

```
verifierInbox.processInboxMessage(jwe)
```

**Pipeline do `VerifierService.processInboxMessage()`:**

```
 1. DECRYPT (VerifierCryptoService.unpack)
    a. Extrai skid do protected header → identifica sender
    b. Valida que sender e o DID da plataforma (VTN)
    c. Identifica recipient client pelo kid (busca no banco)
    d. Busca X25519 privada do client no KMS
    e. Busca X25519 publica do sender (KeyProvider)
    f. ECDH: recipient_private + sender_public → shared_secret
    g. SHA-256(shared_secret) → AES key
    h. AES-256-GCM decrypt

 2. VALIDATE SENDER
    - senderDid == platformIssuerDid? Se nao, rejeita

 3. EXTRACT VP
    - plaintext.attachments[0].data.json → VP

 4. MATCH CHALLENGE
    - VP.proof.challenge → busca sessao pendente
    - Se nao existe ou nao esta PENDING, rejeita

 5. VALIDATE DOMAIN
    - VP.proof.domain == session.clientDid? Se nao, rejeita

 6. VERIFY VP PROOF (Ed25519 eddsa-jcs-2022)
    a. Resolve DID do signer (verificationMethod → split #)
    b. Extrai Ed25519 public key do DID Document
    c. Reconstroi: JCS(proofConfig) → SHA-256 || JCS(document) → SHA-256
    d. Decodifica proofValue (z + base58btc → bytes)
    e. Verifica assinatura Ed25519

 7. VERIFY EACH VC (loop)
    a. BBS+ proof check (validacao estrutural):
       - proof.type == "DataIntegrityProof"?
       - proof.cryptosuite == "bbs-2023"?
       - proofValue nao vazio?
       - verificationMethod presente?
       (Nota: verificacao criptografica completa do BBS+ ainda
       nao implementada — apenas validacao estrutural)
    b. Revocation check (StatusListService):
       - Fetch GET statusListCredential URL
       - Decodifica encodedList (base64 → bitstring)
       - Checa bit no statusListIndex (0=ativo, 1=revogado)
    c. Expiration check:
       - expirationDate > now?
       - validUntil > now?
       - validFrom/issuanceDate <= now?
    d. Extrai disclosedAttributes (credentialSubject sem id)

 8. RESULTADO
    - verified = VP proof passed AND all VCs passed (proof + revocation + expiration)
    - Salva resultado na sessao (Map in-memory)

 9. PUSH VIA WEBSOCKET (se conectado)
    - Envia { event: "verification_result", challenge, verified, credentials }
```

### Fase 5: Verifier Recebe o Resultado

```
Verifier App                          VTN (WebSocket)
     │                                  │
     │  ← WS message:                   │
     │  {                               │
     │    "event": "verification_result",
     │    "challenge": "nonce-...",     │
     │    "verified": true,             │
     │    "credentials": [              │
     │      {                           │
     │        "type": ["VerifiableCredential", "CINCredential"],
     │        "issuer": "did:webvh:...:valid.com.br",
     │        "checks": {               │
     │          "proof": "passed",      │
     │          "revocation": "passed", │
     │          "expiration": "passed"  │
     │        },                        │
     │        "disclosedAttributes": {  │
     │          "fullName": "Carlos",   │
     │          "isAdult": true         │
     │        }                         │
     │      }                           │
     │    ]                             │
     │  }                               │
     │                                  │
```

---

## Modos de Entrega (delivery)

O endpoint `POST /presentations` suporta 3 modos:

### `didcomm` (fluxo principal)

- VP e empacotada como mensagem DIDComm v2 (`present-proof/3.0/presentation`)
- Encriptada com ECDH-ES + AES-256-GCM (JSON Serialization)
- Entregue ao `VerifierInbox` (chamada direta in-process, workaround)
- Verifier recebe resultado via WebSocket
- Response: `{ presentationId, delivery: "didcomm", status: "delivered", jwe: null }`

### `return`

- VP e encriptada como **compact JWE** (ECDH-ES + A256GCM via jose)
- Retornada no body da response
- O caller (app intermediario) encaminha o JWE ao verifier
- Response: `{ presentationId, delivery: "return", status: "created", jwe: "eyJ..." }`

### `direct`

- VP e encriptada como compact JWE
- VTN faz HTTP POST ao service endpoint do DID Document do verifier
- Content-Type: `application/didcomm-encrypted+json`
- Response: `{ presentationId, delivery: "direct", status: "delivered", jwe: null }`

---

## Estrutura das Mensagens

### VP Assinada (antes da encriptacao)

```json
{
  "@context": ["https://www.w3.org/ns/credentials/v2"],
  "type": ["VerifiablePresentation"],
  "holder": "did:key:z6Mk...",
  "verifiableCredential": [
    {
      "@context": [
        "https://www.w3.org/ns/credentials/v2",
        "https://w3id.org/security/data-integrity/v2",
        "https://vtn.valid.com.br/contexts/CINCredential"
      ],
      "type": ["VerifiableCredential", "CINCredential"],
      "credentialSubject": {
        "fullName": "Carlos Eduardo Santos",
        "isAdult": true
      },
      "credentialStatus": {
        "type": "BitstringStatusListEntry",
        "statusPurpose": "revocation",
        "statusListCredential": "https://vtn.valid.com.br/api/v1/credentials/status/tenant-001",
        "statusListIndex": "42"
      },
      "proof": {
        "type": "DataIntegrityProof",
        "cryptosuite": "bbs-2023",
        "proofPurpose": "assertionMethod",
        "verificationMethod": "did:webvh:...:valid.com.br#key-bbs-1",
        "proofValue": "u2V0BhVhA..."
      }
    }
  ],
  "proof": {
    "type": "DataIntegrityProof",
    "cryptosuite": "eddsa-jcs-2022",
    "created": "2026-03-30T14:00:00Z",
    "verificationMethod": "did:webvh:...:valid.com.br#key-ed25519-1",
    "proofPurpose": "authentication",
    "challenge": "nonce-a1b2c3d4e5f6...",
    "domain": "did:webvh:domain:verifier:mercado-x",
    "proofValue": "z5vGFmTqRPPv8GKR..."
  }
}
```

### DIDComm Plaintext (antes da encriptacao)

```json
{
  "id": "msg-pres-550e8400-e29b-41d4-...",
  "type": "https://didcomm.org/present-proof/3.0/presentation",
  "from": "did:webvh:...:valid.com.br",
  "to": ["did:webvh:domain:verifier:mercado-x"],
  "created_time": 1743350400,
  "body": {},
  "attachments": [
    {
      "id": "vp-1",
      "media_type": "application/ld+json",
      "data": { "json": { "...VP assinada acima..." } }
    }
  ]
}
```

### JWE Encriptado (DIDComm JSON Serialization)

```json
{
  "protected": "base64url({ typ: 'application/didcomm-encrypted+json', alg: 'ECDH-ES+A256KW', enc: 'A256GCM', skid: 'did:webvh:...:valid.com.br#key-x25519-1' })",
  "recipients": [
    {
      "header": { "kid": "did:webvh:domain:verifier:mercado-x#key-agreement-1" },
      "encrypted_key": ""
    }
  ],
  "iv": "base64(12 bytes random)",
  "ciphertext": "base64(encrypted DIDComm plaintext)",
  "tag": "base64(16 bytes AES-GCM auth tag)"
}
```

---

## Criptografia Utilizada

| Operacao | Algoritmo | Chaves | Servico |
|----------|-----------|--------|---------|
| Decriptar VC da wallet | AES-256-GCM | Wallet key por holder (KMS) | `AesEncryptionService` |
| Derivar prova seletiva | BBS+ (bbs-2023) | BBS+ public key do issuer | `SignatureService.derive()` |
| Assinar VP | Ed25519 (eddsa-jcs-2022) | Ed25519 da plataforma (KMS) | `KeyProvider.signWithEd25519()` |
| Encriptar JWE compact | ECDH-ES + A256GCM | X25519 (sender priv + recipient pub) | `JweEncryptionService` (jose) |
| Encriptar DIDComm | ECDH-ES + AES-256-GCM | X25519 (sender priv + recipient pub) | `DIDCommService` (@noble/curves) |
| Decriptar DIDComm | ECDH-ES + AES-256-GCM | X25519 (recipient priv + sender pub) | `DIDCommService` |
| Verificar VP proof | Ed25519 verify | Ed25519 pub do signer (resolved) | `VerifierProofService` (@noble/ed25519) |
| Verificar VC proof | BBS+ (estrutural) | N/A | `VerifierProofService` |
| Checar revogacao | Bitstring decode | N/A | `VerifierStatusListService` (fetch) |

---

## Limitacoes e Workarounds Atuais

### 1. Verifier in-process (workaround)

O modulo Verifier roda **dentro do mesmo processo** da VTN. A entrega DIDComm e feita por chamada direta (`verifierInbox.processInboxMessage(jwe)`) em vez de HTTP POST.

**Quando extrair para servico separado**, substituir por HTTP POST ao endpoint DIDCommMessaging do DID Document do verifier.

Referencia: `src/credential/presentation/presentation.service.ts:367-372`

### 2. BBS+ verification e estrutural

A verificacao de prova BBS+ nas VCs derivadas faz apenas **validacao estrutural** (tipo, cryptosuite, proofValue nao vazio). A verificacao criptografica completa do BBS+ derived proof ainda nao esta implementada no lado do verifier.

Referencia: `src/verifier/verifier-proof.service.ts:89-121`

### 3. Sessoes in-memory

As sessoes de verificacao (`Map<challenge, VerificationSession>`) sao armazenadas **em memoria**. Reinicio do servidor perde todas as sessoes pendentes. Para producao, migrar para Redis ou banco.

Referencia: `src/verifier/verifier.service.ts:23`

### 4. Context injection

VCs emitidas antes de um fix especifico podem nao ter o contexto JSON-LD do schema no `@context`. O `PresentationService` injeta o contexto faltante em runtime para evitar falha na canonicalizacao BBS+.

Referencia: `src/credential/presentation/presentation.service.ts:265-284`

---

## Arquivos-chave

### Presentation (lado emissor/holder)

| Arquivo | Responsabilidade |
|---------|-----------------|
| `src/credential/presentation/presentation.controller.ts` | Endpoint POST /presentations |
| `src/credential/presentation/presentation.service.ts` | Orquestracao completa |
| `src/credential/presentation/dtos/create-presentation.dto.ts` | Validacao do request |
| `src/credential/presentation/dtos/presentation-response.dto.ts` | Shape do response |
| `src/credential/presentation/vp.builder.ts` | Montagem e assinatura da VP (Ed25519) |
| `src/credential/presentation/jwe-encryption.service.ts` | Encriptacao compact JWE (jose) |

### Verifier (lado verificador)

| Arquivo | Responsabilidade |
|---------|-----------------|
| `src/verifier/verifier.controller.ts` | Endpoints: login, QR, inbox, DID doc |
| `src/verifier/verifier.service.ts` | Sessoes + pipeline de verificacao (9 steps) |
| `src/verifier/verifier-crypto.service.ts` | Decrypt DIDComm (ECDH-ES unpack) |
| `src/verifier/verifier-proof.service.ts` | Verificacao Ed25519 VP + BBS+ VC (estrutural) |
| `src/verifier/verifier-status-list.service.ts` | Revocation + expiration checks |
| `src/verifier/verifier.gateway.ts` | WebSocket push de resultados |
| `src/verifier/verifier-auth.service.ts` | Auth JWT do verifier |
| `src/verifier/verifier-did-document.builder.ts` | DID Document do verifier client |

### DIDComm (compartilhado)

| Arquivo | Responsabilidade |
|---------|-----------------|
| `src/didcomm/didcomm.service.ts` | Encrypt/decrypt ECDH-ES + AES-256-GCM |
| `src/didcomm/didcomm-message.builder.ts` | Monta DIDComm plaintext (present-proof/3.0) |
| `src/didcomm/interfaces/didcomm-types.ts` | Types: JWEJsonSerialization, DIDCommPlaintext |

---

## Response do POST /presentations

```json
{
  "presentationId": "b7e23f90-4c5d-4a8b-9e1f-c2d3e4f5a6b7",
  "delivery": "didcomm",
  "verifierDid": "did:webvh:domain:verifier:mercado-x",
  "credentialCount": 1,
  "status": "delivered",
  "jwe": null
}
```

| Campo | Tipo | Descricao |
|-------|------|-----------|
| `presentationId` | UUID | Referencia para audit trail |
| `delivery` | `"direct"` \| `"return"` \| `"didcomm"` | Modo de entrega usado |
| `verifierDid` | string | DID do verifier |
| `credentialCount` | number | Quantidade de credenciais na VP |
| `status` | `"delivered"` \| `"created"` | `delivered` = entregue ao verifier; `created` = JWE no response |
| `jwe` | string \| null | Compact JWE (apenas para `delivery: "return"`) |
