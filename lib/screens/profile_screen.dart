import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_assistant_ia/core/constants/app_colors.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/auth/data/models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mon profil"),
        actions: [
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AuthSuccess) {
            final user = state.user;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Header Profile Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1E2937), Color(0xFF334155)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: AppColors.primary,
                          child: Text(
                            user.prenom.isNotEmpty ? user.prenom[0].toUpperCase() : "U",
                            style: const TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          user.fullName,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          user.email,
                          style: const TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.success.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.circle, size: 10, color: AppColors.success),
                              SizedBox(width: 6),
                              Text("Actif maintenant", style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Informations
                  _buildInfoCard("Rôle", user.role, Icons.work),
                  _buildInfoCard("Depuis", 
                    user.createdAt != null 
                      ? DateFormat('MMMM yyyy', 'fr_FR').format(user.createdAt!) 
                      : "Mars 2024", 
                    Icons.calendar_today),
                  _buildInfoCard("Localisation", "Douala, Cameroun (GMT+1)", Icons.location_on),

                  const SizedBox(height: 24),

                  // Activité récente
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Activité récente", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 12),

                  _buildActivityItem("Nouvelle conversation", "Discussion sur le projet Q2 2026", "Il y a 2 heures"),
                  _buildActivityItem("Rapport généré", "Analyse mensuelle des performances", "Il y a 5 heures"),
                  _buildActivityItem("Réunion planifiée", "Briefing équipe - Jeudi 14:00", "Il y a 1 jour"),

                  const SizedBox(height: 32),

                  // Boutons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.download),
                          label: const Text("Exporter"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.edit),
                          label: const Text("Modifier"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }

          return const Center(child: Text("Erreur de chargement du profil"));
        },
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  Widget _buildActivityItem(String title, String subtitle, String time) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: AppColors.primary,
          child: Icon(Icons.chat_bubble_outline, color: Colors.white, size: 20),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Text(time, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      ),
    );
  }
}