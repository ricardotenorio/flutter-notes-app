import 'dart:async';
import 'package:path/path.dart';
import 'package:project/src/models/note_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static late Database _database;

  Future<void> open() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'notes_app.db');

    _database = await openDatabase(
      path,
      version: 2,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE notes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            color TEXT,
            created_at TEXT
          )
        ''');
      },
    );
  }

  Future<int> insert(NoteModel note) async {
    final row = note.toMap();
    return await _database.insert('notes', row);
  }

  Future<List<NoteModel>> getAll() async {
    var result = await _database.query('notes', orderBy: 'created_at desc');

    if (result.isNotEmpty) {
      final notes = result.map((e) => NoteModel.fromMap(e)).toList();
      return notes;
    }

    return [];
  }

  Future<NoteModel?> getById(int id) async {
    var result =
        await _database.query('notes', where: 'id = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      final notes = NoteModel.fromMap(result.first);
      return notes;
    }

    return null;
  }

  Future close() async => _database.close();
}
