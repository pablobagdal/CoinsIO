import 'package:coinio_app/core/themes/colors.dart';
import 'package:coinio_app/data/repositories/mock_transaction_repository.dart';
import 'package:coinio_app/domain/models/transaction_response/transaction_response.dart';
import 'package:coinio_app/domain/usecases/transactions/get_transactions_by_period_usecase.dart';
import 'package:coinio_app/ui/blocs/transactions_history_bloc/transactions_history_bloc.dart';
import 'package:coinio_app/ui/blocs/transactions_history_bloc/transactions_history_event.dart';
import 'package:coinio_app/ui/blocs/transactions_history_bloc/transactions_history_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsPage extends StatelessWidget {
  final bool isIncome;

  const TransactionsPage({super.key, required this.isIncome});

  // @override
  @override
  Widget build(final BuildContext context) {
    final now = DateTime.now();
    final DateTime startDate = DateTime(now.year, now.month, now.day);
    final DateTime endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);

    return BlocProvider(
      create:
          (final context) => TransactionsHistoryBloc(
            getTransactionsByPeriod: GetTransactionsByPeriodUsecase(
              repository: MockTransactionRepository(),
            ),
            isIncome: isIncome,
            startDate: startDate,
            endDate: endDate,
          )..add(
            LoadTransactionsHistory(startDate: startDate, endDate: endDate),
          ),
      child: _TodayTransactionsView(isIncome: isIncome),
    );
  }
}

class _TodayTransactionsView extends StatelessWidget {
  final bool isIncome;
  const _TodayTransactionsView({required this.isIncome});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(isIncome ? 'Доходы сегодня' : 'Расходы сегодня'),
      centerTitle: true,
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.history_outlined)),
      ],
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        // TODO: переход к созданию транзакции
      },
      child: const Icon(Icons.add),
    ),
    body: BlocBuilder<TransactionsHistoryBloc, TransactionsHistoryState>(
      builder: _todayTransactionsViewBody,
    ),
  );

  Widget _todayTransactionsViewBody(
    final BuildContext context,
    final TransactionsHistoryState state,
  ) {
    if (state is TransactionsHistoryError) {
      // return const Center(child: Text('Ошибка: ${state.message}'));
      return const Center(child: Text('Ошибка: '));
    }

    if (state is TransactionsHistoryLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is TransactionsHistoryLoaded) {
      final trx =
          state.transactions
              .where(
                (final transaction) =>
                    transaction.category.isIncome == isIncome,
              )
              .toList();

      return RefreshIndicator(
        child:
            trx.isEmpty
                ? _TransactionsListEmpty(isIncome: isIncome)
                : _TransactionsList(
                  transactions: trx,
                  onTapTransaction: (_) {},
                  isIncome: isIncome,
                ),
        onRefresh: () async {
          context.read<TransactionsHistoryBloc>().add(
            LoadTransactionsHistory(
              startDate: state.startDate,
              endDate: state.endDate,
            ),
          );
        },
      );
    }

    return const SizedBox();
  }
}

class _TransactionsListEmpty extends StatelessWidget {
  final bool isIncome;
  const _TransactionsListEmpty({required this.isIncome});

  @override
  Widget build(BuildContext context) => ListView(
    physics: const AlwaysScrollableScrollPhysics(),
    children: [
      SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                // context
                //         .findAncestorWidgetOfExactType<TransactionsPage>()!
                //         .isIncome
                isIncome
                    ? 'Здесь будут твои доходы за день'
                    : 'Здесь будут твои расходы за день',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
              Text(
                'Добавь нажатием на плюсик :)',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

class _TransactionsList extends StatelessWidget {
  final bool isIncome;
  final List<TransactionResponse> transactions;
  final void Function(TransactionResponse) onTapTransaction;

  const _TransactionsList({
    required this.isIncome,
    required this.transactions,
    required this.onTapTransaction,
  });

  @override
  Widget build(final BuildContext context) {
    // Sort transactions by date, newest first
    // transactions.sort(
    //   (final a, final b) =>
    //       b.transactionDate.compareTo(a.transactionDate),
    // );
    final totalAmount = transactions.fold<double>(
      0.0,
      (final sum, final item) => sum + double.parse(item.amount),
    );

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          color: AppColors.greenlight1,
          child: Row(
            children: [
              Text('Всего'),
              Text('${totalAmount} ${transactions.first.account.currency}'),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
        Expanded(
          child: ListView.builder(
            // padding: const EdgeInsets.all(8.0),
            itemCount: transactions.length,
            itemBuilder: (final BuildContext context, final int index) {
              final transaction = transactions[index];
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    top:
                        index == 0
                            ? BorderSide(color: AppColors.grey1, width: 1)
                            : BorderSide.none,
                    bottom: BorderSide(color: AppColors.grey1, width: 1),
                  ),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      transaction.category.emoji,
                      style: TextStyle(fontSize: 28),
                    ),
                  ),
                  title: Text(
                    transaction.category.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${transaction.comment ?? ""}', // Display date only
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        '${isIncome ? '+' : '-'}${transaction.amount}${transaction.account.currency}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () {},
                        // () => _deleteTransaction(
                        //   context,
                        //   transaction.id,
                        // ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
