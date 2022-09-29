import 'package:flutter/material.dart';
import 'package:scanestein/constants.dart';

class generatorOptions extends StatelessWidget {
  generatorOptions(
      {required this.icon, required this.label, required this.onPressed});

  final icon;
  final label;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3.0,
        child: TextButton.icon(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: Color(0xff101920),
          ),
          label: Text(label, style: kChoiceTextButton),
        ),
      ),
    );
  }
}