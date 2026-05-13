import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile_assistant_ia/core/constants/app_colors.dart';

class ChatStat extends Equatable {
  final String label;
  final String value;
  final String? subtitle;
  final String? badge;
  final IconData icon;
  final Color iconBackground;
  final Color backgroundColor;
  final Color? badgeColor;
  final Color? badgeTextColor;

  const ChatStat({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconBackground,
    required this.backgroundColor,
    this.subtitle,
    this.badge,
    this.badgeColor,
    this.badgeTextColor,
  });

  factory ChatStat.fromJson(Map<String, dynamic> json) {
    return ChatStat(
      label: json['label'] ?? '',
      value: json['value'] ?? '',
      subtitle: json['subtitle'],
      badge: json['badge'],
      icon: _getIconFromString(json['icon']),
      iconBackground: _getColorFromString(
        json['icon_background'],
        AppColors.primary,
      ),
      backgroundColor: _getColorFromString(
        json['background_color'],
        AppColors.surfaceBlue,
      ),
      badgeColor: json['badge_color'] != null
          ? _getColorFromString(json['badge_color'], null)
          : null,
      badgeTextColor: json['badge_text_color'] != null
          ? _getColorFromString(json['badge_text_color'], null)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'value': value,
      'subtitle': subtitle,
      'badge': badge,
      'icon': _getStringFromIcon(icon),
      'icon_background': iconBackground.value.toRadixString(16),
      'background_color': backgroundColor.value.toRadixString(16),
      'badge_color': badgeColor?.value.toRadixString(16),
      'badge_text_color': badgeTextColor?.value.toRadixString(16),
    };
  }

  ChatStat copyWith({
    String? label,
    String? value,
    String? subtitle,
    String? badge,
    IconData? icon,
    Color? iconBackground,
    Color? backgroundColor,
    Color? badgeColor,
    Color? badgeTextColor,
  }) {
    return ChatStat(
      label: label ?? this.label,
      value: value ?? this.value,
      subtitle: subtitle ?? this.subtitle,
      badge: badge ?? this.badge,
      icon: icon ?? this.icon,
      iconBackground: iconBackground ?? this.iconBackground,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      badgeColor: badgeColor ?? this.badgeColor,
      badgeTextColor: badgeTextColor ?? this.badgeTextColor,
    );
  }

  /// Exemples pré-construits correspondant au design
  static final productivity = ChatStat(
    label: 'Productivité',
    value: '94%',
    icon: Icons.trending_up_rounded,
    iconBackground: AppColors.primary,
    backgroundColor: AppColors.surfaceBlue,
    subtitle: '18 tâches complétées sur 19',
    badge: '+12%',
    badgeColor: AppColors.success.withOpacity(0.15),
    badgeTextColor: AppColors.success,
  );

  static final meetings = ChatStat(
    label: 'Réunions',
    value: '6.5h',
    icon: Icons.calendar_month_rounded,
    iconBackground: AppColors.violet,
    backgroundColor: AppColors.surfaceViolet,
    subtitle: 'Temps moyen : 48 min',
    badge: '8 total',
    badgeColor: AppColors.violet.withOpacity(0.12),
    badgeTextColor: AppColors.violet,
  );

  static final documents = ChatStat(
    label: 'Documents',
    value: '23',
    icon: Icons.description_outlined,
    iconBackground: AppColors.warning,
    backgroundColor: AppColors.surfaceAmber,
    subtitle: 'Créés cette semaine',
    badge: '+5 nouveaux',
    badgeColor: AppColors.warning.withOpacity(0.15),
    badgeTextColor: AppColors.warning,
  );

  /// Liste de tous les exemples de stats pour les suggestions
  static List<ChatStat> get suggestions => [productivity, meetings, documents];

  // Helpers pour la conversion icône <-> string
  static IconData _getIconFromString(String? iconName) {
    switch (iconName) {
      case 'trending_up':
        return Icons.trending_up_rounded;
      case 'calendar':
        return Icons.calendar_month_rounded;
      case 'description':
        return Icons.description_outlined;
      case 'auto_awesome':
        return Icons.auto_awesome_rounded;
      default:
        return Icons.info_outline_rounded;
    }
  }

  static String _getStringFromIcon(IconData icon) {
    if (icon == Icons.trending_up_rounded) return 'trending_up';
    if (icon == Icons.calendar_month_rounded) return 'calendar';
    if (icon == Icons.description_outlined) return 'description';
    if (icon == Icons.auto_awesome_rounded) return 'auto_awesome';
    return 'info';
  }

  static Color _getColorFromString(String? colorHex, Color? defaultColor) {
    if (colorHex == null || colorHex.isEmpty) {
      return defaultColor ?? AppColors.primary;
    }
    try {
      return Color(int.parse(colorHex, radix: 16));
    } catch (e) {
      return defaultColor ?? AppColors.primary;
    }
  }

  @override
  List<Object?> get props => [
        label,
        value,
        subtitle,
        badge,
        icon,
        iconBackground,
        backgroundColor,
        badgeColor,
        badgeTextColor,
      ];
}