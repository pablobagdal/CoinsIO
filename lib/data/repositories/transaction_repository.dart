import 'package:coinio_app/domain/models/transaction/transaction.dart';
import 'package:coinio_app/domain/models/transaction_response/transaction_response.dart';

abstract class TransactionRepository {
  /// get only one transaction
  Future<TransactionResponse> getTransaction(int id);

  /// add only one transaction
  Future<void> addTransaction(Transaction transaction);

  /// udpate one exsisting transaction
  Future<void> updateTransaction({
    required int id,
    required Transaction transaction,
  });

  /// delete one exsisting transaction
  Future<void> deleteTransaction(int id);

  /// get all transactions by period. Most commonly used method
  Future<List<TransactionResponse>> getTransactionsByPeriod({
    required int id,
    DateTime? startDate,
    DateTime? endDate,
  });
}
