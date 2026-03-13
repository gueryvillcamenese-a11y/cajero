import 'package:flutter/material.dart';
import 'package:cajero/presentation/features/auth/splash_screen.dart';
import 'package:cajero/presentation/features/auth/login_screen.dart';
import 'package:cajero/presentation/features/home/home_screen.dart';
import 'package:cajero/presentation/features/catalog/catalog_screen.dart';
import 'package:cajero/presentation/features/cart/cart_screen.dart';
import 'package:cajero/presentation/features/profile/profile_screen.dart';
import 'package:cajero/presentation/features/payment/payment_screen.dart';
import 'package:cajero/presentation/features/scanner/scanner_screen.dart';
import 'package:cajero/presentation/features/reports/shift_summary_screen.dart';
import 'package:cajero/presentation/features/inventory/inventory_screen.dart';
import 'package:cajero/presentation/features/supervision/supervision_panel.dart';
import 'package:cajero/presentation/features/history/history_screen.dart';
import 'package:cajero/presentation/routes/app_routes.dart';

class AppPages {
  static Map<String, WidgetBuilder> routes = {
    AppRoutes.splash: (context) => const SplashScreen(),
    AppRoutes.login: (context) => const LoginScreen(),
    AppRoutes.home: (context) => const HomeScreen(),
    AppRoutes.catalog: (context) => const CatalogScreen(),
    AppRoutes.cart: (context) => const CartScreen(),
    AppRoutes.payment: (context) => const PaymentScreen(),
    AppRoutes.profile: (context) => const ProfileScreen(),
    AppRoutes.scanner: (context) => const ScannerScreen(),
    AppRoutes.reports: (context) => const ShiftSummaryScreen(),
    AppRoutes.inventory: (context) => const InventoryScreen(),
    AppRoutes.supervision: (context) => const SupervisionPanel(),
    AppRoutes.history: (context) => const HistoryScreen(),
  };
}
