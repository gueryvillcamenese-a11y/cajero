import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cajero/core/theme/app_theme.dart';
import 'package:cajero/presentation/routes/app_pages.dart';
import 'package:cajero/presentation/routes/app_routes.dart';
import 'package:cajero/core/providers/cart_provider.dart';
import 'package:cajero/core/providers/auth_provider.dart';
import 'package:cajero/injection/injection_container.dart';

import 'package:cajero/core/providers/order_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // En una app real, aquí podrías inicializar bases de datos locales (Hive, SQLite)
  // o servicios de Firebase si fuera necesario.
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(loginUseCase: sl.loginUseCase),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demi Cashier',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      routes: AppPages.routes,
      // Manejo de rutas desconocidas para evitar pantallazos negros
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(child: Text('Ruta no encontrada: ${settings.name}')),
          ),
        );
      },
    );
  }
}
