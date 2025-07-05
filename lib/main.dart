import 'package:coinio_app/core/utils/di.dart';
import 'package:flutter/material.dart';
import 'package:coinio_app/ui/widgets/my_app.dart';

void main() {
  // setupDependencies(db);
  setupMockDependencies();

  runApp(const MyApp());
}
