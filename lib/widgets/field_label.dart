import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class FieldLabel extends StatelessWidget {
  const FieldLabel({super.key, required this.label});
  
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
    );
  }
}