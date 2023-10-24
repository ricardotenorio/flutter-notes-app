import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:project/src/database/database_provider.dart';
import 'package:project/src/enums/header_colors.dart';
import 'package:project/src/enums/priorities.dart';
import 'package:project/src/enums/tags.dart';
import 'package:project/src/models/note_model.dart';

class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  int _selectedColor = HeaderColors.green.value;
  bool _isActive = false;
  int priority = 0;
  List<bool> isCheckedTagsList = List.filled(Tags.values.length, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add New Note'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  maxLength: 32,
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  maxLength: 256,
                  maxLines: 3,
                ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Active',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Switch(
                      value: _isActive,
                      onChanged: (value) {
                        setState(() {
                          _isActive = value;
                        });
                      },
                    ),
                  ],
                ),
                const Text('Priority',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 160,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: Priorities.values.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        horizontalTitleGap: 0,
                        title: Text(Priorities.values
                            .firstWhere((element) => element.index == index)
                            .toString()
                            .split('.')[1]),
                        leading: Radio(
                          value: index,
                          groupValue: priority,
                          onChanged: (value) {
                            setState(() {
                              priority = value!;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                const Text('Tags',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: List.generate(
                    Tags.values.length,
                    (index) => CheckboxListTile(
                      title: Text(Tags.values
                          .firstWhere((element) => element.index == index)
                          .toString()
                          .split('.')[1]),
                      value: isCheckedTagsList[index],
                      onChanged: (value) {
                        setState(() {
                          isCheckedTagsList[index] = value!;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Select a Color:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
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
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_titleController.text.trim() == '') {
                      const snackBar = SnackBar(
                        content: Text('Title can\'t be empty!'),
                        backgroundColor: Color.fromARGB(255, 255, 51, 0),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }

                    if (_descriptionController.text.trim() == '') {
                      const snackBar = SnackBar(
                        content: Text('Description can\'t be empty!'),
                        backgroundColor: Color.fromARGB(255, 255, 51, 0),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }

                    final note = NoteModel(
                      title: _titleController.text.trim(),
                      description: _descriptionController.text.trim(),
                      color: '$_selectedColor',
                      isActive: _isActive ? 1 : 0,
                      priority: priority,
                      tags: formatTags(),
                    );

                    await DatabaseProvider().insert(note);

                    Navigator.of(context).popAndPushNamed('/');
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
            // resizeToAvoidBottomInset: false,
          ),
        ));
  }

  String formatTags() {
    List<String> tags = [];

    for (var i = 0; i < Tags.values.length; i++) {
      if (isCheckedTagsList[i]) {
        tags.add(Tags.values[i].toString().split('.')[1]);
      }
    }

    if (tags.isEmpty) {
      return '';
    }

    return tags.join(', ');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
