import 'package:coinio_app/core/themes/colors.dart';
import 'package:coinio_app/ui/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:coinio_app/ui/blocs/transaction_bloc/transaction_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryListPage extends StatelessWidget {
  final bool isIncome;
  const HistoryListPage({super.key, required this.isIncome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Моя история')),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.greenlight1,
                border: Border(
                  bottom: BorderSide(color: AppColors.grey1, width: 1),
                ),
              ),
              child: Row(
                children: [Text('Начало'), Text('date')],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.greenlight1,
                border: Border(
                  bottom: BorderSide(color: AppColors.grey1, width: 1),
                ),
              ),
              child: Row(
                children: [Text('Конец'), Text('date')],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.greenlight1,
                border: Border(
                  bottom: BorderSide(color: AppColors.grey1, width: 1),
                ),
              ),
              child: Row(
                children: [Text('Сумма'), Text('date')],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ),
          ),
          BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
              if (state is TransactionsLoaded) {
                final transactions = state.transactions;
                return Expanded(
                  child: ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) => Text("${index} :)"),
                  ),
                );
              } else {
                return Text("Not supported TransactionState");
              }
            },
          ),
        ],
      ),
    );
  }
}
