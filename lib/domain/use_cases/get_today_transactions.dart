import 'package:dartz/dartz.dart' show Either;
import 'package:coinio_app/core/datasource_failures.dart' show Failure;
import 'package:coinio_app/data/models/freezed_models/transaction_models/transaction_response_model.dart';
import 'package:coinio_app/domain/use_cases/get_current_account_transactions_in_period.dart';

class GetTodayTransactions {
  final GetCurrentAccountTransactionsInPeriod currentAccountTransactionsUseCase;

  GetTodayTransactions(this.currentAccountTransactionsUseCase);

  Future<Either<Failure, List<TransactionResponseModel>>> call(
    bool isIncome,
  ) async {
    return currentAccountTransactionsUseCase(
      isIncome,
      DateTime.now(),
      DateTime.now(),
    );
  }
}
