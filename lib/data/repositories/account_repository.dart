import 'package:coinio_app/domain/models/account/account.dart';
import 'package:coinio_app/domain/models/account_history/account_history.dart';

abstract class AccountRepository {
  /// Возвращает список всех счетов текущего пользователя
  Future<List<Account>> getAccounts();

  /// Создает новый счет для текущего пользователя
  Future<void> addAccount({required final Account account});

  /// Возвращает информацию о конкретном счете, включая статистику
  Future<Account> getAccount({required final int id});

  /// Обновляет данные существующего счета
  Future<void> updateAccount({required final Account account});

  /// Возвращает историю изменений баланса и других параметров счета,
  /// произведенных вне транзакций (при создании или изменении счета)
  Future<List<AccountHistory>> getAccountHistory({required final int id});
}
