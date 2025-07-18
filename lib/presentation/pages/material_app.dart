import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coinio_app/core/app_router.dart';
import 'package:coinio_app/core/app_themes.dart';
import 'package:coinio_app/l10n/gen/app_localizations.dart';
import 'package:coinio_app/presentation/blocs/material_app_cubit.dart';

class FinanceApp extends StatelessWidget {
  const FinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MaterialAppCubit()..loadFromSharedPreferences(),
      child: _BlocedFinanceApp(key: key),
    );
  }
}

class _BlocedFinanceApp extends StatelessWidget {
  const _BlocedFinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: context.watch<MaterialAppCubit>().locale,
      themeMode: context.watch<MaterialAppCubit>().themeMode,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
    );
  }
}
