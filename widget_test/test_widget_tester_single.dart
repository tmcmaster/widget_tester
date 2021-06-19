import 'package:faker/faker.dart';
import 'package:flutter_workbench/flutter_workbench.dart';
import 'package:widget_tester/widget_tester_options.dart';

import 'widgets/my_style.dart';
import 'widgets/my_widgets.dart';

void main() {
  final singleWidget = MyText('${faker.lorem.sentences(4)}');

  FlutterWorkbench.runWidgetTesterApp(
    title: 'WidgetTest',
    styles: MyStyle.themes,
    options: WidgetTesterOptions(),
    children: [singleWidget],
  );
}
