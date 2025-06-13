import 'package:coinio_app/domain/models/transaction/transaction.dart';

abstract class TransactionRepository {
  Future<Transaction> getTransaction(int id);
  Future<void> addTransaction(Transaction transaction);
  Future<void> updateTransaction(Transaction transaction);
  Future<void> deleteTransaction(int id);
  Future<List<Transaction>> getTransactionsByPeriod(
    DateTime startDate,
    DateTime endDate,
  );
}
