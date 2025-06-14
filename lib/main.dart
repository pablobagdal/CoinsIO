import 'package:coinio_app/core/fonts/my_font_icons.dart';
import 'package:coinio_app/core/themes/app_theme.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coins IO',
      home: const HomeScreen(),
      theme: AppTheme.light,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Coins IO')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Welcome to Coins IO!'),
            ElevatedButton(
              onPressed: () {
                // Placeholder for navigation or action
              },
              child: const Text('Get Started'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyNavigationBar(),
    );
  }
}

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int selectedIndex = 0;

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
      selectedIndex: selectedIndex,
      onDestinationSelected: (value) {
        // Здесь можно добавить логику для переключения между экранами
        setState(() {
          selectedIndex = value;
        });
      },
    );
  }
}
