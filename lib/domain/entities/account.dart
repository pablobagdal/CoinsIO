class Account {
  final int id;
  final int userId;

  final String name;
  final String balance;
  final String currency;

  final DateTime createdAt;
  final DateTime updatedAt;

  Account({
    required this.id,
    required this.userId,
    required this.name,
    required this.balance,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
  });
}

class AccountState {
  final int id;
  final String name;
  final String balance;
  final String currency;
  const AccountState({
    required this.id,
    required this.name,
    required this.balance,
    required this.currency,
  });
}

enum ChangeType { modification, creation }

class AccountHistory {
  final int id;
  final int accountId;
  final ChangeType changeType;
  final AccountState previousState;
  final AccountState newState;
  final DateTime changeTimestamp;
  final DateTime createdAt;

  AccountHistory({
    required this.id,
    required this.accountId,
    required this.changeType,
    required this.previousState,
    required this.newState,
    required this.changeTimestamp,
    required this.createdAt,
  });
}

class StatItem {
  final int categoryId;
  final String categoryName;
  final String emoji;
  final String amount;
  StatItem({
    required this.categoryId,
    required this.categoryName,
    required this.emoji,
    required this.amount,
  });
}
