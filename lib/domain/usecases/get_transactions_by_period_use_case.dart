import 'package:coinio_app/data/datasources/local/transaction_repository.dart';
import 'package:coinio_app/domain/models/transaction/transaction.dart';

class GetTransactionsByPeriodUseCase {
  final TransactionRepository repository;

  GetTransactionsByPeriodUseCase({required this.repository});

  Future<List<Transaction>> call(DateTime startDate, DateTime endDate) async {
    return await repository.getTransactionsByPeriod(startDate, endDate);
  }
}
