import 'package:cajero/domain/entities/user.dart';
import 'package:cajero/domain/repositories/i_user_repository.dart';

class LoginUseCase {
  final IUserRepository repository;

  LoginUseCase(this.repository);

  Future<User?> execute(String email, String password) {
    return repository.login(email, password);
  }
}
