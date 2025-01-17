import 'package:flutter/cupertino.dart';
import 'package:food_delivery_application/app/app.dart';
import 'package:food_delivery_application/app/di/di.dart';
import 'package:food_delivery_application/core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService().init();
  await initDependencies();
  runApp(
    App(),
  );
}
