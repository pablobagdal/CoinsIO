import 'package:coinio_app/domain/models/transaction/transaction.dart';

abstract class TransactionEvent {}

class LoadTransactionsByPeriod extends TransactionEvent {
  final DateTime? startDate;
  final DateTime? endDate;
  final int id;

  LoadTransactionsByPeriod({this.startDate, this.endDate, required this.id});
}

class AddTransaction extends TransactionEvent {
  final Transaction transaction;
  AddTransaction({required this.transaction});
}

class UpdateTransaction extends TransactionEvent {
  final int id;
  final Transaction transaction;

  UpdateTransaction({required this.id, required this.transaction});
}

class DeleteTransaction extends TransactionEvent {
  final int id;
  DeleteTransaction({required this.id});
}

class LoadTransaction extends TransactionEvent {
  final int id;
  LoadTransaction({required this.id});
}
