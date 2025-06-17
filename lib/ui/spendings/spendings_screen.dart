import 'package:coinio_app/data/repositories/transaction/mock_transaction_repository.dart';
import 'package:coinio_app/domain/models/transaction/transaction.dart';
import 'package:flutter/material.dart';

class SpendingsScreen extends StatelessWidget {
  const SpendingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Расходы сегодня'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.history)),
        ],
      ),
      body: TransactionsBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TransactionsBody extends StatefulWidget {
  const TransactionsBody({super.key});

  @override
  State<TransactionsBody> createState() => _TransactionsBodyState();
}

class _TransactionsBodyState extends State<TransactionsBody> {
  final _repo = MockTransactionRepository();
  late Future<List<Transaction>> _futureTransactions;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

    _futureTransactions = _repo.getTransactionsByPeriod(startOfDay, endOfDay);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('Всего'), Text('436 558 P')],
        ),
        FutureBuilder(
          future: _futureTransactions,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Ошибка: ${snapshot.error}'));
            }
            final transactions = snapshot.data ?? [];
            if (transactions.isEmpty) {
              return const Center(child: Text('Нет транзакций за сегодня'));
            }
            return Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final tx = transactions[index];
                  return Container(
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(width: 0.5)),
                    ),
                    child: ListTile(
                      onTap: () {},
                      leading: const Icon(Icons.abc),
                      title: Text('Название ${tx.categoryId}'),
                      trailing: Row(
                        mainAxisSize:
                            MainAxisSize
                                .min, // чтобы Row не занимал всё пространство
                        children: [
                          Text('Сумма ${tx.amount} P'),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.arrow_forward_ios),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      subtitle: Text(tx.comment ?? 'Описание транзакции'),
                      // isThreeLine: true,
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
