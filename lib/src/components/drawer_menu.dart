import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        const UserAccountsDrawerHeader(
            accountName: Text(
              'Username',
              style: TextStyle(fontSize: 20),
            ),
            accountEmail: Text(
              'user@example.com',
              style: TextStyle(fontSize: 15),
            )),
        ListTile(
          leading: const Icon(Icons.list),
          title: const Text('Notes', style: TextStyle(fontSize: 20)),
          onTap: () => Navigator.of(context).pushNamed('/'),
        ),
        ListTile(
          leading: const Icon(Icons.add_to_drive),
          title: const Text('Backup Your Data', style: TextStyle(fontSize: 20)),
          onTap: () => Navigator.of(context).pushNamed('/backup'),
        )
      ]),
    );
  }
}
