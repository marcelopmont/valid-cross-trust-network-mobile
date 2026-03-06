Happy Flow - Curl Commands

# ====================================================================

# 0. Start the server (in a separate terminal)

# ====================================================================

bun run start:dev

# ====================================================================

# 1. Register user (CPF must exist in mock VDG: 12345678901, 35611365833, 39507010874)

# ====================================================================

curl -s -X POST http://localhost:3000/auth/register \
 -H "Content-Type: application/json" \
 -d '{"cpf":"12345678901","password":"securepass123"}'

# ====================================================================

# 2. Login (get JWT)

# ====================================================================

JWT=$(curl -s -X POST http://localhost:3000/auth/login \
 -H "Content-Type: application/json" \
 -d '{"cpf":"12345678901","password":"securepass123"}' \
 | python3 -c "import sys,json; print(json.load(sys.stdin)['access_token'])")
echo "JWT: ${JWT:0:50}..."

# ====================================================================

# 3. Grant LGPD consent

# ====================================================================

CONSENT_ID=$(curl -s -X POST http://localhost:3000/api/v1/consents \
 -H "Content-Type: application/json" \
 -H "Authorization: Bearer $JWT" \
 -d '{
"credentialType": "CINCredential",
"scope": ["cpf", "fullName", "birthDate", "nationality"],
"purpose": "Identity verification",
"legalBasis": "LGPD Art. 7, I - Consent"
}' | python3 -c "import sys,json; print(json.load(sys.stdin)['consentId'])")
echo "Consent ID: $CONSENT_ID"

# ====================================================================

# 4. Issue credential (BBS+ signed with mandatory pointers)

# ====================================================================

# Schema ID for CINCredential (check your DB)

SCHEMA_ID="203f60ee-a274-4195-8901-5596ae61be28"

ISSUE_RESULT=$(curl -s -X POST http://localhost:3000/api/v1/credentials/issue \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $JWT" \
    -d "{\"schemaId\":\"$SCHEMA_ID\",\"consentId\":\"$CONSENT_ID\"}")
  echo "$ISSUE_RESULT" | python3 -m json.tool

CRED_ID=$(echo "$ISSUE_RESULT" | python3 -c "import sys,json;
print(json.load(sys.stdin)['credentialId'].replace('urn:uuid:',''))")
echo "Credential ID: $CRED_ID"

# ====================================================================

# 5. Check wallet

# ====================================================================

curl -s http://localhost:3000/api/v1/wallet/credentials \
 -H "Authorization: Bearer $JWT" | python3 -m json.tool

# ====================================================================

# 6. Create presentation (selective disclosure + Ed25519 VP)

# ====================================================================

PRES_RESULT=$(curl -s -X POST http://localhost:3000/api/v1/presentations \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $JWT" \
    -d "{
      \"verifierDid\": \"did:webvh:valid.com.br\",
      \"credentials\": [{
        \"credentialId\": \"$CRED_ID\",
\"fields\": [\"fullName\", \"birthDate\"]
}],
\"challenge\": \"test-challenge-$(date +%s)\",
      \"delivery\": \"return\"
    }")
  echo "$PRES_RESULT" | python3 -m json.tool

# ====================================================================

# 7. Check trusted issuers (public endpoint)

# ====================================================================

curl -s http://localhost:3000/api/v1/trusted-issuers | python3 -m json.tool
