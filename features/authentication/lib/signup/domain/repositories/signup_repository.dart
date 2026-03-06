abstract class SignupRepository {
  Future<void> register({required String cpf, required String password});
}
