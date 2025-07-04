import 'package:coinio_app/core/themes/colors.dart';
import 'package:coinio_app/core/utils/di.dart';
import 'package:coinio_app/core/utils/type_format.dart';
import 'package:coinio_app/domain/models/transaction_response/transaction_response.dart';
import 'package:coinio_app/domain/usecases/transaction_usecases/transaction_usecases.dart';
import 'package:coinio_app/ui/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:coinio_app/ui/blocs/transaction_bloc/transaction_event.dart';
import 'package:coinio_app/ui/blocs/transaction_bloc/transaction_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
          (final context) => TransactionBloc(
            isIncome: isIncome,
            startDate: startDate,
            endDate: endDate,
            getTransactionUsecase: getIt<GetTransactionUsecase>(),
            getTransactionsByPeriodUsecase:
                getIt<GetTransactionsByPeriodUsecase>(),
            addTransactionUsecase: getIt<AddTransactionUsecase>(),
            deleteTransactionUsecase: getIt<DeleteTransactionUsecase>(),
            updateTransactionUsecase: getIt<UpdateTransactionUsecase>(),
          )..add(LoadTransactions(startDate: startDate, endDate: endDate)),
      child: _TransactionsHistoryView(isIncome: isIncome),
    );
  }
}

class _TransactionsHistoryView extends StatelessWidget {
  final bool isIncome;
  const _TransactionsHistoryView({required this.isIncome});

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Моя история'),
      actions: [
        IconButton(
          onPressed: () {
            context.go(
              isIncome
                  ? '/incomes/history/analysis'
                  : '/expenses/history/analysis',
            );
          },
          icon: const Icon(Icons.av_timer_rounded),
        ),
      ],
    ),
    body: BlocBuilder<TransactionBloc, TransactionState>(
      builder: (final context, final state) {
        if (state is TransactionLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is TransactionError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }

        if (state is TransactionsLoaded) {
          return _TransactionsHistoryViewBody(
            transactions: state.transactions,
            isIncome: context.read<TransactionBloc>().isIncome,
            startDate: state.startDate,
            endDate: state.endDate,
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
  final DateTime startDate;
  final DateTime endDate;

  const _TransactionsHistoryViewBody({
    required this.transactions,
    required this.isIncome,
    required this.startDate,
    required this.endDate,
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
        _buildDatePickerRow(context, startDate: startDate, endDate: endDate),
        Container(
          decoration: const BoxDecoration(
            color: AppColors.greenlight1,
            border: Border(
              bottom: BorderSide(color: AppColors.grey1, width: 1),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Сумма'),
                Text('${totalSum.toString()} $sign'),
              ],
            ),
          ),
        ),
        Expanded(
          child:
              transactions.isEmpty
                  ? const Center(child: Text('Нет данных за данный период'))
                  : ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (final context, final index) {
                      final transaction = transactions[index];

                      return Container(
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
                            style: const TextStyle(fontWeight: FontWeight.bold),
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
                                onPressed: () {
                                  context.go(
                                    isIncome
                                        ? '/incomes/history/transaction-edit?id=${transaction.id}'
                                        : '/expenses/history/transaction-edit?id=${transaction.id}',
                                  );
                                },
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
  }) => InkWell(
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

      context.read<TransactionBloc>().add(
        LoadTransactions(startDate: newStartDate, endDate: newEndDate),
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

  Widget _buildDatePickerRow(
    BuildContext context, {
    required final DateTime startDate,
    required final DateTime endDate,
  }) => Column(
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

  // Widget _sortTransactionsDropdownWidget(BuildContext context, {required final SortState sortState}) {

  // }
}
