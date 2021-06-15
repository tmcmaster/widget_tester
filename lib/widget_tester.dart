import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widget_tester/widget_tester_options.dart';
import 'package:widget_tester/widget_tester_providers.dart';
import 'package:widget_tester/widget_tester_size_controls.dart';
import 'package:widget_tester/widget_tester_view_pane.dart';

class WidgetTester extends ConsumerWidget {
  late final WidgetTesterOptions? _options;
  final List<Widget> children;

  WidgetTester({
    Key? key,
    options,
    this.children = const [],
  }) : super(key: key) {
    _options = options;
  }

  WidgetTesterOptions get options => _options ?? WidgetTesterOptions();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Expanded(
      child: Container(
        margin: options.border.margin,
        padding: options.border.padding,
        decoration: options.border.decoration,
        child: Column(
          children: [
            Container(
              margin: options.controlsBorder.margin,
              padding: options.controlsBorder.padding,
              decoration: options.controlsBorder.decoration,
              child: WidgetTesterSizeControls(sizeProvider: WidgetTesterProviders.sizeProvider),
            ),
            Expanded(
              child: (children.length == 1
                  ? WidgetTesterViewPane(
                      child: children[0],
                    )
                  : GridView.count(
                      crossAxisCount: options.columns,
                      children: children
                          .map(
                            (child) => WidgetTesterViewPane(
                              child: child,
                            ),
                          )
                          .toList())),
            ),
          ],
        ),
      ),
    );
  }
}

class ConstraintsNotifier extends StateNotifier<BoxConstraints> {
  ConstraintsNotifier(BoxConstraints state) : super(state);
  void setConstraints(BoxConstraints constraints) {
    if (state.maxWidth != constraints.maxWidth || state.maxHeight != constraints.maxHeight) {
      if (constraints.maxWidth > 50 && constraints.maxHeight > 50) {
        state = constraints;
      }
    }
  }
}
