import 'package:coinio_app/data/models/transaction/transaction_request_model.dart';
import 'package:coinio_app/domain/repositories/transaction_repository.dart';

class UpdateTransactionUsecase {
  final TransactionRepository transactionRepository;

  UpdateTransactionUsecase({required this.transactionRepository});

  Future<void> call({
    required final int id,
    required final TransactionRequest transaction,
  }) async {
    await transactionRepository.updateTransaction(
      id: id,
      transaction: transaction,
    );
  }
}
