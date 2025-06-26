import 'package:coinio_app/domain/repositories/transaction_repository.dart';
import 'package:coinio_app/data/repositories/mock_transaction_repository.dart';
import 'package:coinio_app/domain/usecases/transactions/get_transaction_usecase.dart';
import 'package:coinio_app/domain/usecases/transactions/get_transactions_by_period_usecase.dart';
import 'package:coinio_app/ui/widgets/my_app.dart';
import 'package:flutter/material.dart';

// /// class with usecases shared around app
// class AppDependencies {
//   late final TransactionRepository transactionRepository;
//   late final GetTransactionUsecase getTransactionUseCase;
//   late final GetTransactionsByPeriodUsecase getTransactionsByPeriodUsecase;

//   AppDependencies() {
//     transactionRepository = MockTransactionRepository();
//     getTransactionUseCase = GetTransactionUsecase(
//       repository: transactionRepository,
//     );
//     getTransactionsByPeriodUsecase = GetTransactionsByPeriodUsecase(
//       repository: transactionRepository,
//     );
//   }
// }

void main(final List<String> args) {
  // final dependencies = AppDependencies();
  // ignore: prefer_const_constructors
  runApp(MyApp());
}
