import 'package:coinio_app/ui/blocs/navigation_bloc/navigation_bloc.dart';
import 'package:coinio_app/ui/blocs/navigation_bloc/navigation_state.dart';
import 'package:coinio_app/ui/pages/accounts_page.dart';
import 'package:coinio_app/ui/pages/categories_page.dart';
import 'package:coinio_app/ui/pages/transactions/transactions_page.dart';
import 'package:coinio_app/ui/pages/settings_page.dart';
import 'package:coinio_app/ui/widgets/my_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyScreens extends StatefulWidget {
  const MyScreens({super.key});

  @override
  State<MyScreens> createState() => _MyScreensState();
}

class _MyScreensState extends State<MyScreens> {
  final List<Widget> _screens = [
    TransactionsPage(isIncome: false),
    TransactionsPage(isIncome: true),
    AccountsPage(),
    CategoriesPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: _screens[state.index],
          // ignore: prefer_const_constructors
          bottomNavigationBar: MyNavigationBar(),
        );
      },
    );
  }
}
