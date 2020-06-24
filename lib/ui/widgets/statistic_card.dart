import 'package:flutter/material.dart';

class StatisticCard extends StatelessWidget {
  final Color color;
  final String title;
  final int count;

  const StatisticCard({
    @required this.color,
    @required this.title,
    @required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: ListTile(
        title: Text(
          '$count',
          style: TextStyle(
            color: color,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('$title'),
        // trailing: IconButton(icon: Icon(Icons.arrow_forward), onPressed: () {}),
      ),
    );
  }
}
