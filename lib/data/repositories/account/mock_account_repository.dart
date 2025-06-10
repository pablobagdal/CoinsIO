import 'package:coinio_app/data/repositories/account/account_repository.dart';
import 'package:coinio_app/domain/models/account/account.dart';

class MockAccountRepository implements AccountRepository {
  @override
  Future<Account> getAccount(int id) async {
    await Future.delayed(Duration(seconds: 1));

    return Account(
      balance: "1000.0",
      userId: 1,
      id: 1,
      name: "Основной счёт",
      currency: "RUB",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  @override
  Future<void> updateAccount(Account account) async {
    await Future.delayed(Duration(seconds: 1));

    // Simulate to remember change time of update
    final updatedAccount = Account(
      id: account.id,
      userId: account.userId,
      name: account.name,
      balance: account.balance,
      currency: account.currency,
      createdAt: account.createdAt,
      updatedAt: DateTime.now(),
    );

    // TODO add logger instead of print
    print("Account updated: ${account.name}, Balance: ${account.balance}");
  }
}
