import 'package:coinio_app/data/repositories/account_repository.dart';
import 'package:coinio_app/domain/models/account/account.dart';
import 'package:coinio_app/domain/models/account_create_request/account_create_request.dart';
import 'package:coinio_app/domain/models/account_history/account_history.dart';
import 'package:coinio_app/domain/models/account_history_response/account_history_response.dart';
import 'package:coinio_app/domain/models/account_state/account_state.dart';
import 'package:coinio_app/domain/models/account_update_request/account_update_request.dart';

class MockAccountRepository implements AccountRepository {
  @override
  Future<Account> getAccount({required final id}) async {
    await Future.delayed(const Duration(seconds: 1));

    Account account = _mockAccount(id: id);

    return account;
  }

  @override
  Future<void> updateAccount({
    required final AccountUpdateRequest account,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    // TODO add logger instead of prints
    print('Account updated: ${account.name}, Balance: ${account.balance}');
  }

  @override
  Future<void> addAccount({required final AccountCreateRequest account}) async {
    await Future.delayed(const Duration(seconds: 1));

    print(
      'Account successfully added: ${account.name}, Balance: ${account.balance}',
    );
  }

  @override
  Future<AccountHistoryResponse> getAccountHistory({
    required final int id,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    AccountHistoryResponse history = _mockHistory(id);

    return history;
  }

  @override
  Future<List<Account>> getAccounts() async {
    await Future.delayed(const Duration(seconds: 1));

    List<Account> accounts = _mockAccounts();

    return accounts;
  }

  List<Account> _mockAccounts() => [
    Account(
      id: 1,
      userId: 1,
      name: 'Основной счёт',
      balance: '1000.00',
      currency: 'RUB',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Account(
      id: 2,
      userId: 1,
      name: 'Сбережения',
      balance: '5000.00',
      currency: 'USD',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  AccountHistoryResponse _mockHistory(final int id) => AccountHistoryResponse(
    accountId: 1,
    accountName: 'Основной счёт',
    currency: 'RUB',
    currentBalance: '100.00',
    history: [
      AccountHistory(
        id: 1,
        accountId: id,
        changeType: ChangeType.creation,
        previousState: const AccountState(
          id: 0,
          name: 'Начальное состояние',
          balance: '0.00',
          currency: 'RUB',
        ),
        newState: const AccountState(
          id: 1,
          name: 'Следующее состояние',
          balance: '100.00',
          currency: 'RUB',
        ),
        changeTimestamp: DateTime.now().subtract(const Duration(days: 10)),
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
      ),
      AccountHistory(
        id: 1,
        accountId: id,
        changeType: ChangeType.creation,
        previousState: const AccountState(
          id: 1,
          name: 'Следующее состояние',
          balance: '100.00',
          currency: 'RUB',
        ),
        newState: const AccountState(
          id: 2,
          name: 'Следующее состояние 2',
          balance: '1000.00',
          currency: 'RUB',
        ),
        changeTimestamp: DateTime.now().subtract(const Duration(days: 9)),
        createdAt: DateTime.now().subtract(const Duration(days: 9)),
      ),
    ],
  );

  Account _mockAccount({required final int id}) => Account(
    balance: '1000.00',
    userId: id,
    id: 1,
    name: 'Основной счёт',
    currency: 'RUB',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
}
