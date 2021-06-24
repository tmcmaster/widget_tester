import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widget_tester_options.dart';
import 'widget_tester_providers.dart';
import 'widget_tester_size_controls.dart';
import 'widget_tester_view_pane.dart';

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

  /// TODO: the lsyout builder needs to be to this level.
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Container(
      margin: options.border.margin,
      padding: options.border.padding,
      decoration: options.border.decoration.copyWith(color: Colors.grey.shade200),
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
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: options.columns,
                      childAspectRatio: options.aspectRatio,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemCount: children.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return WidgetTesterViewPane(child: children[index]);
                    })),
          ),
        ],
      ),
    );
  }
}
