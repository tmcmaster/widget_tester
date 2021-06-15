import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widget_tester/widget_tester_options.dart';
import 'package:widget_tester/widget_tester_providers.dart';

class WidgetTesterViewPane extends ConsumerWidget {
  // static const Color OUTER_BORDER_COLOR = Colors.blueGrey;
  // static const EdgeInsets OUTER_BORDER_MARGIN = EdgeInsets.all(15.0);
  // static const EdgeInsets OUTER_BORDER_PADDING = EdgeInsets.all(3.0);
  // static const Color INNER_BORDER_COLOR = Colors.green;
  // static const EdgeInsets INNER_BORDER_MARGIN = EdgeInsets.all(0.0);
  // static const EdgeInsets INNER_BORDER_PADDING = EdgeInsets.all(0.0);
  // static const Color CHILD_BORDER_COLOR = Colors.transparent;
  // static const EdgeInsets CHILD_BORDER_MARGIN = EdgeInsets.all(0.0);
  // static const EdgeInsets CHILD_BORDER_PADDING = EdgeInsets.all(0.0);

  late final WidgetTesterOptions? _options;
  final Widget child;

  WidgetTesterViewPane({
    Key? key,
    options,
    required this.child,
  }) : super(key: key) {
    _options = options;
  }

  WidgetTesterOptions get options => _options ?? WidgetTesterOptions();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final constraintsNotifier = watch(WidgetTesterProviders.constraintsProvider.notifier);
        setConstraints(constraints, constraintsNotifier, options);

        final maxWidth = constraints.maxWidth - _whitespaceOuterWidth(options);
        final maxHeight = constraints.maxHeight - _whitespaceOuterHeight(options);

        final sizePercentage = watch(WidgetTesterProviders.sizeProvider).state;
        final width = maxWidth * (sizePercentage.width / 100);
        final height = maxHeight * (sizePercentage.height / 100);

        return Container(
          margin: options.viewPaneBorder.margin,
          padding: options.viewPaneBorder.padding,
          decoration: options.viewPaneBorder.decoration,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: (width < maxWidth ? width : maxWidth),
                  height: (height < maxHeight ? height : maxHeight),
                  margin: options.resizePaneBorder.margin,
                  padding: options.resizePaneBorder.padding,
                  decoration: options.resizePaneBorder.decoration, //ViewPane.INNER_BORDER)),
                  child: Container(
                    margin: options.widgetPaneBorder.margin,
                    padding: options.widgetPaneBorder.padding,
                    decoration: options.widgetPaneBorder.decoration,
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
    WidgetTesterOptions options,
  ) async {
    Future.delayed(Duration(milliseconds: 1), () {
      final minWidth = _whitespaceInnerWidth(options);
      final maxWidth = newConstraints.maxWidth - _whitespaceOuterWidth(options);
      final minHeight = _whitespaceInnerHeight(options);
      final maxHeight = newConstraints.maxHeight - _whitespaceOuterHeight(options);

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

  static double _whitespaceInnerWidth(WidgetTesterOptions options) {
    return options.widgetPaneBorder.padding.left + options.widgetPaneBorder.padding.right;
  }

  static double _whitespaceInnerHeight(WidgetTesterOptions options) {
    return options.widgetPaneBorder.padding.top + options.widgetPaneBorder.padding.right;
  }

  /// TODO: need to investigate the extra required 50 constant
  static double _whitespaceOuterWidth(WidgetTesterOptions options) {
    return options.resizePaneBorder.margin.left +
        options.resizePaneBorder.margin.right +
        options.resizePaneBorder.padding.left +
        options.resizePaneBorder.padding.right +
        50;
  }

  /// TODO: need to investigate the extra required 50 constant
  static double _whitespaceOuterHeight(WidgetTesterOptions options) {
    return options.resizePaneBorder.margin.top +
        options.resizePaneBorder.margin.bottom +
        options.resizePaneBorder.padding.top +
        options.resizePaneBorder.padding.bottom +
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
