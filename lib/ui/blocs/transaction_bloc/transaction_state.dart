import 'package:coinio_app/domain/models/transaction/transaction.dart';

class TransactionState {}

class TransactionsLoading extends TransactionState {}

class TransactionsLoaded extends TransactionState {
  final List<Transaction> transactions;

  TransactionsLoaded({required this.transactions});
}

class TransactionError extends TransactionState {
  final String message;

  TransactionError(this.message);
}
