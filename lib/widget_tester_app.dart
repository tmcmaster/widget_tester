import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widget_tester/widget_tester.dart';
import 'package:widget_tester/widget_tester_options.dart';

class WidgetTesterApp extends StatelessWidget {
  late final WidgetTesterOptions? _options;
  final List<Widget> children;
  static const String title = 'Testing WidgetTester';
  WidgetTesterApp({
    Key? key,
    options,
    required this.children,
  }) : super(key: key) {
    _options = options;
  }

  WidgetTesterOptions get options => _options ?? WidgetTesterOptions();

  @override
  Widget build(BuildContext context) {
    print('--------  $options');
    return MaterialApp(
      title: title,
      theme: ThemeData.dark(),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(title),
          ),
          body: ProviderScope(
            child: Column(
              children: [
                WidgetTester(
                  options: options,
                  children: children,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
