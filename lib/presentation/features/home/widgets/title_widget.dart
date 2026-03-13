import 'package:flutter/material.dart';
import 'package:cajero/core/constants/app_constants.dart';
import 'package:cajero/core/theme/app_colors.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          AppConstants.appName,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppColors.gray800,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppConstants.appName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}
