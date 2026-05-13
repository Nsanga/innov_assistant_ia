import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Brand primaries ────────────────────────────────────────────────────────
  /// Bleu principal – boutons "Rejoindre", CTA login, tab actif agenda
  static const primary = Color(0xFF0066FF);

  /// Violet – events "Revue projet", accent secondaire
  static const violet = Color(0xFF7C3AED);

  /// Vert – events "Point 1-1", statut actif
  static const success = Color(0xFF10B981);

  /// Orange – dot d'événement "Présentation client"
  static const warning = Color(0xFFF97316);

  // ── Login screen (hero dark gradient) ─────────────────────────────────────
  /// Fond haut du gradient login (navy profond)
  static const loginGradientTop = Color(0xFF0F172A);

  /// Fond bas du gradient login (slate)
  static const loginGradientBottom = Color(0xFF1E293B);

  /// Texte accentué du hero – "sans friction"
  static const loginAccentText = Color(0xFF00E0FF);

  // ── Surfaces & backgrounds ─────────────────────────────────────────────────
  static const background = Color(0xFFF8FAFC);
  static const surface = Color(0xFFFFFFFF);

  /// Surface des cards de stat (chat assistant)
  static const surfaceBlue = Color(0xFFEFF6FF);
  static const surfaceViolet = Color(0xFFF5F3FF);
  static const surfaceAmber = Color(0xFFFFFBEB);

  // ── Text ───────────────────────────────────────────────────────────────────
  static const textPrimary = Color(0xFF0F172A);
  static const textSecondary = Color(0xFF64748B);
  static const textHint = Color(0xFF94A3B8);
  static const textOnDark = Color(0xFFFFFFFF);
  static const textOnDarkMuted = Color(0xFF94A3B8);

  // ── Borders ────────────────────────────────────────────────────────────────
  static const border = Color(0xFFE2E8F0);
  static const borderFocus = Color(0xFF2563EB);

  // ── Chat ───────────────────────────────────────────────────────────────────
  /// Bulle utilisateur
  static const chatUser = Color(0xFF2563EB);

  /// Fond bulle assistant
  static const chatAssistant = Color(0xFFF1F5F9);

  // ── Bottom navigation ──────────────────────────────────────────────────────
  /// Tab actif (fond noir de l'icône active)
  static const navActive = Color(0xFF0F172A);
  static const navInactive = Color(0xFF94A3B8);

  // ── Gradients ──────────────────────────────────────────────────────────────
  static const loginGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [loginGradientTop, loginGradientBottom],
  );

  // ── Event left-border colors ───────────────────────────────────────────────
  static const eventBlue = Color(0xFF2563EB);
  static const eventViolet = Color(0xFF7C3AED);
  static const eventGreen = Color(0xFF10B981);

  // ── Logo / Avatar ──────────────────────────────────────────────────────────
  static const logoBackground = Color(0xFF2563EB);
  static const aiAvatarBackground = Color(0xFF2563EB);
}