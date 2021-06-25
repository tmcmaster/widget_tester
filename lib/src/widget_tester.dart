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
      decoration: BoxDecoration(color: Colors.grey.shade200),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: WidgetTesterSizeControls(sizeProvider: WidgetTesterProviders.sizeProvider),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
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
                        return Container(
                          margin: EdgeInsets.all(10),
                          child: WidgetTesterViewPane(child: children[index]),
                        );
                      })),
            ),
          ),
        ],
      ),
    );
  }
}
