import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_assistant_ia/core/di/injection.dart';
import 'package:mobile_assistant_ia/features/auth/presentation/bloc/auth_bloc.dart';
import '../screens/login_screen.dart';
import '../screens/chat_screen.dart';
import '../screens/agenda_screen.dart';
import '../screens/profile_screen.dart';
import 'app_shell.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  redirect: (context, state) {
    final authState = getIt<AuthBloc>().state;
    final isLoggedIn = authState is AuthSuccess;
    final isGoingToLogin = state.matchedLocation == '/login';

    if (!isLoggedIn && !isGoingToLogin) return '/login';
    if (isLoggedIn && isGoingToLogin) return '/chat';

    return null;
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