import 'package:coinio_app/domain/repositories/transaction_repository.dart';
import 'package:coinio_app/domain/models/transaction_response/transaction_response.dart';

class GetTransactionUsecase {
  final TransactionRepository transactionRepository;

  GetTransactionUsecase({required this.transactionRepository});

  Future<TransactionResponse> call({required final int id}) async =>
      await transactionRepository.getTransaction(id: id);
}
