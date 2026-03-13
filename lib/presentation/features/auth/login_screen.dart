import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cajero/core/providers/auth_provider.dart';
import 'package:cajero/domain/entities/user_role.dart';
import 'package:cajero/presentation/routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedTerminal = 'Caja 01 - Principal';
  bool _isLoading = false;

  void _handleLogin() async {
    setState(() => _isLoading = true);
    
    final success = await context.read<AuthProvider>().login(
      _emailController.text,
      _passwordController.text,
    );

    setState(() => _isLoading = false);

    if (success && mounted) {
      final role = context.read<AuthProvider>().currentUser?.role;
      if (role == UserRole.admin) {
        Navigator.pushReplacementNamed(context, AppRoutes.reports);
      } else if (role == UserRole.supervisor) {
        Navigator.pushReplacementNamed(context, AppRoutes.supervision);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.catalog);
      }
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Credenciales incorrectas')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 80),
            Center(
              child: Column(
                children: [
                   Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFB74D),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.receipt_long, color: Colors.white, size: 40),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Demi Cashier',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3436),
                    ),
                  ),
                  const Text(
                    'Gestión de Punto de Venta',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            _buildTextField(
              label: 'Nombre de usuario o ID',
              controller: _emailController,
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Contraseña',
              controller: _passwordController,
              icon: Icons.lock_outline,
              isPassword: true,
            ),
            const SizedBox(height: 16),
            _buildDropdownField(
              label: 'Seleccionar Caja/Sucursal',
              value: _selectedTerminal,
              icon: Icons.storefront_outlined,
              onChanged: (val) => setState(() => _selectedTerminal = val!),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFB74D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'INICIAR TURNO',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 1.2,
                      ),
                    ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                '¿Olvidaste tu contraseña?',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 40),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.language, size: 18),
              label: const Text('Cambiar Idioma'),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: const Color(0xFFFFB74D), size: 20),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required IconData icon,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: ['Caja 01 - Principal', 'Caja 02 - Rápida']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
