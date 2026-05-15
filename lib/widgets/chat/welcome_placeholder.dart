import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class WelcomePlaceholder extends StatelessWidget {
  const WelcomePlaceholder({
    super.key,
    this.userName,
  });

  final String? userName;

  String get _greeting {
    if (userName != null && userName!.isNotEmpty) {
      return 'Bonjour $userName !';
    }
    return 'Bonjour !';
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar IA
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: AppColors.assistantAvatarGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.auto_awesome_rounded,
                  color: Colors.white, size: 16),
            ),

            const SizedBox(width: 8),

            // Bulle blanche
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
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
                      border: Border.all(color: AppColors.border, width: 0.5),
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppColors.textPrimary,
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(
                            text: '👋 $_greeting\n',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const TextSpan(
                            text:
                                'Je suis votre assistant intelligent. Comment puis-je vous aider aujourd\'hui ?',
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    'Il y a quelques instants',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textHint,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 40),
          ],
        ),
      ),
    );
  }
}