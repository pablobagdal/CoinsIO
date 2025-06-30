import 'package:drift/drift.dart';

class TransactionTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get accountId => integer()();
  IntColumn get categoryId => integer()();

  TextColumn get amount => text()();
  DateTimeColumn get transactionDate =>
      dateTime().withDefault(currentDateAndTime)();

  TextColumn get comment => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
