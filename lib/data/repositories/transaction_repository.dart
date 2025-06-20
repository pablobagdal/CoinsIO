import 'package:coinio_app/domain/models/transaction/transaction.dart';
import 'package:coinio_app/domain/models/transaction_response/transaction_response.dart';

abstract class TransactionRepository {
  Future<TransactionResponse> getTransaction(int id);
  Future<void> addTransaction(Transaction transaction);
  Future<void> updateTransaction({
    required int id,
    required Transaction transaction,
  });
  Future<void> deleteTransaction(int id);
  Future<List<TransactionResponse>> getTransactionsByPeriod({
    required int id,
    DateTime startDate,
    DateTime endDate,
  });
}
