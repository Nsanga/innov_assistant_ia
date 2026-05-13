import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../features/chat/data/models/chat_message.dart';
import 'stat_card_list.dart';
import 'quick_replies.dart';

class AssistantBubble extends StatelessWidget {
  const AssistantBubble({super.key, required this.message});
  
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar IA
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.auto_awesome_rounded,
                color: Colors.white, size: 16),
          ),
          const SizedBox(width: 8),

          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bulle
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(18),
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    ),
                    border:
                        Border.all(color: AppColors.border, width: 0.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.content,
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppColors.textPrimary,
                          height: 1.5,
                        ),
                      ),
                      // Stat cards intégrées si le message contient des stats
                      if (message.stats != null) ...[
                        const SizedBox(height: 12),
                        StatCardList(stats: message.stats!),
                      ],
                      // Quick replies
                      if (message.quickReplies != null &&
                          message.quickReplies!.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        QuickReplies(replies: message.quickReplies!),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 4),
                Text(
                  message.timestampLabel ?? 'À l\'instant',
                  style: const TextStyle(
                      fontSize: 11, color: AppColors.textHint),
                ),
              ],
            ),
          ),
          const SizedBox(width: 40), // marge droite
        ],
      ),
    );
  }
}