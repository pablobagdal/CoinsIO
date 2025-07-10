import 'package:coinio_app/core/utils/di.dart';
import 'package:flutter/material.dart';
import 'package:coinio_app/ui/widgets/my_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  // setupDependencies(db);
  setupMockDependencies();

  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  runApp(const MyApp());
}
