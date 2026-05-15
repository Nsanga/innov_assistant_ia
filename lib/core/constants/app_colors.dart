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
  static const chatUser = Color(0xFF0066FF);

  /// Fond bulle assistant
  static const chatAssistant = Color(0xFFF1F5F9);
  static const assistantAvatarGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0066FF), // 0%
      Color(0xFF0071FF), // 7.69%
      Color(0xFF007BFF), // 15.38%
      Color(0xFF0085FF), // 23.08%
      Color(0xFF008FFF), // 30.77%
      Color(0xFF0099FF), // 38.46%
      Color(0xFF00A2FF), // 46.15%
      Color(0xFF00ABFF), // 53.85%
      Color(0xFF00B4FF), // 61.54%
      Color(0xFF00BDFF), // 69.23%
      Color(0xFF00C6FF), // 76.92%
      Color(0xFF00CFFF), // 84.62%
      Color(0xFF00D7FF), // 92.31%
      Color(0xFF00E0FF), // 100%
    ],
    stops: [
      0.0,
      0.0769,
      0.1538,
      0.2308,
      0.3077,
      0.3846,
      0.4615,
      0.5385,
      0.6154,
      0.6923,
      0.7692,
      0.8462,
      0.9231,
      1.0,
    ],
  );

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