import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../features/chat/data/models/chat_message.dart';
import '../../features/auth/data/models/user_model.dart';

class UserBubble extends StatelessWidget {
  const UserBubble({
    super.key,
    required this.message,
    this.user,
  });

  final ChatMessage message;
  final UserModel? user;

  // Gérer le cas où user est null
  String get _initials {
    if (user == null) return 'U'; // Valeur par défaut si pas d'utilisateur
    
    final fullName = user!.fullName;
    if (fullName.isEmpty) return 'U';
    
    final parts = fullName.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return fullName[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 48),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  decoration: const BoxDecoration(
                    color: AppColors.chatUser,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(4),
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    ),
                  ),
                  child: Text(
                    message.content,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Avatar utilisateur
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    _initials,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Padding(
            padding: EdgeInsets.only(right: 40),
            child: Text(
              'À l\'instant',
              style: TextStyle(fontSize: 11, color: AppColors.textHint),
            ),
          ),
        ],
      ),
    );
  }
}