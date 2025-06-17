import 'package:coinio_app/core/fonts/my_font_icons.dart';
import 'package:coinio_app/core/themes/app_theme.dart';
import 'package:coinio_app/ui/accounts/accounts_screen.dart';
import 'package:coinio_app/ui/categories/categories_screen.dart';
import 'package:coinio_app/ui/incomes/incomes_screen.dart';
import 'package:coinio_app/ui/settings/settings_screen.dart';
import 'package:coinio_app/ui/spendings/spendings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coins IO',
      home: BlocProvider(
        create: (context) => NavigationBloc(),
        child: const HomeScreen(),
      ),
      theme: AppTheme.light,
    );
  }
}

abstract class NavigationEvent {}

class NavigateToTab extends NavigationEvent {
  final int index;
  NavigateToTab(this.index);
}

class NavigationState {
  final int index;

  NavigationState({required this.index});
}

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState(index: 0)) {
    on<NavigateToTab>((event, emit) {
      emit(NavigationState(index: event.index));
    });
  }
}

class HomeScreen extends StatelessWidget {
  final List<Widget> _screens = const [
    SpendingsScreen(),
    IncomesScreen(),
    AccountsScreen(),
    CategoriesScreen(),
    SettingsScreen(),
  ];
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Coins IO')),
          body: _screens[state.index],
          bottomNavigationBar: MyNavigationBar(),
        );
      },
    );
  }
}

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: const [
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
