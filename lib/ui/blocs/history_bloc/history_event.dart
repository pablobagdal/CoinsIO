enum HistorySort { dateDesc, dateAsc, amountDesc, amountAsc }

abstract class HistoryEvent {
  const HistoryEvent();
}

class LoadHistory extends HistoryEvent {
  final bool isIncome;
  const LoadHistory({required this.isIncome});
}

class ChangePeriod extends HistoryEvent {
  final DateTime startDate;
  final DateTime endDate;
  final bool isIncome;
  const ChangePeriod({
    required this.startDate,
    required this.endDate,
    required this.isIncome,
  });
}

class ChangeSort extends HistoryEvent {
  final HistorySort sort;
  const ChangeSort(this.sort);
}

class LoadMoreHistory extends HistoryEvent {}
