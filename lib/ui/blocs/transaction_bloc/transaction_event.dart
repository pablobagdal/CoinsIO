import 'package:coinio_app/data/models/transaction/transaction.dart';
import 'package:coinio_app/data/models/transaction_response/transaction_response.dart';

abstract class TransactionEvent {
  const TransactionEvent();
}

class LoadTransactions extends TransactionEvent {
  // final bool isIncome;
  final DateTime startDate;
  final DateTime endDate;

  const LoadTransactions({
    required this.startDate,
    required this.endDate,
    // required this.isIncome,
  });
}

class LoadTransaction extends TransactionEvent {
  final int id;

  const LoadTransaction({required this.id});
}

class DeleteTransaction extends TransactionEvent {
  final int id;

  const DeleteTransaction({required this.id});
}

class UpdateTransaction extends TransactionEvent {
  final TransactionResponse transaction;

  const UpdateTransaction({required this.transaction});
}

class AddTransaction extends TransactionEvent {
  final Transaction transaction;
  final DateTime startDate;
  final DateTime endDate;

  const AddTransaction({
    required this.transaction,
    required this.startDate,
    required this.endDate,
  });
}
