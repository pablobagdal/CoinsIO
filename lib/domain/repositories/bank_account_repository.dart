import 'package:dartz/dartz.dart';
import 'package:coinio_app/core/datasource_failures.dart';
import 'package:coinio_app/data/models/freezed_models/account_models/account_history_response_model.dart';
import 'package:coinio_app/data/models/freezed_models/account_models/account_model.dart';
import 'package:coinio_app/data/models/freezed_models/account_models/account_update_request_model.dart';
import 'package:coinio_app/domain/entity/synced_response.dart';

abstract class BankAccountRepository {
  Future<Either<Failure, SyncedResponse<List<AccountModel>>>> getAccounts();

  Future<Either<Failure, SyncedResponse<AccountModel>>> getAccountById(int id);

  Future<Either<Failure, SyncedResponse<AccountModel>>> updateAccountById(
    int id,
    AccountUpdateRequestModel updatedAccount,
  );

  Future<Either<Failure, SyncedResponse<AccountHistoryResponseModel>>>
  getAccountHistory(int id);
}
