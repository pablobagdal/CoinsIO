import 'package:coinio_app/domain/models/transaction_request/transaction_request.dart';
import 'package:coinio_app/domain/repositories/transaction_repository.dart';

class UpdateTransactionUsecase {
  final TransactionRepository repository;

  UpdateTransactionUsecase({required this.repository});

  Future<void> call({
    required final int id,
    required final TransactionRequest transaction,
  }) async {
    await repository.updateTransaction(id: id, transaction: transaction);
  }
}
