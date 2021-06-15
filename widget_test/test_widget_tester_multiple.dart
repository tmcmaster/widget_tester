import 'package:flutter/material.dart';
import 'package:lipsum/lipsum.dart' as lipsum;
import 'package:widget_tester/widget_tester_app.dart';
import 'package:widget_tester/widget_tester_options.dart';

/// --no-sound-null-safety is required
void main() {
  runApp(WidgetTesterApp(
    options: WidgetTesterOptions(
      columns: 2,
      aspectRatio: 9 / 16,
    ),
    children: [
      Text(
        'Push the button to do an action.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
          color: Colors.yellow,
        ),
      ),
      ElevatedButton(
        onPressed: () {},
        child: Text('This is a button with a long title.'),
      ),
      ...[1, 2, 3, 4, 5, 6]
          .map((i) => Text(
                '${lipsum.createSentence(sentenceLength: i * 4)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.yellow,
                ),
              ))
          .toList(),
    ],
  ));
}
