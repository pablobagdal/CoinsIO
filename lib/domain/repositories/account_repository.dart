import 'package:coinio_app/domain/models/account/account.dart';
import 'package:coinio_app/domain/models/account_create_request/account_create_request.dart';
import 'package:coinio_app/domain/models/account_history_response/account_history_response.dart';
import 'package:coinio_app/domain/models/account_update_request/account_update_request.dart';

abstract class AccountRepository {
  /// Возвращает список всех счетов текущего пользователя
  Future<List<Account>> getAccounts();

  /// Создает новый счет для текущего пользователя
  Future<void> addAccount({required final AccountCreateRequest account});

  /// Возвращает информацию о конкретном счете, включая статистику
  Future<Account> getAccount({required final int id});

  /// Обновляет данные существующего счета
  Future<void> updateAccount({required final AccountUpdateRequest account});

  /// Возвращает историю изменений баланса и других параметров счета,
  /// произведенных вне транзакций (при создании или изменении счета)
  Future<AccountHistoryResponse> getAccountHistory({required final int id});

  Future<void> deleteAccount({required final int id});
}
