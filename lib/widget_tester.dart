import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widget_tester/size_controls.dart';
import 'package:widget_tester/view_pane.dart';
import 'package:widget_tester/widget_tester_providers.dart';

class WidgetTester extends StatelessWidget {
  final List<Widget> children;
  final Widget? child;
  final int columns;

  const WidgetTester({
    Key? key,
    this.child,
    this.children = const [],
    this.columns = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Building the WidgetTester');
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(border: Border.all(color: Colors.red)),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey),
              ),
              child: SizeControls(sizeProvider: WidgetTesterProviders.sizeProvider),
            ),
            Expanded(
              child: (child != null
                  ? ViewPane(
                      child: child ?? Text('No components to test'),
                    )
                  : GridView.count(
                      crossAxisCount: columns,
                      children: children
                          .map(
                            (child) => ViewPane(
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
        print('New Constraints: $constraints');
        state = constraints;
      }
    }
  }
}
