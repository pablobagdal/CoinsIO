import 'package:coinio_app/core/themes/colors.dart';
import 'package:coinio_app/data/repositories/mock_transaction_repository.dart';
import 'package:coinio_app/domain/models/transaction_response/transaction_response.dart';
import 'package:coinio_app/domain/usecases/transactions/get_transactions_by_period_usecase.dart';
import 'package:coinio_app/ui/blocs/transactions_history_bloc/transactions_history_bloc.dart';
import 'package:coinio_app/ui/blocs/transactions_history_bloc/transactions_history_event.dart';
import 'package:coinio_app/ui/blocs/transactions_history_bloc/transactions_history_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsHistoryPage extends StatelessWidget {
  final bool isIncome;
  const TransactionsHistoryPage({super.key, required this.isIncome});

  // Future<void> _pickDate(
  //   final BuildContext context,
  //   final bool isFrom,
  //   final DateTime initial,
  // ) async {
  //   final picked = await showDatePicker(
  //     context: context,
  //     initialDate: initial,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime.now(),
  //   );
  //   if (picked != null) {
  //     // if (context.mounted) {}
  //     final bloc = context.read<TransactionsHistoryBloc>();
  //     final state = bloc.state;
  //     if (state is TransactionsHistoryLoaded) {
  //       DateTime from =
  //           isFrom
  //               ? DateTime(picked.year, picked.month, picked.day, 0, 0, 0)
  //               : state.startDate;
  //       DateTime to =
  //           !isFrom
  //               ? DateTime(picked.year, picked.month, picked.day, 23, 59, 59)
  //               : state.endDate;

  //       // Корректировка границ периода
  //       if (from.isAfter(to)) {
  //         if (isFrom) {
  //           to = from;
  //         } else {
  //           from = to;
  //         }
  //       }

  //       // bloc.add(
  //       //   ChangePeriod(startDate: from, endDate: to, isIncome: widget.isIncome),
  //       // );
  //     }
  //   }
  // }

  @override
  Widget build(final BuildContext context) {
    final now = DateTime.now();
    final startDate = DateTime(now.year, now.month - 1, now.day);
    final endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);

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
      child: _TransactionsHistoryView(),
    );
  }
}

class _TransactionsHistoryView extends StatelessWidget {
  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Моя история')),
    body: BlocBuilder<TransactionsHistoryBloc, TransactionsHistoryState>(
      builder: (final context, final state) {
        if (state is TransactionsHistoryLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is TransactionsHistoryError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }

        if (state is TransactionsHistoryLoaded) {
          return _TransactionsHistoryViewBody(
            transactions: state.transactions,
            isIncome: context.read<TransactionsHistoryBloc>().isIncome,
          );
        }

        return const SizedBox.shrink();
      },
    ),
  );
}

class _TransactionsHistoryViewBody extends StatelessWidget {
  final List<TransactionResponse> transactions;
  final bool isIncome;

  const _TransactionsHistoryViewBody({
    required this.transactions,
    required this.isIncome,
  });

  @override
  Widget build(final BuildContext context) {
    final totalSum = transactions.fold<double>(
      0.0,
      (final sum, final tr) => sum + double.parse(tr.amount),
    );

    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          // onTap: () => _pickDate(context, true, state.startDate),
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.greenlight1,
              border: Border(
                bottom: BorderSide(color: AppColors.grey1, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Начало'),
                Text(
                  // '${state.startDate.day.toString().padLeft(2, '0')}.${state.startDate.month.toString().padLeft(2, '0')}.${state.startDate.year}',
                  'text123',
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          // onTap: () => _pickDate(context, false, state.endDate),
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.greenlight1,
              border: Border(
                bottom: BorderSide(color: AppColors.grey1, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Конец'),
                Text(
                  // '${state.endDate.day.toString().padLeft(2, '0')}.${state.endDate.month.toString().padLeft(2, '0')}.${state.endDate.year}',
                  'te12',
                ),
              ],
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: AppColors.greenlight1,
            border: Border(
              bottom: BorderSide(color: AppColors.grey1, width: 1),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [const Text('Сумма'), Text('${totalSum.toString()} RUB')],
          ),
        ),
        //               // Row(
        //               //   mainAxisAlignment: MainAxisAlignment.end,
        //               //   children: [
        //               //     TransactionsHistorySortDropDown(
        //               //       value: state.sort,
        //               //       onChanged: (final sort) {
        //               //         if (sort != null) {
        //               //           context.read<TransactionsHistoryBloc>().add(
        //               //             ChangeSort(sort),
        //               //           );
        //               //         }
        //               //       },
        //               //     ),
        //               //   ],
        //               // ),
        Expanded(
          child:
              transactions.isEmpty
                  ? const Center(child: Text('Нет данных за данный период'))
                  : ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder:
                        (final context, final index) => Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top:
                                  index == 0
                                      ? const BorderSide(
                                        color: AppColors.grey1,
                                        width: 1,
                                      )
                                      : BorderSide.none,
                              bottom: const BorderSide(
                                color: AppColors.grey1,
                                width: 1,
                              ),
                            ),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(
                                transactions[index].category.emoji,
                                style: const TextStyle(fontSize: 28),
                              ),
                            ),
                            title: Text(
                              transactions[index].category.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              transactions[index].comment ??
                                  '', // Display date only
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  '${isIncome ? '+' : '-'}${transactions[index].amount}${transactions[index].account.currency}',
                                  style: const TextStyle(
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
                        ),
                  ),
        ),
      ],
    );
  }
}
