import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_assistant_ia/core/di/injection.dart';
import 'package:mobile_assistant_ia/features/auth/presentation/bloc/auth_bloc.dart';
import '../../screens/login_screen.dart';
import '../../screens/chat_screen.dart';
import '../../screens/agenda_screen.dart';
import '../../screens/profile_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  redirect: (context, state) {
    final authBloc = getIt<AuthBloc>();
    final isLoggedIn = authBloc.state is AuthSuccess;

    final isGoingToLogin = state.matchedLocation == '/login';

    if (!isLoggedIn && !isGoingToLogin) {
      return '/login';
    }

    if (isLoggedIn && isGoingToLogin) {
      return '/agenda';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
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
);