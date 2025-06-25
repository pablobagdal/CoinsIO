// enum HistorySort { dateDesc, dateAsc, amountDesc, amountAsc }

abstract class TransactionsHistoryEvent {
  const TransactionsHistoryEvent();
}

class LoadTransactionsHistory extends TransactionsHistoryEvent {
  // final bool isIncome;
  final DateTime startDate;
  final DateTime endDate;

  const LoadTransactionsHistory({
    required this.startDate,
    required this.endDate,
    // required this.isIncome,
  });
}

// class ChangePeriod extends TransactionsHistoryEvent {
//   final DateTime startDate;
//   final DateTime endDate;
//   final bool isIncome;
//   const ChangePeriod({
//     required this.startDate,
//     required this.endDate,
//     required this.isIncome,
//   });
// }

// class ChangeSort extends TransactionsHistoryEvent {
//   final HistorySort sort;
//   const ChangeSort(this.sort);
// }

// class LoadMoreHistory extends TransactionsHistoryEvent {}
