import 'package:flutter/material.dart';
import 'package:project/src/components/drawer_menu.dart';

class BackupPage extends StatelessWidget {
  const BackupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Backup Data'),
      ),
      drawer: const DrawerMenu(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Backup your data:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: null,
              // Enable or disable the button based on the isBackupEnabled flag
              child: Text('Backup'),
            ),
          ],
        ),
      ),
    );
  }
}
