import 'package:coinio_app/domain/models/transaction_request/transaction_request.dart';
import 'package:coinio_app/domain/repositories/transaction_repository.dart';

class AddTransactionUsecase {
  final TransactionRepository repository;

  AddTransactionUsecase({required this.repository});

  Future<void> call({required final TransactionRequest transaction}) async {
    await repository.addTransaction(transaction: transaction);
  }
}
