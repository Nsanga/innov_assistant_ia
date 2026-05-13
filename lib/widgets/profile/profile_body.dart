import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../features/auth/data/models/user_model.dart';
import 'profile_header.dart';
import 'info_card.dart';
import 'activity_item.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({
    super.key,
    required this.user,
    this.onChat,
    this.onAction,
    this.onSeeAllActivities,
    this.onExport,
    this.onEdit,
    this.onActivityTap,
  });

  final UserModel user;
  final VoidCallback? onChat;
  final VoidCallback? onAction;
  final VoidCallback? onSeeAllActivities;
  final VoidCallback? onExport;
  final VoidCallback? onEdit;
  final void Function(int index)? onActivityTap;

  String get _sinceLabel {
    if (user.createdAt != null) {
      return DateFormat('MMMM yyyy', 'fr_FR').format(user.createdAt!);
    }
    return 'Mars 2024';
  }

  String get _sinceAgo {
    if (user.createdAt != null) {
      final months = DateTime.now().difference(user.createdAt!).inDays ~/ 30;
      return 'Il y a $months mois';
    }
    return 'Il y a 13 mois';
  }

  // Liste des activités récentes
  List<Map<String, dynamic>> get _activities => [
        {
          'icon': Icons.chat_bubble_outline_rounded,
          'iconColor': AppColors.primary,
          'title': 'Nouvelle conversation',
          'subtitle': 'Discussion sur le projet Q2 2026',
          'timeAgo': 'Il y a 2 heures',
        },
        {
          'icon': Icons.trending_up_rounded,
          'iconColor': AppColors.success,
          'title': 'Rapport généré',
          'subtitle': 'Analyse mensuelle des performances',
          'timeAgo': 'Il y a 5 heures',
        },
        {
          'icon': Icons.people_outline_rounded,
          'iconColor': AppColors.violet,
          'title': 'Réunion planifiée',
          'subtitle': 'Briefing équipe - Jeudi 14:00',
          'timeAgo': 'Il y a 1 jour',
        },
      ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Breadcrumb ───────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                const Text(
                  'Compte',
                  style: TextStyle(
                      fontSize: 13, color: AppColors.textSecondary),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Icon(Icons.chevron_right,
                      size: 14, color: AppColors.textHint),
                ),
                const Text(
                  'Mon profil',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // ── Header card ──────────────────────────────────────────────
          ProfileHeader(
            user: user,
            onChat: onChat,
            onAction: onAction,
          ),

          const SizedBox(height: 16),

          // ── Info grid 2×2 ────────────────────────────────────────────
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.3,
            children: [
              InfoCard(
                icon: Icons.work_outline_rounded,
                label: 'Rôle',
                value: user.role ?? 'Directeur',
                valueDetail: 'Niveau 4 · Accès complet',
                valueColor: AppColors.primary,
                valueBackground: AppColors.surfaceBlue,
              ),
              InfoCard(
                icon: Icons.access_time_rounded,
                label: 'Statut',
                value: 'Actif',
                valueDetail: 'En ligne maintenant',
                valueColor: AppColors.success,
                showDot: true,
              ),
              InfoCard(
                icon: Icons.calendar_today_outlined,
                label: 'Depuis',
                value: _sinceLabel,
                valueDetail: _sinceAgo,
              ),
              InfoCard(
                icon: Icons.location_on_outlined,
                label: 'Localisation',
                value: 'Douala',
                valueDetail: 'Cameroun (GMT+1)',
              ),
            ],
          ),

          const SizedBox(height: 20),

          // ── Activité récente ─────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Activité récente',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.3,
                ),
              ),
              TextButton(
                onPressed: onSeeAllActivities,
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('Voir tout',
                    style: TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500)),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Liste des activités
          ...List.generate(_activities.length, (index) {
            final activity = _activities[index];
            return ActivityItem(
              icon: activity['icon'] as IconData,
              iconColor: activity['iconColor'] as Color,
              title: activity['title'] as String,
              subtitle: activity['subtitle'] as String,
              timeAgo: activity['timeAgo'] as String,
              onTap: onActivityTap != null
                  ? () => onActivityTap!(index)
                  : null,
            );
          }),

          const SizedBox(height: 24),

          // ── Boutons footer ───────────────────────────────────────────
          Row(
            children: [
              // Exporter (outline)
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onExport,
                  icon: const Icon(Icons.download_outlined, size: 18),
                  label: const Text('Exporter'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textPrimary,
                    side: const BorderSide(color: AppColors.border),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    textStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Modifier (filled noir)
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  label: const Text('Modifier'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.textPrimary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    textStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}