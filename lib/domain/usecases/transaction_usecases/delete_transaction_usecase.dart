import 'package:coinio_app/domain/repositories/transaction_repository.dart';

class DeleteTransactionUsecase {
  final TransactionRepository repository;

  DeleteTransactionUsecase({required this.repository});

  Future<void> call({required final int id}) async {
    await repository.deleteTransaction(id: id);
  }
}
