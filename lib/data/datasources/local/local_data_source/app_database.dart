import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'tables/tables.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [CategoryTable, AccountTable, TransactionTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (final Migrator m) async {
      await m.createAll();

      // вставка начальных данных
      await into(accountTable).insert(
        AccountTableCompanion.insert(
          name: 'Основной счёт',
          balance: '0.00',
          userId: 1,
          currency: 'RUB',
          // ... другие поля ...
        ),
      );

      // заготовленные категории
      await into(categoryTable).insert(
        CategoryTableCompanion.insert(
          id: const Value(0),
          name: 'Подработка',
          emoji: '💸',
          isIncome: true,
        ),
      );
      await into(categoryTable).insert(
        CategoryTableCompanion.insert(
          id: const Value(1),
          name: 'Зарплата',
          emoji: '💰',
          isIncome: true,
        ),
      );
      await into(categoryTable).insert(
        CategoryTableCompanion.insert(
          id: const Value(2),
          name: 'Машина',
          emoji: '🚗',
          isIncome: false,
        ),
      );
      await into(categoryTable).insert(
        CategoryTableCompanion.insert(
          id: const Value(3),
          name: 'Собака',
          emoji: '🐶',
          isIncome: false,
        ),
      );
      await into(categoryTable).insert(
        CategoryTableCompanion.insert(
          id: const Value(4),
          name: 'Питание',
          emoji: '🍔',
          isIncome: false,
        ),
      );

      // заготовленные транзакции
      await into(transactionTable).insert(
        TransactionTableCompanion.insert(
          accountId: 1,
          categoryId: 4,
          amount: '100.25',
          transactionDate: Value(
            DateTime.now().subtract(const Duration(days: 1)),
          ),
          comment: Value('Собачий корм'),
        ),
      );
      await into(transactionTable).insert(
        TransactionTableCompanion.insert(
          accountId: 1,
          categoryId: 0,
          amount: '500.00',
          transactionDate: Value(
            DateTime.now().subtract(const Duration(days: 2)),
          ),
          comment: Value('Фриланс'),
        ),
      );
      await into(transactionTable).insert(
        TransactionTableCompanion.insert(
          accountId: 1,
          categoryId: 1,
          amount: '35000.00',
          transactionDate: Value(
            DateTime.now().subtract(const Duration(days: 3)),
          ),
          comment: Value('Зарплата за июнь'),
        ),
      );
      await into(transactionTable).insert(
        TransactionTableCompanion.insert(
          accountId: 1,
          categoryId: 2,
          amount: '1200.00',
          transactionDate: Value(
            DateTime.now().subtract(const Duration(days: 4)),
          ),
          comment: Value('Бензин'),
        ),
      );
      await into(transactionTable).insert(
        TransactionTableCompanion.insert(
          accountId: 1,
          categoryId: 2,
          amount: '800.00',
          transactionDate: Value(
            DateTime.now().subtract(const Duration(days: 5)),
          ),
          comment: Value('Мойка машины'),
        ),
      );
      await into(transactionTable).insert(
        TransactionTableCompanion.insert(
          accountId: 1,
          categoryId: 3,
          amount: '250.00',
          transactionDate: Value(
            DateTime.now().subtract(const Duration(days: 6)),
          ),
          comment: Value('Ветклиника'),
        ),
      );
      await into(transactionTable).insert(
        TransactionTableCompanion.insert(
          accountId: 1,
          categoryId: 3,
          amount: '1200.00',
          transactionDate: Value(
            DateTime.now().subtract(const Duration(days: 7)),
          ),
          comment: Value('Груминг'),
        ),
      );
      await into(transactionTable).insert(
        TransactionTableCompanion.insert(
          accountId: 1,
          categoryId: 4,
          amount: '1500.00',
          transactionDate: Value(
            DateTime.now().subtract(const Duration(days: 8)),
          ),
          comment: Value('Продукты'),
        ),
      );
      await into(transactionTable).insert(
        TransactionTableCompanion.insert(
          accountId: 1,
          categoryId: 4,
          amount: '350.00',
          transactionDate: Value(
            DateTime.now().subtract(const Duration(days: 9)),
          ),
          comment: Value('Кофе и булочка'),
        ),
      );
      await into(transactionTable).insert(
        TransactionTableCompanion.insert(
          accountId: 1,
          categoryId: 0,
          amount: '700.00',
          transactionDate: Value(
            DateTime.now().subtract(const Duration(days: 10)),
          ),
          comment: Value('Разовая подработка'),
        ),
      );
      await into(transactionTable).insert(
        TransactionTableCompanion.insert(
          accountId: 1,
          categoryId: 1,
          amount: '34000.00',
          transactionDate: Value(
            DateTime.now().subtract(const Duration(days: 11)),
          ),
          comment: Value('Зарплата за май'),
        ),
      );
    },
    onUpgrade: (final Migrator m, final int from, final int to) async {
      // Миграции при обновлении схемы
    },
  );
}

LazyDatabase _openConnection() => LazyDatabase(() async {
  final dbFolder = await getApplicationDocumentsDirectory();
  final file = File(join(dbFolder.path, 'db.sqlite'));

  return NativeDatabase.createInBackground(file);
});
