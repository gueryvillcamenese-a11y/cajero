import 'package:cajero/domain/entities/user_role.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final UserRole role;
  final int points;
  final String level;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    this.points = 0,
    this.level = 'Bronce',
  });
}
