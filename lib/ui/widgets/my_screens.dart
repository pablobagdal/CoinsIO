import 'package:coinio_app/ui/blocs/navigation_bloc/navigation_bloc.dart';
import 'package:coinio_app/ui/blocs/navigation_bloc/navigation_state.dart';
import 'package:coinio_app/ui/pages/accounts_screen.dart';
import 'package:coinio_app/ui/pages/categories_screen.dart';
import 'package:coinio_app/ui/pages/incomes_screen.dart';
import 'package:coinio_app/ui/pages/settings_screen.dart';
import 'package:coinio_app/ui/pages/spendings_screen.dart';
import 'package:coinio_app/ui/widgets/my_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyScreens extends StatelessWidget {
  final List<Widget> _screens = const [
    SpendingsScreen(),
    IncomesScreen(),
    AccountsScreen(),
    CategoriesScreen(),
    SettingsScreen(),
  ];
  const MyScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          // appBar: AppBar(title: const Text('Coins IO')),
          body: _screens[state.index],
          // ignore: prefer_const_constructors
          bottomNavigationBar: MyNavigationBar(),
        );
      },
    );
  }
}
