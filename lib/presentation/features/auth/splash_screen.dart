import 'package:flutter/material.dart';
import 'package:cajero/presentation/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  void _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFF3E5D8), // Light oak/wood background color
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'DEMI',
                  style: TextStyle(
                    color: Colors.teal[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Demi Cashier',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4037),
              ),
            ),
            const Spacer(),
            const Text(
              'Initializing secure session...',
              style: TextStyle(color: Color(0xFF8D6E63)),
            ),
            const SizedBox(height: 16),
            const SizedBox(
              width: 200,
              child: LinearProgressIndicator(
                backgroundColor: Color(0xFFE0E0E0),
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFB74D)),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'VERSION 2.4',
              style: TextStyle(
                fontSize: 10,
                color: Color(0xFFBCAAA4),
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
