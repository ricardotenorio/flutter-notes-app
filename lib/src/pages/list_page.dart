import 'package:flutter/material.dart';
import 'package:project/src/components/drawer_menu.dart';
import 'package:project/src/components/note_card.dart';
import 'package:project/src/database/database_provider.dart';
import 'package:project/src/models/note_model.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      appBar: AppBar(
        title: const Text('Notes'),
        // foregroundColor: Colors.cyan,
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: FutureBuilder<List<NoteModel>>(
          future: DatabaseProvider().getAll(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final notes = snapshot.data!;
              return ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return NoteCard(
                    title: note.title!,
                    description: note.description!,
                    createdAt: note.createdAt.toString(),
                    color: note.color!,
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add-note');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
