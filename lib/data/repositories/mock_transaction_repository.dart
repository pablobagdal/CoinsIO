import 'package:coinio_app/domain/repositories/transaction_repository.dart';
import 'package:coinio_app/domain/models/account_brief/account_brief.dart';
import 'package:coinio_app/domain/models/category/category.dart';
import 'package:coinio_app/domain/models/transaction_request/transaction_request.dart';
import 'package:coinio_app/domain/models/transaction_response/transaction_response.dart';

class MockTransactionRepository implements TransactionRepository {
  // @override
  // Future<void> addTransaction({
  //   required final TransactionRequest transaction,
  // }) => Future.delayed(const Duration(seconds: 1), () {
  //   // Here you would typically add the transaction to a database or a list
  // });

  // @override
  // Future<void> deleteTransaction({required final int id}) =>
  //     Future.delayed(const Duration(seconds: 1), () {
  //       if (id <= 0) {
  //         throw Exception('Invalid transaction ID');
  //       }
  //       print('Transaction id = ${id}, successfully deleted');
  //     });

  @override
  Future<TransactionResponse> getTransaction({required final int id}) =>
      Future.delayed(const Duration(seconds: 1), () {
        if (id < 0 && id != 1) {
          throw Exception('Invalid transaction ID');
        }
        return TransactionResponse(
          id: 1,
          account: const AccountBrief(
            id: 1,
            name: 'Счет 1',
            balance: '100.00',
            currency: 'RUB',
          ),
          category: Category(
            id: id,
            name: 'Операция 1',
            emoji: '💰',
            isIncome: true,
          ),
          amount: '100.00',
          transactionDate: DateTime.now().subtract(const Duration(hours: 1)),
          createdAt: DateTime.now().subtract(const Duration(hours: 1)),
          updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
        );
      });

  @override
  Future<List<TransactionResponse>> getTransactionsByPeriod({
    required final int id,
    final DateTime? startDate,
    final DateTime? endDate,
  }) => Future.delayed(const Duration(seconds: 1), () {
    // Filter transactions by the given period
    final filtredTransactions =
        _transactions.where((final tr) {
          final isMatchStart =
              startDate == null || tr.transactionDate.isAfter(startDate);
          final isMatchEnd =
              endDate == null || tr.transactionDate.isBefore(endDate);

          return isMatchStart && isMatchEnd;
        }).toList();

    return filtredTransactions;
  });

  // @override
  // Future<void> updateTransaction({
  //   required final int id,
  //   required final TransactionRequest transaction,
  // }) => Future.delayed(const Duration(seconds: 1), () {});

  // Simulate fetching transactions for the given period
  List<TransactionResponse> _transactions = [
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
}
