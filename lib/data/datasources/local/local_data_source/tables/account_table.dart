import 'package:drift/drift.dart';

class AccountTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get userId => integer()();
  TextColumn get name => text()();
  TextColumn get balance => text()();
  TextColumn get currency => text()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
