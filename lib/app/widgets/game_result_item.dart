import 'package:flutter/material.dart';

class GameResultItem extends StatelessWidget {
  final String title;
  final int number;
  GameResultItem({
    required this.title,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$number',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          '$title',
          style: TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
