// ignore_for_file: prefer_const_constructors

import 'package:coinio_app/core/fonts/my_font_icons.dart';
import 'package:coinio_app/ui/blocs/navigation_bloc/navigation_bloc.dart';
import 'package:coinio_app/ui/blocs/navigation_bloc/navigation_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: [
        NavigationDestination(icon: Icon(MyIcons.spendings), label: 'Расходы'),
        NavigationDestination(icon: Icon(MyIcons.incomes), label: 'Доходы'),
        NavigationDestination(icon: Icon(MyIcons.account), label: 'Счёт'),
        NavigationDestination(icon: Icon(MyIcons.category), label: 'Статьи'),
        NavigationDestination(icon: Icon(MyIcons.settings), label: 'Настройки'),
      ],
      selectedIndex: context.read<NavigationBloc>().state.index,
      onDestinationSelected: (value) {
        // Здесь можно добавить логику для переключения между экранами
        context.read<NavigationBloc>().add(NavigateToTab(value));
      },
    );
  }
}
