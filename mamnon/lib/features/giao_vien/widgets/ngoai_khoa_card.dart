import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final String title;
  final String start;
  final String end;
  final String description;

  const ActivityCard({
    super.key,
    required this.title,
    required this.start,
    required this.end,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(title: Text(title), subtitle: Text('Từ $start đến $end')),
    );
  }
}
