import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({
    super.key,
    this.onNewConversation, // Callback 
  });

  final VoidCallback? onNewConversation;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      titleSpacing: 16,
      title: Row(
        children: [
          // Avatar IA
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: AppColors.assistantAvatarGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.auto_awesome_rounded,
                color: Colors.white, size: 20),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Assistant IA',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.3,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'En ligne',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.success,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: onNewConversation ?? () {},
          child: const Text(
            'Nouvelle conversation',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0.5),
        child: Container(height: 0.5, color: AppColors.border),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 0.5);
}