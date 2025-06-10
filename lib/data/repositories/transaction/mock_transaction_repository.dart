import 'package:coinio_app/data/repositories/transaction/transaction_repository.dart';
import 'package:coinio_app/domain/models/transaction/transaction.dart';

class MockTransactionRepository implements TransactionRepository {
  @override
  Future<void> addTransaction(Transaction transaction) {
    // TODO: implement addTransaction
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTransaction(int id) {
    // TODO: implement deleteTransaction
    throw UnimplementedError();
  }

  @override
  Future<Transaction> getTransaction(int id) {
    // TODO: implement getTransaction
    throw UnimplementedError();
  }

  @override
  Future<List<Transaction>> getTransactionsByPeriod(
    DateTime startDate,
    DateTime endDate,
  ) {
    // TODO: implement getTransactionsByPeriod
    throw UnimplementedError();
  }

  @override
  Future<void> updateTransaction(Transaction transaction) {
    // TODO: implement updateTransaction
    throw UnimplementedError();
  }
}
