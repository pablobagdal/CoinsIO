import 'package:coinio_app/data/datasources/local/account_local_data_source.dart';
import 'package:coinio_app/core/utils/mappers.dart';
import 'package:coinio_app/data/datasources/remote/account_remote_data_source.dart';
import 'package:coinio_app/domain/entities/account.dart';
import 'package:coinio_app/domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountRemoteDataSource remoteDataSource;
  final AccountLocalDataSource localDataSource;

  AccountRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<void> addAccount({required Account account}) {
    // TODO: implement addAccount
    throw UnimplementedError();
  }

  @override
  Future<Account> getAccount({required int id}) async {
    final db = localDataSource.db;

    final row =
        await ((db.select(db.accountTable))
          ..where((acc) => acc.id.equals(id))).getSingle();
    return accountFromDb(row);
  }

  @override
  Future<List<AccountHistory>> getAccountHistory({required int id}) {
    // TODO: implement getAccountHistory
    throw UnimplementedError();
  }

  @override
  Future<List<Account>> getAccounts() async {
    final db = localDataSource.db;
    final row = await (db.select(db.accountTable)).get();
    return row.map((final acc) => accountFromDb(acc)).toList();
  }

  @override
  Future<void> updateAccount({required Account account}) {
    // TODO: implement updateAccount
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAccount({required int id}) {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }
}
