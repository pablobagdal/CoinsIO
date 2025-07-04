import 'package:coinio_app/core/utils/di.dart';
import 'package:flutter/material.dart';

import 'package:coinio_app/ui/widgets/my_app.dart';

import 'package:coinio_app/data/datasource/local/local_data_source/app_database.dart';

void main() {
  final db = AppDatabase();
  setupDependencies(db);

  runApp(MyApp(db: db));
}
