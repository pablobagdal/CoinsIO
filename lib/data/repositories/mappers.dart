import 'package:coinio_app/data/datasources/local/local_data_source/app_database.dart';
import 'package:coinio_app/data/models/account/account.dart';

Account accountFromDb(AccountTableData row) => Account(
  id: row.id,
  userId: row.userId,
  name: row.name,
  balance: row.balance,
  currency: row.currency,
  createdAt: row.createdAt,
  updatedAt: row.updatedAt,
);
