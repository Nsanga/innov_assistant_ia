import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class OAuthButton extends StatelessWidget {
  const OAuthButton({
    super.key,
    required this.label,
    required this.iconAsset,
    this.onPressed,
    this.iconSize = 20,
  });

  final String label;
  final String iconAsset;
  final VoidCallback? onPressed;
  final double iconSize;

  /// Retourne le chemin de l'image selon le provider
  String get _imagePath {
    switch (iconAsset.toLowerCase()) {
      case 'google':
        return 'assets/images/Google_Icon.png';
      case 'microsoft':
        return 'assets/images/Git_Icon.png';
      default:
        return 'assets/images/Google_Icon.png'; // fallback
    }
  }

  /// Retourne le nom du provider pour le semantic label
  String get _providerName {
    switch (iconAsset.toLowerCase()) {
      case 'google':
        return 'Google';
      case 'microsoft':
        return 'Microsoft';
      default:
        return label;
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        padding: const EdgeInsets.symmetric(vertical: 14),
        side: const BorderSide(color: AppColors.border, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Semantics(
            label: 'Logo $_providerName',
            child: Image.asset(
              _imagePath,
              width: iconSize,
              height: iconSize,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                // Log l'erreur en debug
                debugPrint('❌ Erreur chargement image $_imagePath: $error');
                
                // Fallback sur une icône Material
                return Icon(
                  _getFallbackIcon(),
                  size: iconSize,
                  color: _getFallbackColor(),
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Icône de fallback si l'image n'est pas disponible
  IconData _getFallbackIcon() {
    switch (iconAsset.toLowerCase()) {
      case 'google':
        return Icons.g_mobiledata;
      case 'microsoft':
        return Icons.window;
      default:
        return Icons.login;
    }
  }

  /// Couleur de fallback pour l'icône
  Color _getFallbackColor() {
    switch (iconAsset.toLowerCase()) {
      case 'google':
        return Colors.red;
      case 'microsoft':
        return Colors.blue;
      default:
        return AppColors.primary;
    }
  }
}