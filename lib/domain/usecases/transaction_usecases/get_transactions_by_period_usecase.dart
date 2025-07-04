import 'package:coinio_app/domain/repositories/transaction_repository.dart';
import 'package:coinio_app/domain/models/transaction_response/transaction_response.dart';

class GetTransactionsByPeriodUsecase {
  final TransactionRepository transactionRepository;

  GetTransactionsByPeriodUsecase({required this.transactionRepository});

  Future<List<TransactionResponse>> call({
    required final DateTime startDate,
    required final DateTime endDate,
    required final bool isIncome,
    // required final int id,
  }) async {
    final transactions = await transactionRepository.getTransactionsByPeriod(
      id: 1,
      startDate: startDate,
      endDate: endDate,
    );

    return transactions
        .where((final transaction) => transaction.category.isIncome == isIncome)
        .toList();
  }
}
// class GetTransactionsByPeriodUsecase {
//   final TransactionRepository repository;

//   GetTransactionsByPeriodUsecase({required this.repository});

//   Future<List<TransactionResponse>> call(
//     final DateTime? startDate,
//     final DateTime? endDate, {
//     required final int id,
//   }) async => await repository.getTransactionsByPeriod(
//     id: id,
//     startDate: startDate,
//     endDate: endDate,
//   );
// }
