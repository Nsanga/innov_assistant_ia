import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_assistant_ia/core/constants/app_colors.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/auth/data/models/user_model.dart';
import '../widgets/profile/profile_body.dart';
import '../widgets/app_bars/profile_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: ProfileAppBar(
        onNotifications: () {
          // TODO: Ouvrir les notifications
        },
        onSettings: () {
          // TODO: Ouvrir les paramètres
        },
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state is AuthSuccess) {
            return ProfileBody(
              user: state.user,
              onChat: () {
                // TODO: Ouvrir le chat
              },
              onAction: () {
                // TODO: Action rapide
              },
              onSeeAllActivities: () {
                // TODO: Voir toutes les activités
              },
              onExport: () {
                // TODO: Exporter le profil
              },
              onEdit: () {
                // TODO: Modifier le profil
              },
              onActivityTap: (index) {
                // TODO: Gérer le tap sur une activité
                debugPrint('Activité $index tapée');
              },
            );
          }

          return const Center(
            child: Text(
              'Erreur de chargement du profil',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          );
        },
      ),
    );
  }
}