import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import 'nav_arrow.dart';

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({
    super.key,
    required this.focusedDay,
    required this.onPreviousMonth,
    required this.onNextMonth,
  });

  final DateTime focusedDay;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavArrow(
            icon: Icons.chevron_left,
            onTap: onPreviousMonth,
          ),
          Text(
            DateFormat('MMMM yyyy', 'fr_FR')
                .format(focusedDay)
                .replaceFirstMapped(
                  RegExp(r'^.'),
                  (m) => m[0]!.toUpperCase(),
                ),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: -0.3,
            ),
          ),
          NavArrow(
            icon: Icons.chevron_right,
            onTap: onNextMonth,
          ),
        ],
      ),
    );
  }
}