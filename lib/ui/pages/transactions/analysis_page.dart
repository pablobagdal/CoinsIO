import 'package:coinio_app/core/utils/type_format.dart';
import 'package:coinio_app/data/repositories/mock_category_repository.dart';
import 'package:coinio_app/data/repositories/mock_transaction_repository.dart';
import 'package:coinio_app/domain/models/category/category.dart';
import 'package:coinio_app/domain/models/transaction_response/transaction_response.dart';
import 'package:coinio_app/domain/usecases/categories/get_categories_usecase.dart';
import 'package:coinio_app/domain/usecases/transactions/get_transactions_by_period_usecase.dart';
import 'package:coinio_app/ui/blocs/categories_bloc/categories_bloc.dart';
import 'package:coinio_app/ui/blocs/categories_bloc/categories_event.dart';
import 'package:coinio_app/ui/blocs/categories_bloc/categories_state.dart';
import 'package:coinio_app/ui/blocs/transactions_history_bloc/transactions_history_bloc.dart';
import 'package:coinio_app/ui/blocs/transactions_history_bloc/transactions_history_event.dart';
import 'package:coinio_app/ui/blocs/transactions_history_bloc/transactions_history_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              (_) => TransactionsHistoryBloc(
                getTransactionsByPeriod: GetTransactionsByPeriodUsecase(
                  repository: MockTransactionRepository(),
                ),
                isIncome: isIncome,
                startDate: startDate,
                endDate: endDate,
              )..add(
                LoadTransactionsHistory(startDate: startDate, endDate: endDate),
              ),
        ),
        BlocProvider(
          create:
              (_) => CategoriesBloc(
                getCategoriesUsecase: GetCategoriesUsecase(
                  repository: MockCategoryRepository(),
                ),
              )..add(LoadCategories()),
        ),
      ],

      child: _TransactionsAnalysisView(),
    );
  }
}

class _TransactionsAnalysisView extends StatefulWidget {
  @override
  State<_TransactionsAnalysisView> createState() =>
      _TransactionsAnalysisViewState();
}

class _TransactionsAnalysisViewState extends State<_TransactionsAnalysisView> {
  List<Category> _categories = [];

  late DateTime start;
  late DateTime end;

  // Future<void> _loadCategories() async {
  //   // final categoryRepo = MockedCategoryRepository();

  //   // final cats = await categoryRepo.getAllCategories();
  //   if (mounted) {
  //     setState(() {
  //       _categories = context.read<CategoriesBloc>().state.categories;
  //       // _categories = cats;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    start = DateTime(now.year, now.month - 1, now.day);
    end = DateTime(now.year, now.month, now.day, 23, 59, 59);

    // _loadCategories();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Анализ'),
      centerTitle: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    ),
    body: BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesError) {
          return Center(child: Text('Ошибка: ${state.message}'));
        }
        if (state is CategoriesLoaded) {
          _categories = state.categories;
        }

        return BlocBuilder<TransactionsHistoryBloc, TransactionsHistoryState>(
          builder: (final context, final state) {
            if (state is TransactionsHistoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TransactionsHistoryError) {
              return Center(child: Text('Ошибка: ${state.message}'));
            } else if (state is TransactionsHistoryLoaded) {
              final totalSum = state.transactions.fold<double>(
                0,
                (final sum, final tx) => sum + double.parse(tx.amount),
              );

              final categoryById = {for (var cat in _categories) cat.id: cat};

              final Map<int, double> sumsByCategoryId = {};
              for (final tx in state.transactions) {
                sumsByCategoryId[tx.category.id!] =
                    (sumsByCategoryId[tx.category.id] ?? 0) +
                    double.parse(tx.amount);
              }

              final sortedEntries =
                  sumsByCategoryId.entries.toList()
                    ..sort((final a, final b) => a.value.compareTo(b.value));

              print('count = ${_categories.length}');
              return ListView(
                children: [
                  InkWell(
                    onTap: () async {
                      final result = await _pickDate(
                        context,
                        isStart: true,
                        currentStart: start,
                        currentEnd: end,
                      );
                      if (!context.mounted || result == null) return;

                      final (newStart, newEnd) = result;
                      setState(() {
                        start = newStart;
                        end = newEnd;
                      });

                      context.read<TransactionsHistoryBloc>().add(
                        LoadTransactionsHistory(startDate: start, endDate: end),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Начало'),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(dateFormat(start)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(height: 1, color: Theme.of(context).dividerColor),
                  InkWell(
                    onTap: () async {
                      final result = await _pickDate(
                        context,
                        isStart: false,
                        currentStart: start,
                        currentEnd: end,
                      );
                      if (!context.mounted || result == null) return;

                      final (newStart, newEnd) = result;
                      setState(() {
                        start = newStart;
                        end = newEnd;
                      });

                      context.read<TransactionsHistoryBloc>().add(
                        LoadTransactionsHistory(startDate: start, endDate: end),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Конец'),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(dateFormat(end)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(height: 1, color: Theme.of(context).dividerColor),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Сумма'),
                        Text(
                          '$totalSum ₽',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: Theme.of(context).dividerColor),

                  if (_categories.isEmpty)
                    const Center(child: CircularProgressIndicator())
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: sortedEntries.length,
                      itemBuilder: (final context, final index) {
                        final entry = sortedEntries[index];

                        final categoryId = entry.key;
                        final totalAmount = entry.value;

                        final category = _categories.firstWhere(
                          (final c) => c.id == categoryId,
                        );

                        final percent =
                            totalSum > 0 ? (totalAmount / totalSum * 100) : 0;

                        final categoryTransactions =
                            state.transactions
                                .where(
                                  (final tx) => tx.category.id == categoryId,
                                )
                                .toList()
                              ..sort(
                                (final a, final b) => b.transactionDate
                                    .compareTo(a.transactionDate),
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
                              category.emoji ?? '',
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
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    entry.value.toStringAsFixed(2),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
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
                          (final BuildContext context, final int index) =>
                              Divider(
                                height: 1,
                                color: Theme.of(context).dividerColor,
                              ),
                    ),
                ],
              );
            } else {
              return const Center(child: Text('Неизвестное состояние'));
            }
          },
        );
      },
    ),
  );

  void _showTransactionsModal(
    final BuildContext context,
    final Category category,
    final List<TransactionResponse> transactions,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder:
          (final context) => DraggableScrollableSheet(
            expand: false,
            builder:
                (final context, final scrollController) => Container(
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
                                ? Center(child: Text('Нет транзакций'))
                                : ListView.separated(
                                  controller: scrollController,
                                  itemCount: transactions.length,
                                  separatorBuilder:
                                      (_, final __) => const Divider(),
                                  itemBuilder: (final context, final index) {
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
                                        '${tx.amount} ₽',
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
}
