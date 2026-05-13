import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../core/constants/app_colors.dart';
import '../widgets/hero_section.dart';
import '../widgets/login_card.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController(text: '');
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.go('/chat');
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red.shade700,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(gradient: AppColors.loginGradient),
            child: SafeArea(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HeroSection(),
                        const SizedBox(height: 32),
                        Expanded(
                          child: LoginCard(
                            emailController: _emailController,
                            passwordController: _passwordController,
                            obscurePassword: _obscurePassword,
                            rememberMe: _rememberMe,
                            isLoading: state is AuthLoading,
                            onToggleObscure: () =>
                                setState(() => _obscurePassword = !_obscurePassword),
                            onToggleRemember: (v) =>
                                setState(() => _rememberMe = v ?? true),
                            onSubmit: () {
                              context.read<AuthBloc>().add(
                                    LoginSubmitted(
                                      _emailController.text.trim(),
                                      _passwordController.text,
                                    ),
                                  );
                            },
                            onForgotPassword: () {
                              // TODO: Implémenter la récupération de mot de passe
                            },
                            onOAuthGoogle: () {
                              // TODO: Implémenter l'authentification Google
                            },
                            onOAuthMicrosoft: () {
                              // TODO: Implémenter l'authentification Microsoft
                            },
                            onRequestAccess: () {
                              // TODO: Implémenter la demande d'accès
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}