import 'package:coinio_app/domain/models/transaction/transaction.dart';
import 'package:coinio_app/domain/models/transaction_response/transaction_response.dart';

abstract class TransactionRepository {
  /// get only one transaction
  Future<TransactionResponse> getTransaction({required final int id});

  /// add only one transaction
  Future<void> addTransaction({required final Transaction transaction});

  /// udpate one exsisting transaction
  Future<void> updateTransaction({
    required final int id,
    required final Transaction transaction,
  });

  /// delete one exsisting transaction
  Future<void> deleteTransaction({required final int id});

  /// get all transactions by period. Most commonly used method
  Future<List<TransactionResponse>> getTransactionsByPeriod({
    required final int id,
    // TODO here its' final but mock doesn't have it final
    final DateTime? startDate,
    final DateTime? endDate,
  });
}
