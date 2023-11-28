import 'package:flutter/material.dart';
import 'package:project/src/app_widget.dart';
import 'package:project/src/database/database_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final database = DatabaseProvider();
  // await database.open();
  runApp(const AppWidget());
}
