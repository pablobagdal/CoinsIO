import 'package:coinio_app/core/themes/colors.dart';
import 'package:coinio_app/core/utils/type_format.dart';
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

  @override
  Widget build(final BuildContext context) {
    final now = DateTime.now();
    final DateTime startDate = DateTime(now.year, now.month - 1, now.day);
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
    final sign = transactions.first.account.currency;

    return Column(
      children: [
        _buildDatePickerRow(
          context,
          startDate: context.read<TransactionsHistoryBloc>().state.startDate,
          endDate: context.read<TransactionsHistoryBloc>().state.endDate,
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
            children: [
              const Text('Сумма'),
              Text('${totalSum.toString()} $sign'),
            ],
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

  Future<(DateTime, DateTime)?> _pickDate(
    final BuildContext context, {
    required final bool isStart,
    required final DateTime currentStart,
    required final DateTime currentEnd,
  }) async {
    final initialDate = isStart ? currentStart : currentEnd;

    final date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date == null) return null;

    DateTime newStart = currentStart;
    DateTime newEnd = currentEnd;

    if (isStart) {
      newStart = DateTime(date.year, date.month, date.day);
      if (newStart.isAfter(newEnd)) {
        newEnd = DateTime(date.year, date.month, date.day, 23, 59, 59);
      }
    } else {
      newEnd = DateTime(date.year, date.month, date.day, 23, 59, 59);
      if (newEnd.isBefore(newStart)) {
        newStart = DateTime(date.year, date.month, date.day);
      }
    }

    return (newStart, newEnd);
  }

  Widget _datePickerWidget(
    BuildContext context, {
    required final DateTime startDate,
    required final DateTime endDate,
    required final bool isStart,
  }) {
    return InkWell(
      onTap: () async {
        final pickedDates = await _pickDate(
          context,
          isStart: isStart,
          currentStart: startDate,
          currentEnd: endDate,
        );

        if (!context.mounted || pickedDates == null) return;

        final (newStartDate, newEndDate) = pickedDates;

        if (newStartDate == startDate && newEndDate == endDate) return;

        context.read<TransactionsHistoryBloc>().add(
          LoadTransactionsHistory(startDate: newStartDate, endDate: newEndDate),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        // color: Theme.of(context).colorScheme.secondary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isStart ? const Text('Начало') : const Text('Конец'),
            Text(dateFormat(isStart ? startDate : endDate)),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePickerRow(
    BuildContext context, {
    required final DateTime startDate,
    required final DateTime endDate,
  }) {
    return Column(
      children: [
        _datePickerWidget(
          context,
          startDate: startDate,
          endDate: endDate,
          isStart: true,
        ),
        _datePickerWidget(
          context,
          startDate: startDate,
          endDate: endDate,
          isStart: false,
        ),
      ],
    );
  }

  // Widget _sortTransactionsDropdownWidget(BuildContext context, {required final SortState sortState}) {

  // }
}
