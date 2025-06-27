import 'package:flutter/cupertino.dart';
import 'package:jobmaniaapp/app/app.dart';
import 'package:jobmaniaapp/app/service_locator/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();
  runApp(JobManiaApp());
}
