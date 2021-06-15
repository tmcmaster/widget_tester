import 'package:flutter/material.dart';
import 'package:widget_tester/widget_tester_app.dart';
import 'package:widget_tester/widget_tester_options.dart';

/// TODO: this is a work in progress, where I need to make an option for optionally expanding the widget to fill space.
void main() {
  runApp(WidgetTesterApp(
    options: WidgetTesterOptions(columns: 2),
    children: [
      Text('SSSSS'),
      Text('SSSSS'),
      Text('SSSSS'),
      SizedBox(
        width: 50,
        height: 50,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
          ),
          child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 35.0,
                maxHeight: 60.0,
              ),
              child: Text('SSSSS')),
        ),
      )
    ],
  ));
}
