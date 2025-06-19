import 'package:flutter/cupertino.dart';
import 'package:jobmaniaapp/app/app.dart';

import 'package:jobmaniaapp/core/network/hive_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService().init();

  runApp(JobManiaApp());
}
