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

        final minWidth = 0.0;
        final maxWidth = constraints.maxWidth;

        final minHeight = 0.0;
        final maxHeight = constraints.maxHeight;

        final sizePercentage = watch(WidgetTesterProviders.sizeProvider).state;
        final width = maxWidth * (sizePercentage.width / 100);
        final height = maxHeight * (sizePercentage.height / 100);

        return Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: (width < maxWidth ? (width > minWidth ? width : minWidth) : maxWidth),
                  height: (height < maxHeight ? (height > minHeight ? height : minHeight) : maxHeight),
                  child: Container(
                    child: Card(child: child),
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
      final minWidth = 0.0;
      final maxWidth = newConstraints.maxWidth;
      final minHeight = 0.0;
      final maxHeight = newConstraints.maxHeight;

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
}
