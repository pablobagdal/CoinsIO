import 'package:coinio_app/domain/models/transaction_request/transaction_request.dart';
import 'package:coinio_app/domain/repositories/transaction_repository.dart';

class AddTransactionUsecase {
  final TransactionRepository transactionRepository;

  AddTransactionUsecase({required this.transactionRepository});

  Future<void> call({required final TransactionRequest transaction}) async {
    await transactionRepository.addTransaction(transaction: transaction);
  }
}
