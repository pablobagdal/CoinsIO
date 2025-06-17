import 'package:flutter/material.dart';

class SpendingsScreen extends StatelessWidget {
  const SpendingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Расходы')),
      body: const Center(child: Text('Здесь будут настройки приложения')),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }
}
