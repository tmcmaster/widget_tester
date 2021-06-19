import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widget_tester_options.dart';
import 'widget_tester_providers.dart';

class WidgetTesterViewPane extends ConsumerWidget {
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

        final minWidth = _whitespaceInnerWidth(options);
        final maxWidth = constraints.maxWidth - _whitespaceOuterWidth(options);

        final minHeight = _whitespaceInnerHeight(options);
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
                  width: (width < maxWidth ? (width > minWidth ? width : minWidth) : maxWidth),
                  height: (height < maxHeight ? (height > minHeight ? height : minHeight) : maxHeight),
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
    return options.widgetPaneBorder.padding.left +
        options.widgetPaneBorder.padding.right +
        options.widgetPaneBorder.margin.left +
        options.widgetPaneBorder.margin.right +
        options.resizePaneBorder.padding.left +
        options.resizePaneBorder.padding.right;
  }

  static double _whitespaceInnerHeight(WidgetTesterOptions options) {
    return options.widgetPaneBorder.padding.top +
        options.widgetPaneBorder.padding.bottom +
        options.widgetPaneBorder.margin.top +
        options.widgetPaneBorder.margin.bottom +
        options.resizePaneBorder.padding.top +
        options.resizePaneBorder.padding.bottom;
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
}
