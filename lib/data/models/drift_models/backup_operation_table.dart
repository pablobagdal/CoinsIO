import 'package:drift/drift.dart';
import 'package:coinio_app/core/enums/entity_enum.dart';
import 'package:coinio_app/core/enums/operation_enum.dart';

class BackupOperationTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get entityType => intEnum<EntityEnum>()();
  IntColumn get operationType => intEnum<OperationEnum>()();
  IntColumn get localId => integer().unique()();
  IntColumn get remoteId => integer().nullable()();
  TextColumn get payload => text()();
  DateTimeColumn get timestamp => dateTime()();
}
