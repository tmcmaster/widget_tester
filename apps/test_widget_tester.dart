import 'package:flutter/material.dart';
import 'package:widget_tester/widget_tester_app.dart';
import 'package:widget_tester/widget_tester_options.dart';

void main() {
  runApp(WidgetTesterApp(
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
    ],
  ));
}

void main2() {
  runApp(WidgetTesterApp(
    options: WidgetTesterOptions(
      columns: 3,
      border: BorderOptions(
        margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
        color: Colors.yellow,
      ),
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
      ...[1, 2, 3, 4, 5, 6].map((i) => Text('Text $i')).toList(),
    ],
  ));
}
