import 'dart:async';

// import 'package:coinio_app/domain/repositories/transaction_repository.dart';
// import 'package:coinio_app/domain/usecases/transactions/get_transaction_usecase.dart';
import 'package:coinio_app/domain/usecases/transactions/get_transactions_by_period_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'transactions_history_event.dart';
import 'transactions_history_state.dart';

class TransactionsHistoryBloc
    extends Bloc<TransactionsHistoryEvent, TransactionsHistoryState> {
  // TODO implement usage of usecases instead of repos and params
  // final TransactionRepository transactionRepository;

  // DateTime? startDate;
  // DateTime? endDate;
  // HistorySort _sort = HistorySort.dateDesc;
  final bool isIncome;
  final GetTransactionsByPeriodUsecase getTransactionsByPeriod;

  // TransactionsHistoryBloc({required this.transactionRepository})
  //   : super(HistoryLoading()) {
  //   // on<LoadHistory>(_onLoadHistory);
  //   on<LoadHistory>(_onLoadHistory);
  //   on<ChangePeriod>(_onChangePeriod);
  //   on<ChangeSort>(_onChangeSort);
  // }
  TransactionsHistoryBloc({
    required this.getTransactionsByPeriod,
    required this.isIncome,
    required final DateTime startDate,
    required final DateTime endDate,
  }) : super(
         TransactionsHistoryLoading(startDate: startDate, endDate: endDate),
       ) {
    on<LoadTransactionsHistory>(_onLoadTransactions);
  }

  // Future<void> _onLoadHistory(
  //   LoadHistory event,
  //   Emitter<TransactionsHistoryState> emit,
  // ) async {
  //   isIncome = event.isIncome;
  //   startDate = DateTime(
  //     DateTime.now().year,
  //     DateTime.now().month - 1,
  //     DateTime.now().day,
  //     0,
  //     0,
  //     0,
  //   );

  //   endDate = DateTime(
  //     DateTime.now().year,
  //     DateTime.now().month,
  //     DateTime.now().day,
  //     23,
  //     59,
  //     59,
  //   );
  //   _sort = HistorySort.dateDesc;
  //   await _loadFullHistory(emit);
  // }

  // Future<void> _onChangePeriod(
  //   ChangePeriod event,
  //   Emitter<TransactionsHistoryState> emit,
  // ) async {
  //   startDate = event.startDate;
  //   endDate = event.endDate;

  //   // swap
  //   if (endDate!.isBefore(startDate!)) {
  //     // TODO remove !
  //     final tmp = startDate!;
  //     // TODO remove !
  //     startDate = endDate;
  //     endDate = tmp;
  //   }

  //   isIncome = event.isIncome;
  //   await _loadFullHistory(emit);
  // }

  // Future<void> _onChangeSort(
  //   ChangeSort event,
  //   Emitter<TransactionsHistoryState> emit,
  // ) async {
  //   _sort = event.sort;
  //   await _loadFullHistory(emit);
  // }

  // Future<void> _loadFullHistory(Emitter<TransactionsHistoryState> emit) async {
  //   emit(HistoryLoading());

  //   final transactions = await transactionRepository.getTransactionsByPeriod(
  //     startDate: startDate,
  //     endDate: endDate,
  //     id: 1, // TODO
  //   );

  //   var filteredTransactions =
  //       transactions.where((t) => t.category.isIncome == isIncome).toList();

  //   // sort
  //   switch (_sort) {
  //     case HistorySort.dateDesc:
  //       filteredTransactions.sort(
  //         (a, b) => b.transactionDate.compareTo(a.transactionDate),
  //       );
  //       break;
  //     case HistorySort.dateAsc:
  //       filteredTransactions.sort(
  //         (a, b) => a.transactionDate.compareTo(b.transactionDate),
  //       );
  //       break;
  //     case HistorySort.amountDesc:
  //       filteredTransactions.sort((a, b) => b.amount.compareTo(a.amount));
  //       break;
  //     case HistorySort.amountAsc:
  //       filteredTransactions.sort((a, b) => a.amount.compareTo(b.amount));
  //       break;
  //   }

  //   final _total = filteredTransactions.fold<double>(
  //     0,
  //     (sum, t) => sum + double.parse(t.amount),
  //   );

  //   emit(
  //     HistoryLoaded(
  //       transactions: filteredTransactions,
  //       total: _total,
  //       sort: _sort,
  //       startDate: startDate!,
  //       endDate: endDate!,
  //       // TODO remove !
  //     ),
  //   );
  // }

  Future<void> _onLoadTransactions(
    final LoadTransactionsHistory event,
    final Emitter<TransactionsHistoryState> emit,
  ) async {
    emit(
      TransactionsHistoryLoading(
        endDate: event.startDate,
        startDate: event.endDate,
      ),
    );

    final trx = await getTransactionsByPeriod(
      startDate: event.startDate,
      endDate: event.endDate,
      isIncome: isIncome,
    );

    // TODO failure error emit (either, dartz etc)

    emit(
      TransactionsHistoryLoaded(
        transactions: trx,
        startDate: event.startDate,
        endDate: event.endDate,
      ),
    );
  }
}
