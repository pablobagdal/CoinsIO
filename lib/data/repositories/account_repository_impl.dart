import 'package:coinio_app/data/datasource/local/local_data_source/app_database.dart';
import 'package:coinio_app/data/repositories/mappers.dart';
import 'package:coinio_app/domain/models/account/account.dart';
import 'package:coinio_app/domain/models/account_create_request/account_create_request.dart';
import 'package:coinio_app/domain/models/account_history_response/account_history_response.dart';
import 'package:coinio_app/domain/models/account_update_request/account_update_request.dart';
import 'package:coinio_app/domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AppDatabase db;

  AccountRepositoryImpl({required this.db});

  @override
  Future<void> addAccount({required AccountCreateRequest account}) {
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
}
