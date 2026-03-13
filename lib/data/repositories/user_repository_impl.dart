import 'package:cajero/domain/entities/user.dart';
import 'package:cajero/domain/entities/user_role.dart';
import 'package:cajero/domain/repositories/i_user_repository.dart';

class UserRepositoryImpl implements IUserRepository {
  final List<User> _mockUsers = [
    User(
      id: '1',
      name: 'Cajero Principal',
      email: 'cajero@gmail.com',
      password: '123admi',
      role: UserRole.cashier,
    ),
    User(
      id: '2',
      name: 'José Administrador',
      email: 'jose@gmail.com',
      password: '123ideA',
      role: UserRole.admin,
    ),
    User(
      id: '3',
      name: 'Tigre Supervisor',
      email: 'tigre@gmail.com',
      password: '345mn2',
      role: UserRole.supervisor,
    ),
  ];

  @override
  Future<User?> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));
    try {
      return _mockUsers.firstWhere(
        (u) => u.email == email && u.password == password,
      );
    } catch (_) {
      return null;
    }
  }
}
