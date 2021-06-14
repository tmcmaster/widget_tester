import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widget_tester/widget_tester.dart';

void main() {
  runApp(TestWidgetTester());
}

class TestWidgetTester extends StatelessWidget {
  static Widget create() => TestWidgetTester();

  static const String title = 'Scratch Area';
  const TestWidgetTester({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData.dark(),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(title),
          ),
          body: ProviderScope(
            child: Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.purple),
              ),
              child: Column(
                children: [
                  WidgetTester(
                    child: Text(
                      'Push the button to do an action.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                  WidgetTester(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('This is a button with a long title.'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
