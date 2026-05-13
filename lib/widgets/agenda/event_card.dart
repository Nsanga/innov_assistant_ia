import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../features/agenda/data/models/event_model.dart';
import 'event_details_sheet.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.event, this.onJoin});
  
  final EventModel event;
  final VoidCallback? onJoin;

  Color get _accentColor {
    switch (event.colorTag) {
      case 'violet':
        return AppColors.violet;
      case 'green':
        return AppColors.success;
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Bordure gauche colorée
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: _accentColor,
                borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(16)),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Titre + dot
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            event.title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _accentColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Heure
                    _buildInfoRow(
                      icon: Icons.access_time_rounded,
                      text: event.time,
                    ),

                    if (event.location != null &&
                        event.location!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      _buildInfoRow(
                        icon: Icons.location_on_outlined,
                        text: event.location!,
                      ),
                    ],

                    if (event.participants != null &&
                        event.participants!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      _buildInfoRow(
                        icon: Icons.people_outline_rounded,
                        text: event.participants!,
                      ),
                    ],

                    const SizedBox(height: 12),

                    // Boutons
                    Row(
                      children: [
                        // Détails (outline)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () =>
                                EventDetailsSheet.show(context, event),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.textPrimary,
                              side: const BorderSide(
                                  color: AppColors.border, width: 1),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text(
                              'Détails',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Rejoindre (filled)
                        Expanded(
                          child: ElevatedButton(
                            onPressed: onJoin ?? () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _accentColor,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text(
                              'Rejoindre',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, size: 13, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}