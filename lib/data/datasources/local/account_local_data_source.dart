import 'package:coinio_app/data/datasources/local/db/app_database.dart';
import 'package:coinio_app/domain/entities/account.dart';
import 'package:drift/drift.dart';

class AccountLocalDataSource {
  final AppDatabase db;

  AccountLocalDataSource({required this.db});

  // Получение всех аккаунтов из локальной БД
  Future<List<Account>> getCachedAccounts() async {
    final accounts = await db.select(db.accountTable).get();
    return accounts
        .map(
          (account) => Account(
            id: account.id,
            name: account.name,
            userId: account.userId,
            balance: account.balance,
            currency: account.currency,
            createdAt: account.createdAt,
            updatedAt: account.updatedAt,
          ),
        )
        .toList();
  }

  // Кэширование аккаунтов
  Future<void> cacheAccounts(List<Account> accounts) async {
    await db.batch((batch) {
      batch.deleteAll(db.accountTable); // Очищаем старые данные
      batch.insertAll(
        db.accountTable,
        accounts.map(
          (account) => AccountTableCompanion.insert(
            id: Value(account.id),
            name: account.name,
            userId: account.id,
            balance: account.balance,
            currency: account.currency,
            // другие поля
          ),
        ),
      );
    });
  }

  // Добавление одного аккаунта
  Future<int> insertAccount(Account account) async => await db
      .into(db.accountTable)
      .insert(
        AccountTableCompanion.insert(
          name: account.name,
          userId: account.userId,
          balance: account.balance,
          currency: account.currency,
        ),
      );

  // Удаление аккаунта
  Future<int> deleteAccount(int id) async =>
      await (db.delete(db.accountTable)
        ..where((tbl) => tbl.id.equals(id))).go();

  // Обновление аккаунта
  Future<bool> updateAccount(Account account) async => await db
      .update(db.accountTable)
      .replace(
        AccountTableData(
          id: account.id,
          name: account.name,
          userId: account.userId,
          balance: account.balance,
          currency: account.currency,
          createdAt: account.createdAt,
          updatedAt: account.updatedAt,
          // другие поля
        ),
      );
}
