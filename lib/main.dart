import 'package:flutter/cupertino.dart';
import 'package:jobmaniaapp/app/app.dart';

import 'package:jobmaniaapp/core/network/hive_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await initDependencies();
  // init Hive service
  await HiveService().init();
  // Delete database
  // await HiveService().clearAll();
  runApp(JobManiaApp());
}
