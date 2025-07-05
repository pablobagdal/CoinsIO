import 'dart:async';

import 'package:coinio_app/domain/models/transaction_request/transaction_request.dart';
import 'package:coinio_app/domain/usecases/transaction_usecases/transaction_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetTransactionsByPeriodUsecase getTransactionsByPeriodUsecase;
  final GetTransactionUsecase getTransactionUsecase;
  final DeleteTransactionUsecase deleteTransactionUsecase;
  final AddTransactionUsecase addTransactionUsecase;
  final UpdateTransactionUsecase updateTransactionUsecase;

  final bool isIncome;

  TransactionBloc({
    required this.getTransactionUsecase,
    required this.getTransactionsByPeriodUsecase,
    required this.addTransactionUsecase,
    required this.deleteTransactionUsecase,
    required this.updateTransactionUsecase,
    required this.isIncome,
    required final DateTime startDate,
    required final DateTime endDate,
  }) : super(TransactionInitial()) {
    on<LoadTransactions>(_onLoadTransactions);
    on<UpdateTransaction>(_onUpdateTransaction);
    on<AddTransaction>(_onAddTransaction);
    on<DeleteTransaction>(_onDeleteTransaction);
    on<LoadTransaction>(_onLoadTransaction);
  }

  // Future<void> _onLoad(
  //   Load event,
  //   Emitter<TransactionState> emit,
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
  //   _sort = Sort.dateDesc;
  //   await _loadFull(emit);
  // }

  // Future<void> _onChangePeriod(
  //   ChangePeriod event,
  //   Emitter<TransactionState> emit,
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
  //   await _loadFull(emit);
  // }

  // Future<void> _onChangeSort(
  //   ChangeSort event,
  //   Emitter<TransactionState> emit,
  // ) async {
  //   _sort = event.sort;
  //   await _loadFull(emit);
  // }

  // Future<void> _loadFull(Emitter<TransactionState> emit) async {
  //   emit(Loading());

  //   final transactions = await transactionRepository.getTransactionsByPeriod(
  //     startDate: startDate,
  //     endDate: endDate,
  //     id: 1, // TODO
  //   );

  //   var filteredTransactions =
  //       transactions.where((t) => t.category.isIncome == isIncome).toList();

  //   // sort
  //   switch (_sort) {
  //     case Sort.dateDesc:
  //       filteredTransactions.sort(
  //         (a, b) => b.transactionDate.compareTo(a.transactionDate),
  //       );
  //       break;
  //     case Sort.dateAsc:
  //       filteredTransactions.sort(
  //         (a, b) => a.transactionDate.compareTo(b.transactionDate),
  //       );
  //       break;
  //     case Sort.amountDesc:
  //       filteredTransactions.sort((a, b) => b.amount.compareTo(a.amount));
  //       break;
  //     case Sort.amountAsc:
  //       filteredTransactions.sort((a, b) => a.amount.compareTo(b.amount));
  //       break;
  //   }

  //   final _total = filteredTransactions.fold<double>(
  //     0,
  //     (sum, t) => sum + double.parse(t.amount),
  //   );

  //   emit(
  //     Loaded(
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
    final LoadTransactions event,
    final Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());

    try {
      final trx = await getTransactionsByPeriodUsecase(
        startDate: event.startDate,
        endDate: event.endDate,
        isIncome: isIncome,
      );

      emit(
        TransactionsLoaded(
          transactions: trx,
          startDate: event.startDate,
          endDate: event.endDate,
        ),
      );
    } catch (e) {
      emit(TransactionError(message: e.toString()));
    }
  }

  Future<void> _onUpdateTransaction(
    UpdateTransaction event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());

    try {
      // TODO add mapper instead of this
      final request = TransactionRequest(
        accountId: event.transaction.account.id,
        categoryId: event.transaction.category.id,
        amount: event.transaction.amount,
        transactionDate: event.transaction.transactionDate,
      );

      await updateTransactionUsecase(
        id: event.transaction.id,
        transaction: request,
      );
    } catch (e) {
      emit(TransactionError(message: e.toString()));
    }
  }

  Future<void> _onAddTransaction(
    AddTransaction event,
    Emitter<TransactionState> emit,
  ) async {
    // TODO add transaction
    emit(TransactionLoading());
    try {
      final request = TransactionRequest(
        accountId: event.transaction.accountId,
        categoryId: event.transaction.categoryId,
        amount: event.transaction.amount,
        transactionDate: event.transaction.transactionDate,
      );

      await addTransactionUsecase(transaction: request);
      add(LoadTransactions(startDate: event.startDate, endDate: event.endDate));
    } catch (e) {
      emit(TransactionError(message: e.toString()));
    }
  }

  Future<void> _onDeleteTransaction(
    DeleteTransaction event,
    Emitter<TransactionState> emit,
  ) async {
    // TODO delete transaction
    emit(TransactionLoading());
    try {
      await deleteTransactionUsecase(id: event.id);
      emit(TransactionInitial());
    } catch (e) {
      emit(TransactionError(message: e.toString()));
    }
  }

  Future<void> _onLoadTransaction(
    LoadTransaction event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    try {
      final transaction = await getTransactionUsecase(id: event.id);
      emit(TransactionLoaded(transaction: transaction));
    } catch (e) {
      emit(TransactionError(message: e.toString()));
    }
  }
}
