abstract class TransactionEvent {}

class LoadTransaction extends TransactionEvent {
  final int id;
  LoadTransaction({required this.id});
}

class LoadTransactionsByPeriod extends TransactionEvent {
  final DateTime startDate;
  final DateTime endDate;

  LoadTransactionsByPeriod({required this.startDate, required this.endDate});
}
