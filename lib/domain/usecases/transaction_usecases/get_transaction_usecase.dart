import 'package:coinio_app/domain/repositories/transaction_repository.dart';
import 'package:coinio_app/domain/models/transaction_response/transaction_response.dart';

class GetTransactionUsecase {
  final TransactionRepository repository;

  GetTransactionUsecase({required this.repository});

  Future<TransactionResponse> call({required final int id}) async =>
      await repository.getTransaction(id: id);
}
