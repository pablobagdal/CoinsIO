import 'package:coinio_app/data/datasources/local/transaction_local_data_source.dart';
import 'package:coinio_app/data/datasources/remote/transaction_remote_data_source.dart';
import 'package:coinio_app/domain/entities/transaction.dart';
import 'package:coinio_app/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionLocalDataSource localDataSource;
  final TransactionRemoteDataSource remoteDataSource;

  TransactionRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<void> addTransaction({required Transaction transaction}) {
    // TODO: implement addTransaction
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTransaction({required int id}) {
    // TODO: implement deleteTransaction
    throw UnimplementedError();
  }

  @override
  Future<Transaction> getTransaction({required int id}) {
    // TODO: implement getTransaction
    throw UnimplementedError();
  }

  @override
  Future<List<Transaction>> getTransactionsByPeriod({
    required int id,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    // TODO: implement getTransactionsByPeriod
    throw UnimplementedError();
  }

  @override
  Future<void> updateTransaction({required Transaction transaction}) {
    // TODO: implement updateTransaction
    throw UnimplementedError();
  }
}
