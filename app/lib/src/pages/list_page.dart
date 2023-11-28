import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;
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
  // // ignore: prefer_final_fields, unnecessary_this
  late Future<List<NoteModel>> _notesData = fetchNotes();

  Future<void> handleDelete(String id) async {
    await deleteNotes(id);
    Future<List<NoteModel>> notes = fetchNotes();

    setState(() {
      _notesData = notes;
    });
  }

  Future<void> handleUpdate(NoteModel note) async {
    Navigator.of(context).pushNamed('/add-note', arguments: note);
  }

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
          future: _notesData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final notes = snapshot.data!;
              return ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return NoteCard(
                    delete: handleDelete,
                    id: note.id!,
                    title: note.title!,
                    description: note.description!,
                    createdAt: note.createdAt.toString(),
                    color: note.color!,
                    priority: note.priority ?? 0,
                    isActive: note.isActive ?? 0,
                    tags: note.tags ?? '',
                    update: handleUpdate,
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

  Future<List<NoteModel>> fetchNotes() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/notes'));
    // await http.get(Uri.parse('http://192.168.56.1:3000/notes'));

    if (response.statusCode == 200) {
      dynamic decoded = json.decode(response.body);

      if (!decoded.containsKey('notes')) {
        return [];
      }

      Iterable list = decoded['notes'];

      return list.map((note) => NoteModel.fromJson(note)).toList();
      // Iterable list = json.decode(response.body);
      // return list.map((model) => NoteModel.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load notes');
    }
  }

  Future<void> deleteNotes(String id) async {
    final response =
        await http.delete(Uri.parse('http://10.0.2.2:3000/notes/$id'));

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to delete note');
    }
  }
}
