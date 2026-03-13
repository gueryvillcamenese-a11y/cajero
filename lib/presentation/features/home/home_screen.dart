import 'package:flutter/material.dart';
import 'package:cajero/presentation/features/home/home_controller.dart';
import 'package:cajero/presentation/features/home/states/home_state.dart';
import 'package:cajero/presentation/features/home/widgets/logo_widget.dart';
import 'package:cajero/presentation/features/home/widgets/title_widget.dart';
import 'package:cajero/presentation/features/home/widgets/explore_button.dart';
import 'package:cajero/core/theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = HomeController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.beigeBackground,
      body: SafeArea(
        child: ValueListenableBuilder<HomeState>(
          valueListenable: _controller,
          builder: (context, state, child) {
            return Stack(
              children: [
                // Contenido principal
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LogoWidget(),
                        SizedBox(height: 32),
                        TitleWidget(),
                      ],
                    ),
                  ),
                ),

                // Botón de explorar
                Positioned(
                  bottom: 48,
                  left: 40,
                  right: 40,
                  child: ExploreButton(
                    onPressed: () => _controller.navigateToCatalog(context),
                    isLoading: state.isLoading,
                  ),
                ),

                // Mensaje de error si existe
                if (state.errorMessage != null)
                  Positioned(
                    top: 20,
                    left: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red.shade400),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.error, color: Colors.red.shade700),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              state.errorMessage!,
                              style: TextStyle(color: Colors.red.shade700),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
