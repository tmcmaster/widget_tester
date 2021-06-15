import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widget_tester/widget_tester_providers.dart';

class ViewPane extends ConsumerWidget {
  static const Color OUTER_BORDER_COLOR = Colors.blueGrey;
  static const EdgeInsets OUTER_BORDER_MARGIN = EdgeInsets.all(15.0);
  static const EdgeInsets OUTER_BORDER_PADDING = EdgeInsets.all(3.0);
  static const Color INNER_BORDER_COLOR = Colors.green;
  static const EdgeInsets INNER_BORDER_MARGIN = EdgeInsets.all(0.0);
  static const EdgeInsets INNER_BORDER_PADDING = EdgeInsets.all(0.0);
  static const Color CHILD_BORDER_COLOR = Colors.transparent;
  static const EdgeInsets CHILD_BORDER_MARGIN = EdgeInsets.all(0.0);
  static const EdgeInsets CHILD_BORDER_PADDING = EdgeInsets.all(0.0);

  final Widget child;

  const ViewPane({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final constraintsNotifier = watch(WidgetTesterProviders.constraintsProvider.notifier);
        setConstraints(constraints, constraintsNotifier);

        final maxWidth = constraints.maxWidth - _whitespaceOuterWidth();
        final maxHeight = constraints.maxHeight - _whitespaceOuterHeight();

        final sizePercentage = watch(WidgetTesterProviders.sizeProvider).state;
        final width = maxWidth * (sizePercentage.width / 100);
        final height = maxHeight * (sizePercentage.height / 100);

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
                    border: Border.all(color: INNER_BORDER_COLOR),
                  ), //ViewPane.INNER_BORDER)),
                  child: Container(
                    margin: CHILD_BORDER_MARGIN,
                    padding: CHILD_BORDER_PADDING,
                    decoration: BoxDecoration(
                      border: Border.all(color: CHILD_BORDER_COLOR),
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

  static void setConstraints(
    BoxConstraints newConstraints,
    ConstraintsNotifier notifier,
  ) async {
    Future.delayed(Duration(milliseconds: 1), () {
      final minWidth = _whitespaceInnerWidth();
      final maxWidth = newConstraints.maxWidth - _whitespaceOuterWidth();
      final minHeight = _whitespaceInnerHeight();
      final maxHeight = newConstraints.maxHeight - _whitespaceOuterHeight();

      if (minWidth < maxWidth && minHeight < maxHeight) {
        final requiredConstraints = BoxConstraints(
          minWidth: minWidth,
          maxWidth: maxWidth,
          minHeight: minHeight,
          maxHeight: maxHeight,
        );
        notifier.setConstraints(requiredConstraints);
      } else {
        print('ERROR: Changing Slider constraints: Width($minWidth to $maxWidth) Height($minHeight to $maxHeight)');
      }
    });
  }

  static double _whitespaceInnerWidth() {
    return INNER_BORDER_PADDING.left + INNER_BORDER_PADDING.right;
  }

  static double _whitespaceInnerHeight() {
    return INNER_BORDER_PADDING.top + INNER_BORDER_PADDING.right;
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

  static Size _calculateRation(BoxConstraints oldConstraints, BoxConstraints newConstraints) {
    if (oldConstraints.maxHeight == 0 || oldConstraints.maxWidth == 0) {
      return Size(1, 1);
    }
    return Size(1,
        1); //Size(newConstraints.maxWidth / oldConstraints.maxWidth, newConstraints.maxHeight / oldConstraints.maxHeight);
  }
}
