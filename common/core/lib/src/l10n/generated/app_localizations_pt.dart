// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Valid ID';

  @override
  String get walletTab => 'Carteira';

  @override
  String get scanTab => 'Scan';

  @override
  String get cpfLabel => 'CPF';

  @override
  String get cpfHint => '000.000.000-00';

  @override
  String get cpfRequired => 'CPF é obrigatório';

  @override
  String get cpfMustHave11Digits => 'CPF deve conter 11 dígitos';

  @override
  String get password => 'Senha';

  @override
  String get passwordRequired => 'Senha é obrigatória';

  @override
  String get passwordMinLength => 'Senha deve ter no mínimo 6 caracteres';

  @override
  String get confirmPassword => 'Confirmar Senha';

  @override
  String get confirmPasswordRequired => 'Confirmação de senha é obrigatória';

  @override
  String get passwordsDoNotMatch => 'As senhas não conferem';

  @override
  String get signIn => 'Entrar';

  @override
  String get noAccountSignUp => 'Não tem conta? Cadastre-se';

  @override
  String get createAccount => 'Criar Conta';

  @override
  String get signUp => 'Cadastrar';

  @override
  String get userNotFound => 'Usuário não encontrado';

  @override
  String get userAlreadyRegistered => 'Usuário já cadastrado';

  @override
  String get connectionError => 'Erro de conexão. Tente novamente';

  @override
  String get timeoutError => 'Tempo esgotado. Tente novamente';

  @override
  String get unexpectedError => 'Erro inesperado. Tente novamente';

  @override
  String get addCredential => 'Adicionar credencial';

  @override
  String get noCredentials => 'Nenhuma credencial';

  @override
  String get credentialsLoadError => 'Erro ao carregar credenciais';

  @override
  String issuedOn(String date) {
    return 'Emitido em: $date';
  }

  @override
  String expiresOn(String date) {
    return 'Expira em: $date';
  }

  @override
  String get statusIssued => 'Emitida';

  @override
  String get details => 'Detalhes';

  @override
  String get addToGoogleWallet => 'Adicionar à Carteira do Google';

  @override
  String get revokeCredential => 'Revogar Credencial';

  @override
  String get information => 'Informações';

  @override
  String get credentialDetailError => 'Ops, ocorreu um erro, tente novamente.';

  @override
  String get credentialRevokedSuccess => 'Credencial revogada com sucesso';

  @override
  String get availableCredentials => 'Credenciais Disponíveis';

  @override
  String get noOffersAvailable => 'Nenhuma oferta disponível';

  @override
  String get offersHeaderText =>
      'Aqui estão seus documentos disponíveis para emissão.';

  @override
  String get issue => 'Emitir';

  @override
  String get consent => 'Consentimento';

  @override
  String get consentDescription =>
      'Para utilizar o aplicativo, precisamos do seu consentimento para coletar e processar alguns de seus dados pessoais:';

  @override
  String get consentName => 'Nome';

  @override
  String get consentDateOfBirth => 'Data de nascimento';

  @override
  String get consentPurpose => 'Finalidade';

  @override
  String get consentPurposeDescription =>
      'Verificação de idade para emissão de credencial';

  @override
  String get consentLegalBasis => 'Base Legal';

  @override
  String get consentLegalBasisDescription => 'LGPD Art. 7, I - Consentimento';

  @override
  String get consentWarning =>
      'O consentimento é obrigatório para continuar utilizando o aplicativo. Você pode sair e entrar com outra conta se preferir.';

  @override
  String get acceptAndContinue => 'Aceitar e continuar';

  @override
  String get back => 'Voltar';

  @override
  String get identityVerification => 'Verificação de Identidade';

  @override
  String get livenessVerification => 'Verificação de Liveness';

  @override
  String get livenessDescription =>
      'Para garantir sua segurança e confirmar sua identidade, precisamos realizar uma verificação facial rápida.';

  @override
  String get startVerification => 'Iniciar Verificação';

  @override
  String get cancel => 'Cancelar';

  @override
  String get scanQrCode => 'Scan QR Code';

  @override
  String get positionQrCode => 'Posicione o QR code dentro do quadro';

  @override
  String get documentNotFound => 'Documento não encontrado';

  @override
  String get signOut => 'Sair da conta';

  @override
  String get offersLoadError => 'Erro ao carregar ofertas';

  @override
  String get credentialIssueError =>
      'Erro ao emitir credencial. Tente novamente.';

  @override
  String get credentialTypeAgeVerification => 'Comprovante de Idade';

  @override
  String get credentialTypeCofenNursingLicense => 'Licença de Enfermagem COFEN';
}
