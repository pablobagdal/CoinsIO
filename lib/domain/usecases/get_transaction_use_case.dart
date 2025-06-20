import 'package:coinio_app/data/repositories/transaction_repository.dart';
import 'package:coinio_app/domain/models/transaction/transaction.dart';

class GetTransactionUseCase {
  final TransactionRepository repository;

  GetTransactionUseCase({required this.repository});

  Future<Transaction> call(int id) async {
    return await repository.getTransaction(id);
  }
}
