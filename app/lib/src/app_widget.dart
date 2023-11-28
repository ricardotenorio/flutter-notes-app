import 'package:flutter/material.dart';
import 'package:project/src/pages/add_note_page.dart';
import 'package:project/src/pages/backup_page.dart';
import 'package:project/src/pages/list_page.dart';

class AppWidget extends StatelessWidget {
  final title = 'Notes';
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
          brightness: Brightness.light, primarySwatch: Colors.deepPurple),
      initialRoute: '/',
      routes: {
        '/': (context) => ListPage(),
        '/add-note': (context) => AddNotePage(),
        '/backup': (context) => BackupPage(),
      },
    );
  }
}
