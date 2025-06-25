import 'package:coinio_app/domain/models/transaction_response/transaction_response.dart';

abstract class TransactionsHistoryState {
  final DateTime startDate;
  final DateTime endDate;

  const TransactionsHistoryState({
    required this.endDate,
    required this.startDate,
  });
}

class TransactionsHistoryLoading extends TransactionsHistoryState {
  TransactionsHistoryLoading({
    required super.endDate,
    required super.startDate,
  });
}

class TransactionsHistoryLoaded extends TransactionsHistoryState {
  final List<TransactionResponse> transactions;
  // final double total;
  // final HistorySort sort;
  // final DateTime startDate;
  // final DateTime endDate;

  const TransactionsHistoryLoaded({
    required this.transactions,
    // required this.total,
    // required this.sort,
    required super.startDate,
    required super.endDate,
  });
}

class TransactionsHistoryError extends TransactionsHistoryState {
  final String message;

  TransactionsHistoryError({
    required this.message,
    required super.endDate,
    required super.startDate,
  });
}
