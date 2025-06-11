import 'package:coinio_app/data/repositories/account/account_repository.dart';
import 'package:coinio_app/domain/models/account/account.dart';
import 'package:coinio_app/domain/models/account_history/account_history.dart';
import 'package:coinio_app/domain/models/account_state/account_state.dart';

class MockAccountRepository implements AccountRepository {
  @override
  Future<Account> getAccount(int id) async {
    await Future.delayed(Duration(seconds: 1));

    Account account = _mockAccount(id);

    return account;
  }

  @override
  Future<void> updateAccount(Account account) async {
    await Future.delayed(Duration(seconds: 1));

    // TODO add logger instead of prints
    print("Account updated: ${account.name}, Balance: ${account.balance}");
  }

  @override
  Future<void> addAccount(Account account) async {
    await Future.delayed(Duration(seconds: 1));

    print(
      "Account successfully added: ${account.name}, Balance: ${account.balance}",
    );
  }

  @override
  Future<List<AccountHistory>> getAccountHistory(int id) async {
    await Future.delayed(Duration(seconds: 1));

    List<AccountHistory> history = _mockHistory(id);

    return history;
  }

  @override
  Future<List<Account>> getAccounts() async {
    await Future.delayed(Duration(seconds: 1));

    List<Account> accounts = _mockAccounts();

    return accounts;
  }

  List<Account> _mockAccounts() {
    return [
      Account(
        id: 1,
        userId: 1,
        name: "Основной счёт",
        balance: "1000.0",
        currency: "RUB",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Account(
        id: 2,
        userId: 1,
        name: "Сбережения",
        balance: "5000.0",
        currency: "USD",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];
  }

  List<AccountHistory> _mockHistory(int id) {
    return [
      AccountHistory(
        id: 1,
        accountId: id,
        changeType: ChangeType.CREATION,
        previousState: AccountState(
          id: 0,
          name: "Начальное состояние",
          balance: "0.0",
          currency: "RUB",
        ),
        newState: AccountState(
          id: 1,
          name: "Следующее состояние",
          balance: "100.0",
          currency: "RUB",
        ),
        changeTimestamp: DateTime.now().subtract(Duration(days: 10)),
        createdAt: DateTime.now().subtract(Duration(days: 10)),
      ),
      AccountHistory(
        id: 2,
        accountId: id,
        changeType: ChangeType.MODIFICATION,
        previousState: AccountState(
          id: 1,
          name: "Следующее состояние",
          balance: "1000.0",
          currency: "RUB",
        ),
        newState: AccountState(
          id: 2,
          name: "Последнее состояние",
          balance: "500.0",
          currency: "RUB",
        ),
        changeTimestamp: DateTime.now().subtract(Duration(days: 5)),
        createdAt: DateTime.now().subtract(Duration(days: 5)),
      ),
    ];
  }

  Account _mockAccount(int id) {
    return Account(
      balance: "1000.0",
      userId: id,
      id: 1,
      name: "Основной счёт",
      currency: "RUB",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
