import 'package:coinio_app/domain/entities/transaction.dart';

abstract class TransactionRepository {
  Future<Transaction> getTransaction({required final int id});
  Future<void> addTransaction({required final Transaction transaction});
  Future<void> updateTransaction({required final Transaction transaction});
  Future<void> deleteTransaction({required final int id});
  Future<List<Transaction>> getTransactionsByPeriod({
    required final int id,
    final DateTime? startDate,
    final DateTime? endDate,
  });
}
