import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:coinio_app/core/service_locator.dart' as di;
import 'package:coinio_app/presentation/pages/material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await di.init();

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );

  runApp(const FinanceApp());
}
