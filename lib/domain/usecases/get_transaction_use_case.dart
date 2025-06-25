import 'package:coinio_app/domain/repositories/transaction_repository.dart';
import 'package:coinio_app/domain/models/transaction_response/transaction_response.dart';

class GetTransactionUseCase {
  final TransactionRepository repository;

  GetTransactionUseCase({required this.repository});

  Future<TransactionResponse> call(int id) async =>
      await repository.getTransaction(id: id);
}
