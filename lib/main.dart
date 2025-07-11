import 'package:coinio_app/core/utils/di.dart';
import 'package:flutter/material.dart';
import 'package:coinio_app/ui/widgets/my_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:worker_manager/worker_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // choose setup to use mocks or real data in DB and backend
  setupDependencies();
  // setupMockDependencies();

  // TODO try to move it to DI (getIt)
  workerManager.log = true;
  workerManager.init(isolatesCount: 4, dynamicSpawning: true);

  // access sensitive values like API_TOKEN (you have to create this file)
  // .env.example as an example
  await dotenv.load(fileName: '.env');

  runApp(const MyApp());
}
