import 'package:coinio_app/data/datasources/local/local_data_source/app_database.dart';
import 'package:coinio_app/data/models/transaction_request/transaction_request.dart';
import 'package:coinio_app/data/models/transaction_response/transaction_response.dart';
import 'package:coinio_app/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final AppDatabase db;

  TransactionRepositoryImpl({required this.db});

  @override
  Future<void> addTransaction({required TransactionRequest transaction}) {
    // TODO: implement addTransaction
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTransaction({required int id}) {
    // TODO: implement deleteTransaction
    throw UnimplementedError();
  }

  @override
  Future<TransactionResponse> getTransaction({required int id}) {
    // TODO: implement getTransaction
    throw UnimplementedError();
  }

  @override
  Future<List<TransactionResponse>> getTransactionsByPeriod({
    required int id,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    // TODO: implement getTransactionsByPeriod
    throw UnimplementedError();
  }

  @override
  Future<void> updateTransaction({
    required int id,
    required TransactionRequest transaction,
  }) {
    // TODO: implement updateTransaction
    throw UnimplementedError();
  }
}
