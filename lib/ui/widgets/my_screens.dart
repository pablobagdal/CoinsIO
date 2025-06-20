import 'package:coinio_app/domain/models/transaction_response/transaction_response.dart';
import 'package:coinio_app/ui/blocs/navigation_bloc/navigation_bloc.dart';
import 'package:coinio_app/ui/blocs/navigation_bloc/navigation_state.dart';
import 'package:coinio_app/ui/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:coinio_app/ui/blocs/transaction_bloc/transaction_event.dart';
import 'package:coinio_app/ui/blocs/transaction_bloc/transaction_state.dart';
import 'package:coinio_app/ui/pages/accounts_screen.dart';
import 'package:coinio_app/ui/pages/categories_screen.dart';
import 'package:coinio_app/ui/pages/settings_screen.dart';
import 'package:coinio_app/ui/widgets/my_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyScreens extends StatefulWidget {
  const MyScreens({super.key});

  @override
  State<MyScreens> createState() => _MyScreensState();
}

class _MyScreensState extends State<MyScreens> {
  final List<Widget> _screens = [
    FinancialListPage(isIncome: false),
    FinancialListPage(isIncome: true),
    AccountsScreen(),
    CategoriesScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: _screens[state.index],
          // ignore: prefer_const_constructors
          bottomNavigationBar: MyNavigationBar(),
        );
      },
    );
  }
}

class FinancialListPage extends StatefulWidget {
  final bool isIncome;

  const FinancialListPage({super.key, required this.isIncome});

  @override
  State<FinancialListPage> createState() => _FinancialListPageState();
}

class _FinancialListPageState extends State<FinancialListPage> {
  @override
  void initState() {
    super.initState();
    // Request to load all transactions when the page initializes
    BlocProvider.of<TransactionBloc>(context).add(
      LoadTransactionsByPeriod(
        id: 1,
        startDate: DateTime.now().subtract(const Duration(days: 30)),
        endDate: DateTime.now(),
      ),
    );
  }

  // void _addTransaction(BuildContext context) async {
  //   final Transaction? newTransaction = await showDialog<Transaction>(
  //     context: context,
  //     builder: (BuildContext dialogContext) {
  //       return AddTransactionDialog(type: widget.type);
  //     },
  //   );
  //   if (newTransaction != null) {
  //     BlocProvider.of<TransactionBloc>(
  //       context,
  //     ).add(AddTransaction(newTransaction));
  //   }
  // }

  // void _deleteTransaction(BuildContext context, String id) {
  //   BlocProvider.of<TransactionBloc>(context).add(DeleteTransaction(id));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.isIncome ? 'Доходы' : 'Расходы')),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        // listener: (context, state) {
        //   if (state is TransactionError) {
        //     ScaffoldMessenger.of(
        //       context,
        //     ).showSnackBar(SnackBar(content: Text(state.message)));
        //   }
        // },
        builder: (context, state) {
          if (state is TransactionsLoading && state is! TransactionsLoaded) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TransactionError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is TransactionsLoaded) {
            final List<TransactionResponse>
            filteredTransactions =
                // state.transactions.where((t) => t.type == widget.type).toList();
                state.transactions
                    .where((tr) => tr.category.isIncome == widget.isIncome)
                    .toList();

            if (filteredTransactions.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      widget.isIncome
                          ? Icons.monetization_on_outlined
                          : Icons.shopping_cart_outlined,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Сегодня отсутствуют ${widget.isIncome ? 'доходы' : 'расходы'}.',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Нажми + чтобы добавить новую транзакцию.',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            // Sort transactions by date, newest first
            filteredTransactions.sort(
              (a, b) => b.transactionDate.compareTo(a.transactionDate),
            );

            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: filteredTransactions.length,
              itemBuilder: (BuildContext context, int index) {
                final transaction = filteredTransactions[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(
                        widget.isIncome
                            ? Icons.arrow_circle_up
                            : Icons.arrow_circle_down,
                      ),
                    ),
                    title: Text(
                      transaction.category.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${transaction.comment ?? "No comment yet"}', // Display date only
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          '${widget.isIncome ? '+' : '-'}${transaction.amount}${transaction.account.currency}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        // IconButton(
                        //   icon: const Icon(Icons.delete, color: Colors.red),
                        //   onPressed:
                        //       () => _deleteTransaction(context, transaction.id),
                        // ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Loading transactions...'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
