import 'package:flutter/material.dart';
import 'package:project/src/database/database_provider.dart';
import 'package:project/src/enums/priorities.dart';

class NoteCard extends StatelessWidget {
  final int id;
  final String title;
  final String description;
  final String createdAt;
  final String color;
  final int priority;
  final int isActive;
  final String tags;
  final Function delete;

  NoteCard({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.color,
    required this.priority,
    required this.tags,
    required this.isActive,
    required this.delete,
  });

  @override
  Widget build(BuildContext context) {
    final String formatedDate = createdAt.substring(0, createdAt.length - 7);
    final String priorityText =
        Priorities.values[priority].toString().split('.')[1];
    final Color isActiveColor = isActive == 0
        ? const Color.fromARGB(255, 165, 165, 165)
        : const Color.fromARGB(255, 1, 255, 9);

    return GestureDetector(
        onDoubleTap: () => {delete(id)},
        child: Card(
          elevation: 6,
          margin: const EdgeInsets.fromLTRB(24, 16, 24, 8),
          color: Color(int.parse(color)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(alignment: WrapAlignment.spaceBetween, children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 14.0,
                    height: 14.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActiveColor,
                    ),
                  ),
                ]),
                const SizedBox(height: 8),
                Text(
                  formatedDate,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Priority: $priorityText',
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  tags,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
