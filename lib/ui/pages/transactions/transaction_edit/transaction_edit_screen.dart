import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransactionEditScreen extends StatelessWidget {
  final String? transactionId;
  final bool isIncome;

  const TransactionEditScreen({
    super.key,
    this.transactionId,
    required this.isIncome,
  });

  @override
  Widget build(final BuildContext context) {
    final isEditing = transactionId != null;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.close),
        ),
        centerTitle: true,
        title: Text(isIncome ? 'Мои доходы' : 'Мои расходы'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.check))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 8),

            MyListTile(
              leadingText: 'Счет',
              trailingWidgets: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Сбербанк',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
              onTap: () {},
            ),
            const Divider(),
            MyListTile(
              leadingText: 'Статья',
              trailingWidgets: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Ремонт',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
              onTap: () {},
            ),
            const Divider(),
            MyListTile(
              leadingText: 'Сумма',
              trailingWidgets: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '25 270 Р',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              onTap: () {},
            ),
            const Divider(),
            MyListTile(
              leadingText: 'Дата',
              trailingWidgets: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '01.01.1970',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              onTap: () {},
            ),
            const Divider(),
            MyListTile(
              leadingText: 'Время',
              trailingWidgets: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '18.41',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              onTap: () {},
            ),
            const Divider(),
            MyListTile(
              leadingText: 'Ремонт, фурнитура для дверей',
              onTap: () {},
            ),
            const Divider(),
            const Spacer(),
            if (isEditing) ...[
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Color.fromARGB(255, 224, 105, 97),
                    ),
                  ),
                  onPressed: () => context.pop(),
                  child: const Text(
                    'Удалить',
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class MyListTile extends StatelessWidget {
  final String leadingText;
  final Widget? trailingWidgets;
  final VoidCallback? onTap;

  const MyListTile({
    required this.leadingText,
    super.key,
    this.trailingWidgets,
    this.onTap,
  });

  @override
  Widget build(final BuildContext context) => ListTile(
    leading: Text(
      leadingText ?? '',
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    ),
    trailing: trailingWidgets,
    onTap: onTap,
  );
}
