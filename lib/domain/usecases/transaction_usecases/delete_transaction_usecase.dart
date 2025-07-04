import 'package:coinio_app/domain/repositories/transaction_repository.dart';

class DeleteTransactionUsecase {
  final TransactionRepository transactionRepository;

  DeleteTransactionUsecase({required this.transactionRepository});

  Future<void> call({required final int id}) async {
    await transactionRepository.deleteTransaction(id: id);
  }
}
