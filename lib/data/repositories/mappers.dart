import 'package:coinio_app/data/datasource/local/local_data_source/app_database.dart';
import 'package:coinio_app/domain/models/account/account.dart';

Account accountFromDb(AccountTableData row) {
  return Account(
    id: row.id,
    userId: row.userId,
    name: row.name,
    balance: row.balance,
    currency: row.currency,
    createdAt: row.createdAt,
    updatedAt: row.updatedAt,
  );
}
