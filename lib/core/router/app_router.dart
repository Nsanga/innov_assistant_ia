import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_assistant_ia/features/auth/presentation/bloc/auth_bloc.dart';
import '../../screens/login_screen.dart';
import '../../screens/chat_screen.dart';
import '../../screens/agenda_screen.dart';
import '../../screens/profile_screen.dart';
import 'app_shell.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  redirect: (context, state) {
    // Utiliser le contexte pour accéder au Bloc
    final authBloc = context.read<AuthBloc>();
    final authState = authBloc.state;
    final isLoggedIn = authState is AuthSuccess;
    final isGoingToLogin = state.matchedLocation == '/login';

    debugPrint('🔄 Redirect check - isLoggedIn: $isLoggedIn, location: ${state.matchedLocation}');

    if (!isLoggedIn && !isGoingToLogin) {
      debugPrint('🔒 Non connecté, redirection vers /login');
      return '/login';
    }
    
    if (isLoggedIn && isGoingToLogin) {
      debugPrint('✅ Déjà connecté, redirection vers /chat');
      return '/chat';
    }

    return null; // Pas de redirection nécessaire
  },
  routes: [
    // Login (hors shell)
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),

    // Shell avec Bottom Navigation
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: '/chat',
          builder: (context, state) => const ChatScreen(),
        ),
        GoRoute(
          path: '/agenda',
          builder: (context, state) => const AgendaScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
);