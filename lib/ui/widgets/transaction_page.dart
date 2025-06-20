enum TransactionType { spending, income }

extension TransactionTypeExtension on TransactionType {
  String get name {
    switch (this) {
      case TransactionType.spending:
        return 'Расход';
      case TransactionType.income:
        return 'Доход';
    }
  }
}
