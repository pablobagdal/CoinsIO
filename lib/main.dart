import 'package:coinio_app/data/repositories/transaction_repository.dart';
import 'package:coinio_app/data/services/local/mock_transaction_repository.dart';
import 'package:coinio_app/domain/usecases/get_transaction_use_case.dart';
import 'package:coinio_app/domain/usecases/get_transactions_by_period_use_case.dart';
import 'package:coinio_app/ui/widgets/my_app.dart';
import 'package:flutter/material.dart';

/// class with usecases shared around app
class AppDependencies {
  late final TransactionRepository transactionRepository;
  late final GetTransactionUseCase getTransactionUseCase;
  late final GetTransactionsByPeriodUseCase getTransactionsByPeriodUseCase;

  AppDependencies() {
    transactionRepository = MockTransactionRepository();
    getTransactionUseCase = GetTransactionUseCase(
      repository: transactionRepository,
    );
    getTransactionsByPeriodUseCase = GetTransactionsByPeriodUseCase(
      repository: transactionRepository,
    );
  }
}

void main(List<String> args) {
  final dependencies = AppDependencies();
  // ignore: prefer_const_constructors
  runApp(MyApp(dependencies: dependencies));
}
