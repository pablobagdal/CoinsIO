import 'package:coinio_app/core/themes/colors.dart';
import 'package:coinio_app/core/utils/di.dart';
import 'package:coinio_app/core/utils/type_format.dart';
import 'package:coinio_app/domain/models/category/category.dart';
import 'package:coinio_app/domain/models/transaction_response/transaction_response.dart';

import 'package:coinio_app/domain/usecases/category_usecases/category_usecases.dart';
import 'package:coinio_app/domain/usecases/transaction_usecases/transaction_usecases.dart';

import 'package:coinio_app/ui/blocs/category_bloc/category_bloc.dart';
import 'package:coinio_app/ui/blocs/category_bloc/category_event.dart';
import 'package:coinio_app/ui/blocs/category_bloc/category_state.dart';

import 'package:coinio_app/ui/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:coinio_app/ui/blocs/transaction_bloc/transaction_event.dart';
import 'package:coinio_app/ui/blocs/transaction_bloc/transaction_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_package/my_first_package.dart';

class AnalysisPage extends StatelessWidget {
  final bool isIncome;

  const AnalysisPage({super.key, required this.isIncome});

  @override
  Widget build(final BuildContext context) {
    final now = DateTime.now();
    final startDate = DateTime(now.year, now.month - 1, now.day);
    final endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) => TransactionBloc(
                isIncome: isIncome,
                startDate: startDate,
                endDate: endDate,
                getTransactionsByPeriodUsecase:
                    getIt<GetTransactionsByPeriodUsecase>(),
                getTransactionUsecase: getIt<GetTransactionUsecase>(),
                addTransactionUsecase: getIt<AddTransactionUsecase>(),
                deleteTransactionUsecase: getIt<DeleteTransactionUsecase>(),
                updateTransactionUsecase: getIt<UpdateTransactionUsecase>(),
              )..add(LoadTransactions(startDate: startDate, endDate: endDate)),
        ),
        BlocProvider(
          create:
              (_) => CategoryBloc(
                getCategoriesUsecase: getIt<GetCategoriesUsecase>(),
                getCategoryByIdUsecase: getIt<GetCategoryByIdUsecase>(),
                getCategoriesByTypeUsecase: getIt<GetCategoriesByTypeUsecase>(),
              )..add(LoadCategories()),
        ),
      ],

      child: _TransactionsAnalysisView(),
    );
  }
}

class _TransactionsAnalysisView extends StatelessWidget {
  const _TransactionsAnalysisView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Анализ'),
      centerTitle: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    ),
    body: BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, catState) {
        if (catState is CategoryError) {
          return Center(child: Text('Ошибка: ${catState.message}'));
        }
        if (catState is! CategoriesLoaded) {
          return const Center(child: CircularProgressIndicator());
        }
        final categories = catState.categories;

        return BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, txState) {
            if (txState is TransactionLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (txState is TransactionError) {
              return Center(child: Text('Ошибка: ${txState.message}'));
            }
            if (txState is! TransactionsLoaded) {
              return const Center(child: Text('Неизвестное состояние'));
            }
            final transactions = txState.transactions;
            final totalSum = transactions.fold<double>(
              0,
              (sum, tx) => sum + double.parse(tx.amount),
            );
            final categoryById = {for (var cat in categories) cat.id: cat};
            final Map<int, double> sumsByCategoryId = {};
            for (final tx in transactions) {
              sumsByCategoryId[tx.category.id] =
                  (sumsByCategoryId[tx.category.id] ?? 0) +
                  double.parse(tx.amount);
            }
            final sortedEntries =
                sumsByCategoryId.entries.toList()
                  ..sort((a, b) => a.value.compareTo(b.value));

            return ListView(
              children: [
                // Можно вынести в отдельный виджет, если нужно
                _DatePickersAndSummary(
                  totalSum: totalSum,
                  start: txState.startDate,
                  end: txState.endDate,
                  onStartPick: () async {
                    final result = await _pickDate(
                      context,
                      isStart: true,
                      currentStart: txState.startDate,
                      currentEnd: txState.endDate,
                    );
                    if (!context.mounted || result == null) return;
                    final (newStart, newEnd) = result;
                    context.read<TransactionBloc>().add(
                      LoadTransactions(startDate: newStart, endDate: newEnd),
                    );
                  },
                  onEndPick: () async {
                    final result = await _pickDate(
                      context,
                      isStart: false,
                      currentStart: txState.startDate,
                      currentEnd: txState.endDate,
                    );
                    if (!context.mounted || result == null) return;
                    final (newStart, newEnd) = result;
                    context.read<TransactionBloc>().add(
                      LoadTransactions(startDate: newStart, endDate: newEnd),
                    );
                  },
                ),

                Divider(height: 1, color: Theme.of(context).dividerColor),
                if (categories.isEmpty)
                  const Center(child: CircularProgressIndicator())
                else
                  Column(
                    children: [
                      Builder(
                        builder: (context) {
                          final myConfig = ChartConfig(
                            centerSpaceRatio: 0.9,
                            items:
                                sortedEntries
                                    .map(
                                      (entry) => ChartItem(
                                        value: entry.value,
                                        color: colorFromString(
                                          categoryById[entry.key]!.name,
                                        ),
                                        label: categoryById[entry.key]!.name,
                                      ),
                                    )
                                    .toList(),
                          );
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AnimatedPieChart(config: myConfig),
                          );
                        },
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: sortedEntries.length,
                        itemBuilder: (context, index) {
                          final entry = sortedEntries[index];
                          final categoryId = entry.key;
                          final totalAmount = entry.value;
                          final category = categories.firstWhere(
                            (c) => c.id == categoryId,
                          );
                          final percent =
                              totalSum > 0 ? (totalAmount / totalSum * 100) : 0;
                          final categoryTransactions =
                              transactions
                                  .where((tx) => tx.category.id == categoryId)
                                  .toList()
                                ..sort(
                                  (a, b) => b.transactionDate.compareTo(
                                    a.transactionDate,
                                  ),
                                );
                          final lastTransaction =
                              categoryTransactions.isNotEmpty
                                  ? categoryTransactions.first
                                  : null;
                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            title: Text(category.name),
                            subtitle:
                                lastTransaction != null
                                    ? Text(
                                      lastTransaction.comment ?? '',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )
                                    : null,
                            leading: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              radius: 16,
                              child: Text(
                                category.emoji,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${percent.toStringAsFixed(1)}%',
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
                                    ),
                                    Text(
                                      entry.value.toStringAsFixed(2),
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 24),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 16,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                              ],
                            ),
                            onTap: () {
                              _showTransactionsModal(
                                context,
                                category,
                                categoryTransactions,
                              );
                            },
                          );
                        },
                        separatorBuilder:
                            (context, index) => Divider(
                              height: 1,
                              color: Theme.of(context).dividerColor,
                            ),
                      ),
                    ],
                  ),
              ],
            );
          },
        );
      },
    ),
  );

  Future<(DateTime, DateTime)?> _pickDate(
    BuildContext context, {
    required bool isStart,
    required DateTime currentStart,
    required DateTime currentEnd,
  }) async {
    final initialDate = isStart ? currentStart : currentEnd;
    final date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
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

  void _showTransactionsModal(
    BuildContext context,
    Category category,
    List<TransactionResponse> transactions,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder:
          (context) => DraggableScrollableSheet(
            expand: false,
            builder:
                (context, scrollController) => Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Транзакции: ${category.name}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child:
                            transactions.isEmpty
                                ? const Center(child: Text('Нет транзакций'))
                                : ListView.separated(
                                  controller: scrollController,
                                  itemCount: transactions.length,
                                  separatorBuilder: (_, __) => const Divider(),
                                  itemBuilder: (context, index) {
                                    final tx = transactions[index];
                                    return ListTile(
                                      title: Text(tx.comment ?? 'Без описания'),
                                      subtitle: Text(
                                        dateFormat(tx.transactionDate),
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodySmall,
                                      ),
                                      trailing: Text(
                                        '${tx.amount} ${tx.account.currency}',
                                        style: TextStyle(
                                          color:
                                              double.parse(tx.amount) > 0
                                                  ? Colors.green
                                                  : Colors.red,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                      ),
                    ],
                  ),
                ),
          ),
    );
  }
}

/// Пример отдельного виджета для выбора дат и отображения суммы
class _DatePickersAndSummary extends StatelessWidget {
  final double totalSum;
  final DateTime start;
  final DateTime end;
  final VoidCallback onStartPick;
  final VoidCallback onEndPick;

  const _DatePickersAndSummary({
    required this.totalSum,
    required this.start,
    required this.end,
    required this.onStartPick,
    required this.onEndPick,
  });

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Начало'),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.greenbright1,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: onStartPick,
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16),
                      const SizedBox(width: 6),
                      Text('С ${dateFormat(start)}'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(height: 1, color: Theme.of(context).dividerColor),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Конец'),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.greenbright1,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: onEndPick,
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16),
                      const SizedBox(width: 6),
                      Text('По ${dateFormat(end)}'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(height: 1, color: Theme.of(context).dividerColor),
        ],
      ),
      const SizedBox(height: 8),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Сумма'),
            Text('$totalSum ₽', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    ],
  );
}
