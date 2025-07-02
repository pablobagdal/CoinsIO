// import 'package:coinio_app/domain/models/transaction_request/transaction_request.dart';
import 'package:coinio_app/domain/models/transaction_request/transaction_request.dart';
import 'package:coinio_app/domain/models/transaction_response/transaction_response.dart';

abstract class TransactionRepository {
  Future<TransactionResponse> getTransaction({required final int id});
  Future<void> addTransaction({required final TransactionRequest transaction});

  // probably should use Transaction instead of both params
  Future<void> updateTransaction({
    required final int id,
    required final TransactionRequest transaction,
  });
  Future<void> deleteTransaction({required final int id});
  Future<List<TransactionResponse>> getTransactionsByPeriod({
    required final int id,
    final DateTime? startDate,
    final DateTime? endDate,
  });
}
