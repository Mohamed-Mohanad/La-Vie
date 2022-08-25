import 'package:flutter/material.dart';

class PlantInfoItem extends StatelessWidget {
  PlantInfoItem({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
        ),
        Text(
          text,
        ),
      ],
    );
  }
}
