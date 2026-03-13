import 'package:cajero/domain/entities/user.dart';

abstract class IUserRepository {
  Future<User?> login(String email, String password);
}
