import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final String description;
  final String createdAt;
  final String color;

  NoteCard({
    required this.title,
    required this.description,
    required this.createdAt,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final String formatedDate = createdAt.substring(0, createdAt.length - 7);

    return Card(
      elevation: 6,
      margin: EdgeInsets.fromLTRB(24, 16, 24, 8),
      color: Color(int.parse(color)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              formatedDate,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 12,
                decoration: TextDecoration.underline,
              ),
            ),
            SizedBox(height: 16),
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
