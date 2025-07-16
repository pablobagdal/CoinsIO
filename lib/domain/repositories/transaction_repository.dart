import 'package:dartz/dartz.dart';
import 'package:coinio_app/core/datasource_failures.dart';
import 'package:coinio_app/data/models/freezed_models/transaction_models/transaction_model.dart';
import 'package:coinio_app/data/models/freezed_models/transaction_models/transaction_request_model.dart';
import 'package:coinio_app/data/models/freezed_models/transaction_models/transaction_response_model.dart';
import 'package:coinio_app/domain/entity/synced_response.dart';

abstract class TransactionRepository {
  Future<Either<Failure, SyncedResponse<TransactionModel>>> createTransaction(
    TransactionRequestModel newTransaction,
  );

  Future<Either<Failure, SyncedResponse<TransactionResponseModel>>>
  updateTransactionById(int id, TransactionRequestModel updatedTransaction);

  Future<Either<Failure, SyncedResponse<void>>> removeTransactionById(int id);

  Future<Either<Failure, SyncedResponse<List<TransactionResponseModel>>>>
  getTransactionsInPeriod(
    int accountId, {
    DateTime? startDate,
    DateTime? endDate,
  });
}
