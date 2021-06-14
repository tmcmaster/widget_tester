import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widget_tester/widget_tester.dart';

class ViewPane extends ConsumerWidget {
  static const Color OUTER_BORDER_COLOR = Colors.blueGrey;
  static const EdgeInsets OUTER_BORDER_MARGIN = EdgeInsets.all(15.0);
  static const EdgeInsets OUTER_BORDER_PADDING = EdgeInsets.all(3.0);
  static const Color INNER_BORDER_COLOR = Colors.blueAccent;
  static const EdgeInsets INNER_BORDER_MARGIN = EdgeInsets.all(15.0);
  static const EdgeInsets INNER_BORDER_PADDING = EdgeInsets.all(20.0);

  final Widget child;

  const ViewPane({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final size = watch(WidgetTester.sizeProvider).state;
    final width = size.width;
    final height = size.height;
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth - _whitespaceOuterWidth();
        final maxHeight = constraints.maxHeight - _whitespaceOuterHeight();
        setConstraints(watch(WidgetTester.constraintsProvider.notifier), constraints);
        return Container(
          margin: OUTER_BORDER_MARGIN,
          padding: OUTER_BORDER_PADDING,
          decoration: BoxDecoration(border: Border.all(color: OUTER_BORDER_COLOR)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: (width < maxWidth ? width : maxWidth),
                  height: (height < maxHeight ? height : maxHeight),
                  margin: INNER_BORDER_MARGIN,
                  padding: INNER_BORDER_PADDING,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                  ), //ViewPane.INNER_BORDER)),
                  child: Container(
                    margin: const EdgeInsets.all(0),
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange),
                    ),
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void setConstraints(ConstraintsNotifier notifier, BoxConstraints c) async {
    Future.delayed(Duration(milliseconds: 1), () {
      notifier.setConstraints(
        BoxConstraints(
          minWidth: c.minWidth + INNER_BORDER_PADDING.left + INNER_BORDER_PADDING.right,
          maxWidth: c.maxWidth - _whitespaceOuterWidth(),
          minHeight: c.minWidth + INNER_BORDER_PADDING.top + INNER_BORDER_PADDING.right,
          maxHeight: c.maxHeight - _whitespaceOuterHeight(),
        ),
      );
    });
  }

  /// TODO: need to investigate the extra required 50 constant
  static double _whitespaceOuterWidth() {
    return OUTER_BORDER_MARGIN.left +
        OUTER_BORDER_MARGIN.right +
        OUTER_BORDER_PADDING.left +
        OUTER_BORDER_PADDING.right +
        50;
  }

  /// TODO: need to investigate the extra required 50 constant
  static double _whitespaceOuterHeight() {
    return OUTER_BORDER_MARGIN.top +
        OUTER_BORDER_MARGIN.bottom +
        OUTER_BORDER_PADDING.top +
        OUTER_BORDER_PADDING.bottom +
        50;
  }
}
