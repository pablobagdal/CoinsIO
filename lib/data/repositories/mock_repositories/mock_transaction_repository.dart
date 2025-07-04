import 'package:coinio_app/domain/models/transaction_request/transaction_request.dart';
import 'package:coinio_app/domain/repositories/transaction_repository.dart';
import 'package:coinio_app/domain/models/account_brief/account_brief.dart';
import 'package:coinio_app/domain/models/category/category.dart';
import 'package:coinio_app/domain/models/transaction_response/transaction_response.dart';

class MockTransactionRepository implements TransactionRepository {
  @override
  Future<TransactionResponse> getTransaction({required final int id}) async {
    await Future.delayed(const Duration(seconds: 1));

    final transaction = _transactions.firstWhere(
      (final tr) => tr.id == id,
      orElse: () => throw Exception('Transaction not found'),
    );

    return transaction;
  }

  @override
  Future<List<TransactionResponse>> getTransactionsByPeriod({
    required final int id,
    final DateTime? startDate,
    final DateTime? endDate,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    final filtredTransactions =
        _transactions.where((final tr) {
          final isMatchStart =
              startDate == null || tr.transactionDate.isAfter(startDate);
          final isMatchEnd =
              endDate == null || tr.transactionDate.isBefore(endDate);

          return isMatchStart && isMatchEnd;
        }).toList();

    return filtredTransactions;
  }

  @override
  Future<void> addTransaction({required TransactionRequest transaction}) async {
    await Future.delayed(const Duration(seconds: 1));
    // TODO add Transaction
    final TransactionResponse newTransaction = TransactionResponse(
      id: 999,
      account: _mockAccountBrief,
      category: _mockCategoryIncome,
      amount: transaction.amount,
      transactionDate: transaction.transactionDate,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      comment: transaction.comment,
    );

    _transactions.add(newTransaction);

    return;
  }

  @override
  Future<void> deleteTransaction({required int id}) async {
    await Future.delayed(const Duration(seconds: 1));

    final transactionIndex = _transactions.indexWhere(
      (final tr) => tr.id == id,
    );
    if (transactionIndex == -1) {
      throw Exception('Transaction not found');
    }
    _transactions.removeAt(transactionIndex);
  }

  @override
  Future<void> updateTransaction({
    required int id,
    required TransactionRequest transaction,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    final transactionIndex = _transactions.indexWhere(
      (final tr) => tr.id == id,
    );
    if (transactionIndex == -1) {
      throw Exception('Transaction not found');
    }

    _transactions[transactionIndex] = TransactionResponse(
      id: id,
      account: _mockAccountBrief,
      category: _mockCategoryIncome,
      amount: transaction.amount,
      transactionDate: transaction.transactionDate,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      comment: transaction.comment,
    );
  }
}

final List<TransactionResponse> _transactions = [
  TransactionResponse(
    id: 1,
    account: const AccountBrief(
      id: 1,
      name: 'Счет 1',
      balance: '100.00',
      currency: 'RUB',
    ),
    category: const Category(
      id: 1,
      name: 'Операция 1 доход',
      emoji: '💰',
      isIncome: true,
    ),
    amount: '100.00',
    transactionDate: DateTime.now()
        .subtract(const Duration(hours: 1))
        .subtract(const Duration(hours: 1)),
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
  ),
  TransactionResponse(
    id: 1,
    account: const AccountBrief(
      id: 1,
      name: 'Счет 1',
      balance: '100.00',
      currency: 'RUB',
    ),
    category: const Category(
      id: 1,
      name: 'Операция 1 доход',
      emoji: '💰',
      isIncome: true,
    ),
    amount: '100.00',
    transactionDate: DateTime.now()
        .subtract(const Duration(hours: 1))
        .subtract(const Duration(hours: 1)),
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
  ),
  TransactionResponse(
    id: 1,
    account: const AccountBrief(
      id: 1,
      name: 'Счет 1',
      balance: '100.00',
      currency: 'RUB',
    ),
    category: const Category(
      id: 1,
      name: 'Операция 1 доход',
      emoji: '💰',
      isIncome: true,
    ),
    amount: '100.00',
    transactionDate: DateTime.now()
        .subtract(const Duration(hours: 1))
        .subtract(const Duration(hours: 1)),
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
  ),
  TransactionResponse(
    id: 1,
    account: const AccountBrief(
      id: 1,
      name: 'Счет 1',
      balance: '100.00',
      currency: 'RUB',
    ),
    category: const Category(
      id: 1,
      name: 'Операция 1 доход',
      emoji: '💰',
      isIncome: true,
    ),
    amount: '100.00',
    transactionDate: DateTime.now()
        .subtract(const Duration(hours: 1))
        .subtract(const Duration(hours: 1)),
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
  ),
  TransactionResponse(
    id: 1,
    account: const AccountBrief(
      id: 1,
      name: 'Счет 1',
      balance: '100.00',
      currency: 'RUB',
    ),
    category: const Category(
      id: 1,
      name: 'Операция 1 доход',
      emoji: '💰',
      isIncome: true,
    ),
    amount: '100.00',
    transactionDate: DateTime.now()
        .subtract(const Duration(hours: 1))
        .subtract(const Duration(hours: 1)),
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
  ),
  TransactionResponse(
    id: 1,
    account: const AccountBrief(
      id: 1,
      name: 'Счет 1',
      balance: '100.00',
      currency: 'RUB',
    ),
    category: const Category(
      id: 1,
      name: 'Операция 1 доход',
      emoji: '💰',
      isIncome: true,
    ),
    amount: '100.00',
    transactionDate: DateTime.now()
        .subtract(const Duration(hours: 1))
        .subtract(const Duration(hours: 1)),
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
  ),
  TransactionResponse(
    id: 1,
    account: const AccountBrief(
      id: 1,
      name: 'Счет 1',
      balance: '100.00',
      currency: 'RUB',
    ),
    category: const Category(
      id: 1,
      name: 'Операция 2 доход',
      emoji: '🤑',
      isIncome: true,
    ),
    amount: '100.00',
    transactionDate: DateTime.now().subtract(const Duration(hours: 1)),
    comment: 'Другое описание',
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
  ),
  TransactionResponse(
    id: 1,
    account: const AccountBrief(
      id: 1,
      name: 'Счет 1',
      balance: '100.00',
      currency: 'RUB',
    ),
    category: const Category(
      id: 1,
      name: 'Операция 3 доход',
      emoji: '💵',
      isIncome: true,
    ),
    amount: '100.00',
    transactionDate: DateTime.now().subtract(const Duration(hours: 1)),
    comment: 'Описание транзакции',
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
  ),
  TransactionResponse(
    id: 1,
    account: const AccountBrief(
      id: 1,
      name: 'Счет 1',
      balance: '100.00',
      currency: 'RUB',
    ),
    category: const Category(
      id: 1,
      name: 'Операция 4 расход',
      emoji: '💸',
      isIncome: false,
    ),
    amount: '120.00',
    transactionDate: DateTime.now().subtract(const Duration(hours: 1)),
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
  ),
  TransactionResponse(
    id: 1,
    account: const AccountBrief(
      id: 1,
      name: 'Счет 1',
      balance: '100.00',
      currency: 'RUB',
    ),
    category: const Category(
      id: 1,
      name: 'Операция 5 расход',
      emoji: '🧾',
      isIncome: false,
    ),
    amount: '100.00',
    transactionDate: DateTime.now().subtract(const Duration(hours: 1)),
    comment: 'Описание транзакции',
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
  ),
  TransactionResponse(
    id: 1,
    account: const AccountBrief(
      id: 1,
      name: 'Счет 1',
      balance: '100.00',
      currency: 'RUB',
    ),
    category: const Category(
      id: 1,
      name: 'Операция 6 расход',
      emoji: '🛒',
      isIncome: false,
    ),
    amount: '100.00',
    transactionDate: DateTime.now().subtract(const Duration(hours: 1)),
    comment: 'Описание транзакции',
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
  ),
  TransactionResponse(
    id: 1,
    account: const AccountBrief(
      id: 1,
      name: 'Счет 1',
      balance: '100.00',
      currency: 'RUB',
    ),
    category: const Category(
      id: 1,
      name: 'Операция 7 расход',
      emoji: '🍔',
      isIncome: false,
    ),
    amount: '100.00',
    transactionDate: DateTime.now().subtract(const Duration(hours: 24)),
    comment: 'Это всегда вчерашняя операция',
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
  ),
];

final AccountBrief _mockAccountBrief = const AccountBrief(
  id: 1,
  name: 'Счет 1',
  balance: '100.00',
  currency: 'RUB',
);

final Category _mockCategoryIncome = const Category(
  id: 1,
  name: 'Категория мок доход',
  emoji: '💰',
  isIncome: true,
);
