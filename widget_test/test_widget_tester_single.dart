import 'package:flutter/material.dart';
import 'package:lipsum/lipsum.dart' as lipsum;
import 'package:widget_tester/widget_tester_app.dart';

/// --no-sound-null-safety is required
void main() {
  runApp(WidgetTesterApp(
    children: [
      Text(
        '${lipsum.createParagraph(numParagraphs: 4)}',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
          color: Colors.yellow,
        ),
      ),
    ],
  ));
}
