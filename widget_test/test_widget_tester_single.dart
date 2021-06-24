import 'package:faker/faker.dart';
import 'package:flutter_workbench/flutter_workbench.dart';
import 'package:widget_tester/widget_tester.dart';

import 'widgets/my_style.dart';
import 'widgets/my_widgets.dart';

void main() {
  final singleWidget = MyText('${faker.lorem.sentences(4)}');

  FlutterWorkbench.runAppWidgetTester(
    title: 'WidgetTest',
    styles: MyStyle.themes,
    options: WidgetTesterOptions(),
    children: [singleWidget],
  );
}
