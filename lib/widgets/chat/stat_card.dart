import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../features/chat/data/models/chat_stat.dart';

class StatCard extends StatelessWidget {
  const StatCard({super.key, required this.stat});
  
  final ChatStat stat;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: stat.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Icône
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: stat.iconBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(stat.icon, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 12),

          // Label + valeur
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stat.label,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  stat.value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
                if (stat.subtitle != null)
                  Text(
                    stat.subtitle!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),

          // Badge
          if (stat.badge != null)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: stat.badgeColor ?? AppColors.success.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                stat.badge!,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: stat.badgeTextColor ?? AppColors.success,
                ),
              ),
            ),
        ],
      ),
    );
  }
}