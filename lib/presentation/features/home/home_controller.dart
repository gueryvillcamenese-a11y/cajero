import 'package:flutter/material.dart';
import 'package:cajero/presentation/features/home/states/home_state.dart';
import 'package:cajero/core/theme/app_colors.dart';

class HomeController extends ValueNotifier<HomeState> {
  HomeController() : super(HomeState.initial());

  void navigateToCatalog(BuildContext context) {
    try {
      // Mostrar loading
      value = value.copyWith(isLoading: true);

      // Simular pequeña carga
      Future.delayed(const Duration(milliseconds: 300), () {
        // Navegar al catálogo
        Navigator.pushNamed(context, '/catalog');

        // Quitar loading
        value = value.copyWith(isLoading: false);

        // Mostrar mensaje de bienvenida
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('¡Bienvenido al catálogo!'),
            backgroundColor: AppColors.brandPrimary,
            duration: Duration(seconds: 1),
          ),
        );
      });

    } catch (e) {
      value = value.copyWith(
        isLoading: false,
        errorMessage: 'Error al navegar: $e',
      );
    }
  }
}
