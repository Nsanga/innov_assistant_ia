import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mobile_assistant_ia/core/di/injection.dart';
import 'package:mobile_assistant_ia/core/router/app_router.dart';
import 'package:mobile_assistant_ia/core/theme/app_theme.dart';
import 'package:mobile_assistant_ia/features/auth/presentation/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('fr_FR', null);
  
  await dotenv.load(fileName: ".env");

  await initDependencies();   // Initialisation de tous les services + repositories + blocs

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
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('fr', 'FR'), // Français
          Locale('en', 'US'), // Anglais (fallback)
        ],
        locale: const Locale('fr', 'FR'),
        routerConfig: appRouter,
      ),
    );
  }
}