import 'package:coinio_app/theme/app_theme.dart';
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
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Главная'),
          NavigationDestination(
            icon: Icon(Icons.account_balance),
            label: 'Счета',
          ),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Настройки'),
        ],
        selectedIndex: 0,
        onDestinationSelected: (value) {
          // обработчик нажатия пока пустой
          // Здесь можно добавить логику для переключения между экранами
        },
      ),
    );
  }
}
