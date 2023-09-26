import 'package:flutter/material.dart';
import 'package:project/src/database/database_provider.dart';
import 'package:project/src/enums/header_colors.dart';
import 'package:project/src/models/note_model.dart';

class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  int _selectedColor = HeaderColors.green.value; // Default color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
              maxLength: 32,
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLength: 256,
              maxLines: 3,
            ),
            const SizedBox(height: 16.0),
            const Text('Select a Color:'),
            const SizedBox(height: 8.0),
            DropdownButton<int>(
              value: _selectedColor,
              onChanged: (value) {
                setState(() {
                  _selectedColor = value ?? 0xFF4CAF50;
                });
              },
              items: HeaderColors.values.map((color) {
                return DropdownMenuItem<int>(
                  value: color.value,
                  child: Text(color.name),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                if (_titleController.text == '') {
                  _titleController.text = 'NA';
                }

                if (_descriptionController.text == '') {
                  _descriptionController.text = 'NA';
                }

                final note = NoteModel(
                    title: _titleController.text,
                    description: _descriptionController.text,
                    color: '$_selectedColor');

                await DatabaseProvider().insert(note);

                Navigator.of(context).popAndPushNamed('/');
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
