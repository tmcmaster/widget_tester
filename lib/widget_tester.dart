import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widget_tester/size_controls.dart';
import 'package:widget_tester/view_pane.dart';

class WidgetTester extends StatelessWidget {
  static final sliderDivisionsProvider = StateProvider((ref) => 100);

  static final sizeProvider = StateProvider<Size>((ref) => Size(300, 200));

  static final constraintsProvider = StateNotifierProvider<ConstraintsNotifier, BoxConstraints>(
    (ref) {
      final size = ref.read(sizeProvider).state;
      return ConstraintsNotifier(
        BoxConstraints(
          minWidth: 10,
          maxWidth: size.width,
          minHeight: 10,
          maxHeight: size.height,
        ),
      );
    },
  );

  final child;

  const WidgetTester({
    Key? key,
    required this.child,
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
              child: SizeControls(sizeProvider: sizeProvider),
            ),
            Expanded(
              child: ViewPane(
                child: child,
              ),
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
