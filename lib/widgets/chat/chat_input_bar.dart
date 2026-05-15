import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class ChatInputBar extends StatelessWidget {
  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
    this.onAttach,
    this.onVoice,
  });

  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback? onAttach;
  final VoidCallback? onVoice;

  static const double _buttonSize = 40.0;
  static const double _gap = 8.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.border, width: 0.5)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // ── Container principal — sans fond ──────────────────────
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border, width: 1),
                ),
                padding: const EdgeInsets.only(
                    top: 12, left: 14, right: 14, bottom: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Zone de saisie
                    TextField(
                      controller: controller,
                      maxLines: null,
                      minLines: 1,
                      textInputAction: TextInputAction.newline,
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.textPrimary,
                        height: 1.4,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Posez votre question...',
                        hintStyle: TextStyle(
                          color: AppColors.textHint,
                          fontSize: 15,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Icônes bas gauche
                    Row(
                      children: [
                        GestureDetector(
                          onTap: onAttach ?? () {},
                          child: const Icon(Icons.attach_file_rounded,
                              size: 22, color: AppColors.textSecondary),
                        ),
                        const SizedBox(width: 14),
                        GestureDetector(
                          onTap: onVoice ?? () {},
                          child: const Icon(Icons.mic_none_rounded,
                              size: 22, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: _gap),

            // ── Bouton envoi — carré aux coins arrondis, flèche ↗ ────
            GestureDetector(
              onTap: onSend,
              child: Container(
                width: _buttonSize,
                height: _buttonSize,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Transform.rotate(
                  angle: -0.785398,
                  child: const Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}