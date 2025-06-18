import 'package:coinio_app/core/themes/app_theme.dart';
import 'package:coinio_app/ui/blocs/navigation_bloc/navigation_bloc.dart';
import 'package:coinio_app/ui/widgets/my_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coins IO',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => NavigationBloc(),
        child: const MyScreens(),
      ),
      theme: AppTheme.light,
    );
  }
}
