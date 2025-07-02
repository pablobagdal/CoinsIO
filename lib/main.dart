import 'package:coinio_app/data/datasource/local/local_data_source/app_database.dart';
import 'package:coinio_app/ui/widgets/my_app.dart';
import 'package:flutter/material.dart';

void main() {
  final db = AppDatabase();

  runApp(MyApp(db: db));
}
