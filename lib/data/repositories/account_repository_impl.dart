import 'package:coinio_app/data/datasources/local/local_data_source/app_database.dart';
import 'package:coinio_app/core/utils/mappers.dart';
import 'package:coinio_app/data/models/account/account_model.dart';
import 'package:coinio_app/data/models/account/account_create_request_model.dart';
import 'package:coinio_app/data/models/account/account_history_response_model.dart';
import 'package:coinio_app/data/models/account/account_update_request_model.dart';
import 'package:coinio_app/domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AppDatabase db;

  AccountRepositoryImpl({required this.db});

  @override
  Future<void> addAccount({required AccountCreateRequestModel account}) {
    // TODO: implement addAccount
    throw UnimplementedError();
  }

  @override
  Future<Account> getAccount({required int id}) async {
    final row =
        await ((db.select(db.accountTable))
          ..where((acc) => acc.id.equals(id))).getSingle();
    return accountFromDb(row);
  }

  @override
  Future<AccountHistoryResponse> getAccountHistory({required int id}) {
    // TODO: implement getAccountHistory
    throw UnimplementedError();
  }

  @override
  Future<List<Account>> getAccounts() async {
    final row = await (db.select(db.accountTable)).get();
    return row.map((final acc) => accountFromDb(acc)).toList();
  }

  @override
  Future<void> updateAccount({required AccountUpdateRequest account}) {
    // TODO: implement updateAccount
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAccount({required int id}) {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }
}
