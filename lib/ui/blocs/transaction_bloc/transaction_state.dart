import 'package:coinio_app/domain/models/transaction_response/transaction_response.dart';

class TransactionState {}

class TransactionInitial extends TransactionState {}

class TransactionsLoading extends TransactionState {}

class TransactionsLoaded extends TransactionState {
  final List<TransactionResponse> transactions;

  TransactionsLoaded({required this.transactions});
}

class TransactionError extends TransactionState {
  final String message;

  TransactionError(this.message);
}
