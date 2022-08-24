import 'package:flutter/material.dart';

class PlantInfo extends StatelessWidget {
  PlantInfo({Key? key, required this.text, required this.icon})
      : super(key: key);
  String text;
  IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
        ),
        Text(text),
      ],
    );
  }
}
