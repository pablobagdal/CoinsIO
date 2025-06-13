import 'package:coinio_app/data/repositories/transaction/transaction_repository.dart';
import 'package:coinio_app/domain/models/transaction/transaction.dart';

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
  Future<Transaction> getTransaction(int id) {
    return Future.delayed(Duration(seconds: 1), () {
      if (id < 0) {
        throw Exception("Invalid transaction ID");
      }
      // print("Transaction added: ${transaction.comment}, Amount: ${transaction.amount}");
      return Transaction(
        id: id,
        accountId: 1,
        categoryId: 1,
        amount: "100.0",
        transactionDate: DateTime.parse("2023-10-01T12:00:00Z"),
        comment: "Было дело, денег потратил",
        createdAt: DateTime.parse("2023-10-03T12:00:00Z"),
        updatedAt: DateTime.parse("2023-10-03T12:00:00Z"),
      );
    });
  }

  @override
  Future<List<Transaction>> getTransactionsByPeriod(
    DateTime startDate,
    DateTime endDate,
  ) {
    return Future.delayed(Duration(seconds: 1), () {
      if (startDate.isAfter(endDate)) {
        throw Exception("Start date cannot be after end date");
      }
      // Simulate fetching transactions for the given period
      List<Transaction> transactions = [
        Transaction(
          id: 1,
          accountId: 1,
          categoryId: 1,
          amount: "100.0",
          transactionDate: DateTime.parse("2023-10-01T12:00:00Z"),
          comment: "Было дело, денег потратил",
          createdAt: DateTime.parse("2023-10-03T12:00:00Z"),
          updatedAt: DateTime.parse("2023-10-03T12:00:00Z"),
        ),
        Transaction(
          id: 2,
          accountId: 1,
          categoryId: 2,
          amount: "200.0",
          transactionDate: DateTime.parse("2024-10-02T12:00:00Z"),
          comment: "Еще одна трата",
          createdAt: DateTime.parse("2024-10-04T12:00:00Z"),
          updatedAt: DateTime.parse("2024-10-04T12:00:00Z"),
        ),
        Transaction(
          id: 3,
          accountId: 1,
          categoryId: 3,
          amount: "300.0",
          transactionDate: DateTime.parse("2025-02-03T12:00:00Z"),
          comment: "Третья трата",
          createdAt: DateTime.parse("2025-02-05T12:00:00Z"),
          updatedAt: DateTime.parse("2025-02-05T12:00:00Z"),
        ),
        Transaction(
          id: 4,
          accountId: 1,
          categoryId: 4,
          amount: "400.0",
          transactionDate: DateTime.parse("2025-02-07T12:00:00Z"),
          comment: "Четвертая трата",
          createdAt: DateTime.parse("2025-02-07T12:00:00Z"),
          updatedAt: DateTime.parse("2025-02-07T12:00:00Z"),
        ),
        Transaction(
          id: 5,
          accountId: 1,
          categoryId: 5,
          amount: "500.0",
          transactionDate: DateTime.parse("2025-05-07T12:00:00Z"),
          comment: "Пятая трата",
          createdAt: DateTime.parse("2025-05-08T12:00:00Z"),
          updatedAt: DateTime.parse("2025-05-08T12:00:00Z"),
        ),
        Transaction(
          id: 6,
          accountId: 1,
          categoryId: 6,
          amount: "600.0",
          transactionDate: DateTime.parse("2025-06-09T12:00:00Z"),
          comment: "Шестая трата",
          createdAt: DateTime.parse("2025-06-09T12:00:00Z"),
          updatedAt: DateTime.parse("2025-06-09T12:00:00Z"),
        ),
        Transaction(
          id: 7,
          accountId: 1,
          categoryId: 1,
          amount: "100.0",
          transactionDate: DateTime.parse("2025-06-10T12:00:00Z"),
          comment: "Было дело, денег потратил",
          createdAt: DateTime.parse("2025-06-10T12:00:00Z"),
          updatedAt: DateTime.parse("2025-06-10T12:00:00Z"),
        ),
        Transaction(
          id: 8,
          accountId: 1,
          categoryId: 1,
          amount: "200.0",
          transactionDate: DateTime.parse("2025-06-11T12:00:00Z"),
          comment: "Еще одна трата",
          createdAt: DateTime.parse("2025-06-11T12:00:00Z"),
          updatedAt: DateTime.parse("2025-06-11T12:00:00Z"),
        ),
      ];

      // Filter transactions by the given period
      return transactions
          .where(
            (transaction) =>
                transaction.transactionDate.isAfter(startDate) &&
                transaction.transactionDate.isBefore(endDate),
          )
          .toList();
    });
  }

  @override
  Future<void> updateTransaction(Transaction transaction) {
    // Simulate a delay for adding a transaction
    return Future.delayed(Duration(seconds: 1), () {
      // Here you would typically add the transaction to a database or a list
      print(
        "Transaction added: ${transaction.comment}, Amount: ${transaction.amount}",
      );
    });
  }
}
