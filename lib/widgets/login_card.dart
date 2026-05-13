import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'field_label.dart';
import 'innov_text_field.dart';
import 'oauth_button.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.rememberMe,
    required this.isLoading,
    required this.onToggleObscure,
    required this.onToggleRemember,
    required this.onSubmit,
    this.onForgotPassword,
    this.onOAuthGoogle,
    this.onOAuthMicrosoft,
    this.onRequestAccess,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final bool rememberMe;
  final bool isLoading;
  final VoidCallback onToggleObscure;
  final ValueChanged<bool?> onToggleRemember;
  final VoidCallback onSubmit;
  final VoidCallback? onForgotPassword;
  final VoidCallback? onOAuthGoogle;
  final VoidCallback? onOAuthMicrosoft;
  final VoidCallback? onRequestAccess;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            'Connexion',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Entrez vos identifiants pour accéder à votre espace.',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),

          const SizedBox(height: 28),

          // Email
          const FieldLabel(label: 'Adresse e-mail'),
          const SizedBox(height: 8),
          InnovTextField(
            controller: emailController,
            hintText: 'votre@email.com',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 20),

          // Password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const FieldLabel(label: 'Mot de passe'),
              GestureDetector(
                onTap: onForgotPassword,
                child: const Text(
                  'Mot de passe oublié ?',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          InnovTextField(
            controller: passwordController,
            hintText: '••••••••••••',
            prefixIcon: Icons.lock_outline,
            obscureText: obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 20,
                color: AppColors.textSecondary,
              ),
              onPressed: onToggleObscure,
            ),
          ),

          const SizedBox(height: 16),

          // Remember me
          Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  value: rememberMe,
                  onChanged: onToggleRemember,
                  activeColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  side: const BorderSide(color: AppColors.border, width: 1.5),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Se souvenir de moi pendant 30 jours',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
            ],
          ),

          const SizedBox(height: 28),

          // Submit button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: isLoading ? null : onSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.textPrimary,
                foregroundColor: Colors.white,
                disabledBackgroundColor: AppColors.textPrimary.withOpacity(0.5),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Se connecter',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.2,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, size: 18),
                      ],
                    ),
            ),
          ),

          const SizedBox(height: 24),

          // Divider
          Row(
            children: [
              const Expanded(child: Divider(color: AppColors.border)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'OU CONTINUEZ AVEC',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textHint,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
              const Expanded(child: Divider(color: AppColors.border)),
            ],
          ),

          const SizedBox(height: 16),

          // OAuth buttons
          Row(
            children: [
              Expanded(
                child: OAuthButton(
                  label: 'Google',
                  iconAsset: 'google',
                  onPressed: onOAuthGoogle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OAuthButton(
                  label: 'Microsoft',
                  iconAsset: 'microsoft',
                  onPressed: onOAuthMicrosoft,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Register
          Center(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                    fontSize: 14, color: AppColors.textSecondary),
                children: [
                  const TextSpan(text: "Pas encore de compte ? "),
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: onRequestAccess,
                      child: const Text(
                        'Demander un accès',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}