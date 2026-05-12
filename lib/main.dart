import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_assistant_ia/core/di/injection.dart';
import 'package:mobile_assistant_ia/core/router/app_router.dart';
import 'package:mobile_assistant_ia/core/theme/app_theme.dart';
import 'package:mobile_assistant_ia/features/auth/presentation/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>()..add(const LoadUser()),
      child: MaterialApp.router(
        title: 'Inov AI Assistant',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: appRouter,
      ),
    );
  }
}