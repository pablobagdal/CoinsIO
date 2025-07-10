import 'package:coinio_app/data/models/transaction_response/transaction_response.dart';

abstract class TransactionState {}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {
  TransactionLoading();
}

class TransactionsLoaded extends TransactionState {
  final List<TransactionResponse> transactions;
  final DateTime startDate;
  final DateTime endDate;

  // final double total;
  // final HistorySort sort;

  TransactionsLoaded({
    required this.transactions,
    // required this.total,
    // required this.sort,
    required this.startDate,
    required this.endDate,
  });
}

class TransactionError extends TransactionState {
  // TODO add possible list of transactions
  final String message;

  TransactionError({required this.message});
}

class TransactionLoaded extends TransactionState {
  final TransactionResponse transaction;

  TransactionLoaded({required this.transaction});
}
