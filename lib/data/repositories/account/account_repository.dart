import 'package:coinio_app/domain/models/account/account.dart';

abstract class AccountRepository {
  Future<Account> getAccount(int id);
  Future<void> updateAccount(Account account);
  //Future<List<Account>> getAccounts();
  //Future<void> addAccount(Account account);
  //Future<List<AccountHistory>> getAccountHistory(int id);
}
