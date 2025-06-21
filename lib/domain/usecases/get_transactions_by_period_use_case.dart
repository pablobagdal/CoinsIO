import 'package:coinio_app/data/repositories/transaction_repository.dart';
import 'package:coinio_app/domain/models/transaction_response/transaction_response.dart';

class GetTransactionsByPeriodUseCase {
  final TransactionRepository repository;

  GetTransactionsByPeriodUseCase({required this.repository});

  Future<List<TransactionResponse>> call(
    DateTime? startDate,
    DateTime? endDate, {
    required int id,
  }) async {
    return await repository.getTransactionsByPeriod(
      id: id,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
