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
