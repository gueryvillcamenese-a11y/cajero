import 'package:flutter/material.dart';
import 'package:cajero/domain/entities/user.dart';
import 'package:cajero/domain/usecases/user/login_usecase.dart';

import '../../domain/usecases/user/login_usecase.dart';

class AuthProvider extends ChangeNotifier {
  final LoginUseCase loginUseCase;
  User? _currentUser;
  bool _isLoading = false;

  AuthProvider({required this.loginUseCase});

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;
  bool get isLoading => _isLoading;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = await loginUseCase.execute(email, password);
      if (user != null) {
        _currentUser = user;
        _isLoading = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      debugPrint('Error en login: $e');
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
