import 'package:coinio_app/data/repositories/transaction_repository.dart';
import 'package:coinio_app/domain/models/account_brief/account_brief.dart';
import 'package:coinio_app/domain/models/category/category.dart';
import 'package:coinio_app/domain/models/transaction/transaction.dart';
import 'package:coinio_app/domain/models/transaction_response/transaction_response.dart';

class MockTransactionRepository implements TransactionRepository {
  @override
  Future<void> addTransaction(Transaction transaction) {
    // Simulate a delay for adding a transaction
    return Future.delayed(Duration(seconds: 1), () {
      // Here you would typically add the transaction to a database or a list
      print(
        "Transaction added: ${transaction.comment}, Amount: ${transaction.amount}",
      );
    });
  }

  @override
  Future<void> deleteTransaction(int id) {
    // Simulate deleting a transaction
    return Future.delayed(Duration(seconds: 1), () {
      if (id <= 0) {
        throw Exception("Invalid transaction ID");
      }
      print("Transaction id = ${id}, successfully deleted");
    });
  }

  @override
  Future<TransactionResponse> getTransaction(int id) {
    return Future.delayed(Duration(seconds: 1), () {
      if (id < 0) {
        throw Exception("Invalid transaction ID");
      }
      // print("Transaction added: ${transaction.comment}, Amount: ${transaction.amount}");
      return TransactionResponse(
        id: 1,
        account: AccountBrief(
          id: 1,
          name: "Счет 1",
          balance: "100.00",
          currency: "RUB",
        ),
        category: Category(
          id: id,
          name: "Операция 1",
          emoji: "💰",
          isIncome: true,
        ),
        amount: '',
        transactionDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    });
  }

  @override
  Future<List<TransactionResponse>> getTransactionsByPeriod({
    required int id,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return Future.delayed(Duration(seconds: 1), () {
      // if startDate or endDate is null, set them to default values
      startDate ??= DateTime.now().subtract(
        Duration(days: 30),
      ); // Default to 30 days ago
      endDate ??= DateTime.now(); // Default to now

      // TODO try to remove  ! operator
      if (startDate!.isAfter(endDate!)) {
        throw Exception("Start date cannot be after end date");
      }
      // Simulate fetching transactions for the given period
      List<TransactionResponse> transactions = [
        TransactionResponse(
          id: 1,
          account: AccountBrief(
            id: 1,
            name: "Счет 1",
            balance: "100.00",
            currency: "RUB",
          ),
          category: Category(
            id: id,
            name: "Операция 1 доход",
            emoji: "💰",
            isIncome: true,
          ),
          amount: '',
          transactionDate: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        TransactionResponse(
          id: 1,
          account: AccountBrief(
            id: 1,
            name: "Счет 1",
            balance: "100.00",
            currency: "RUB",
          ),
          category: Category(
            id: id,
            name: "Операция 2 доход",
            emoji: "💰",
            isIncome: true,
          ),
          amount: '',
          transactionDate: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        TransactionResponse(
          id: 1,
          account: AccountBrief(
            id: 1,
            name: "Счет 1",
            balance: "100.00",
            currency: "RUB",
          ),
          category: Category(
            id: id,
            name: "Операция 3 доход",
            emoji: "💰",
            isIncome: true,
          ),
          amount: '',
          transactionDate: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        TransactionResponse(
          id: 1,
          account: AccountBrief(
            id: 1,
            name: "Счет 1",
            balance: "100.00",
            currency: "RUB",
          ),
          category: Category(
            id: id,
            name: "Операция 4 расход",
            emoji: "💰",
            isIncome: true,
          ),
          amount: '',
          transactionDate: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        TransactionResponse(
          id: 1,
          account: AccountBrief(
            id: 1,
            name: "Счет 1",
            balance: "100.00",
            currency: "RUB",
          ),
          category: Category(
            id: id,
            name: "Операция 5 расход",
            emoji: "💰",
            isIncome: true,
          ),
          amount: '',
          transactionDate: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        TransactionResponse(
          id: 1,
          account: AccountBrief(
            id: 1,
            name: "Счет 1",
            balance: "100.00",
            currency: "RUB",
          ),
          category: Category(
            id: id,
            name: "Операция 6 расход",
            emoji: "💰",
            isIncome: true,
          ),
          amount: '',
          transactionDate: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];

      // Filter transactions by the given period
      return transactions
          .where(
            (transaction) =>
                transaction.transactionDate.isAfter(startDate!) &&
                transaction.transactionDate.isBefore(endDate!),
          )
          .toList();
    });
  }

  @override
  Future<void> updateTransaction({
    required int id,
    required Transaction transaction,
  }) {
    // Simulate a delay for adding a transaction
    return Future.delayed(Duration(seconds: 1), () {
      // Here you would typically add the transaction to a database or a list
      print(
        "Transaction added: ${transaction.comment}, Amount: ${transaction.amount}",
      );
    });
  }
}



// Transaction(
//           id: 1,
//           accountId: 1,
//           categoryId: 1,
//           amount: "100.0",
//           transactionDate: DateTime.parse("2023-10-01T12:00:00Z"),
//           comment: "Было дело, денег потратил",
//           createdAt: DateTime.parse("2023-10-03T12:00:00Z"),
//           updatedAt: DateTime.parse("2023-10-03T12:00:00Z"),
//         ),
//         Transaction(
//           id: 2,
//           accountId: 1,
//           categoryId: 2,
//           amount: "200.0",
//           transactionDate: DateTime.parse("2024-10-02T12:00:00Z"),
//           comment: "Еще одна трата",
//           createdAt: DateTime.parse("2024-10-04T12:00:00Z"),
//           updatedAt: DateTime.parse("2024-10-04T12:00:00Z"),
//         ),
//         Transaction(
//           id: 3,
//           accountId: 1,
//           categoryId: 3,
//           amount: "300.0",
//           transactionDate: DateTime.parse("2025-02-03T12:00:00Z"),
//           comment: "Третья трата",
//           createdAt: DateTime.parse("2025-02-05T12:00:00Z"),
//           updatedAt: DateTime.parse("2025-02-05T12:00:00Z"),
//         ),
//         Transaction(
//           id: 4,
//           accountId: 1,
//           categoryId: 4,
//           amount: "400.0",
//           transactionDate: DateTime.parse("2025-02-07T12:00:00Z"),
//           comment: "Четвертая трата",
//           createdAt: DateTime.parse("2025-02-07T12:00:00Z"),
//           updatedAt: DateTime.parse("2025-02-07T12:00:00Z"),
//         ),
//         Transaction(
//           id: 5,
//           accountId: 1,
//           categoryId: 5,
//           amount: "500.0",
//           transactionDate: DateTime.parse("2025-05-07T12:00:00Z"),
//           comment: "Пятая трата",
//           createdAt: DateTime.parse("2025-05-08T12:00:00Z"),
//           updatedAt: DateTime.parse("2025-05-08T12:00:00Z"),
//         ),
//         Transaction(
//           id: 6,
//           accountId: 1,
//           categoryId: 6,
//           amount: "600.0",
//           transactionDate: DateTime.parse("2025-06-09T12:00:00Z"),
//           comment: "Шестая трата",
//           createdAt: DateTime.parse("2025-06-09T12:00:00Z"),
//           updatedAt: DateTime.parse("2025-06-09T12:00:00Z"),
//         ),
//         Transaction(
//           id: 7,
//           accountId: 1,
//           categoryId: 1,
//           amount: "100.0",
//           transactionDate: DateTime.parse("2025-06-10T12:00:00Z"),
//           comment: "Было дело, денег потратил",
//           createdAt: DateTime.parse("2025-06-10T12:00:00Z"),
//           updatedAt: DateTime.parse("2025-06-10T12:00:00Z"),
//         ),
//         Transaction(
//           id: 8,
//           accountId: 1,
//           categoryId: 1,
//           amount: "200.0",
//           transactionDate: DateTime.parse("2025-06-11T12:00:00Z"),
//           comment: "Еще одна трата",
//           createdAt: DateTime.parse("2025-06-11T12:00:00Z"),
//           updatedAt: DateTime.parse("2025-06-11T12:00:00Z"),
//         ),
//         Transaction(
//           id: 8,
//           accountId: 1,
//           categoryId: 1,
//           amount: "200.12",
//           transactionDate: DateTime.parse("2025-06-18T12:00:00Z"),
//           comment: "Трата 18.6 первая",
//           createdAt: DateTime.parse("2025-06-18T12:00:00Z"),
//           updatedAt: DateTime.parse("2025-06-18T12:00:00Z"),
//         ),
//         Transaction(
//           id: 9,
//           accountId: 1,
//           categoryId: 1,
//           amount: "100.12",
//           transactionDate: DateTime.parse("2025-06-18T12:00:00Z"),
//           comment: "Пиво",
//           createdAt: DateTime.parse("2025-06-18T12:00:00Z"),
//           updatedAt: DateTime.parse("2025-06-18T12:00:00Z"),
//         ),
//         Transaction(
//           id: 9,
//           accountId: 1,
//           categoryId: 1,
//           amount: "300",
//           transactionDate: DateTime.parse("2025-06-18T12:00:00Z"),
//           comment: "Водка",
//           createdAt: DateTime.parse("2025-06-18T12:00:00Z"),
//           updatedAt: DateTime.parse("2025-06-18T12:00:00Z"),
//         ),
//         Transaction(
//           id: 9,
//           accountId: 1,
//           categoryId: 1,
//           amount: "2200.12",
//           transactionDate: DateTime.parse("2025-06-18T12:00:00Z"),
//           comment: "Трата 18.6 вторая",
//           createdAt: DateTime.parse("2025-06-18T12:00:00Z"),
//           updatedAt: DateTime.parse("2025-06-18T12:00:00Z"),
//         ),
//         Transaction(
//           id: 9,
//           accountId: 1,
//           categoryId: 1,
//           amount: "350",
//           transactionDate: DateTime.parse("2025-06-18T12:00:00Z"),
//           comment: "Мохито",
//           createdAt: DateTime.parse("2025-06-18T12:00:00Z"),
//           updatedAt: DateTime.parse("2025-06-18T12:00:00Z"),
//         ),