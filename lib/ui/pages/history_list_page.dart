import 'package:coinio_app/core/themes/colors.dart';
import 'package:coinio_app/ui/blocs/history_bloc/history_bloc.dart';
import 'package:coinio_app/ui/blocs/history_bloc/history_event.dart';
import 'package:coinio_app/ui/blocs/history_bloc/history_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryListPage extends StatefulWidget {
  final bool isIncome;
  const HistoryListPage({super.key, required this.isIncome});

  @override
  State<HistoryListPage> createState() => _HistoryListPageState();
}

class _HistoryListPageState extends State<HistoryListPage> {
  Future<void> _pickDate(
    BuildContext context,
    bool isFrom,
    DateTime initial,
  ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      final bloc = context.read<HistoryBloc>();
      final state = bloc.state;
      if (state is HistoryLoaded) {
        DateTime from =
            isFrom
                ? DateTime(picked.year, picked.month, picked.day, 0, 0, 0)
                : state.startDate;
        DateTime to =
            !isFrom
                ? DateTime(picked.year, picked.month, picked.day, 23, 59, 59)
                : state.endDate;
        bloc.add(
          ChangePeriod(startDate: from, endDate: to, isIncome: widget.isIncome),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<HistoryBloc>().add(LoadHistory(isIncome: widget.isIncome));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        if (state is HistoryLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is HistoryError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }
        if (state is! HistoryLoaded) {
          return const SizedBox.shrink();
        }

        final transactions = state.transactions;

        return Scaffold(
          appBar: AppBar(
            title: Text('Моя история'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.playlist_add_check_rounded,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ],
          ),
          body: Column(
            children: [
              GestureDetector(
                onTap: () => _pickDate(context, true, state.startDate),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.greenlight1,
                    border: Border(
                      bottom: BorderSide(color: AppColors.grey1, width: 1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text('Начало'),
                      Text(
                        '${state.startDate.day.toString().padLeft(2, '0')}.${state.startDate.month.toString().padLeft(2, '0')}.${state.startDate.year}',
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _pickDate(context, false, state.endDate),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.greenlight1,
                    border: Border(
                      bottom: BorderSide(color: AppColors.grey1, width: 1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text('Конец'),
                      Text(
                        '${state.endDate.day.toString().padLeft(2, '0')}.${state.endDate.month.toString().padLeft(2, '0')}.${state.endDate.year}',
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.greenlight1,
                  border: Border(
                    bottom: BorderSide(color: AppColors.grey1, width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    Text('Сумма'),
                    Text('${state.total.toString()} RUB'),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
              Expanded(
                child:
                    transactions.isEmpty
                        ? Center(child: Text("Нет данных за данный период"))
                        : ListView.builder(
                          itemCount: transactions.length,
                          itemBuilder:
                              (context, index) => Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    top:
                                        index == 0
                                            ? BorderSide(
                                              color: AppColors.grey1,
                                              width: 1,
                                            )
                                            : BorderSide.none,
                                    bottom: BorderSide(
                                      color: AppColors.grey1,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text(
                                      transactions[index].category.emoji,
                                      style: TextStyle(fontSize: 28),
                                    ),
                                  ),
                                  title: Text(
                                    transactions[index].category.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${transactions[index].comment ?? ""}', // Display date only
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        '${widget.isIncome ? '+' : '-'}${transactions[index].amount}${transactions[index].account.currency}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.arrow_forward_ios,
                                        ),
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
          ),
        );
      },
    );
  }
}
