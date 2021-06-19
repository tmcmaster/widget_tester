import 'package:faker/faker.dart';
import 'package:flutter_workbench/flutter_workbench.dart';
import 'package:widget_tester/widget_tester.dart';

import 'widgets/my_style.dart';
import 'widgets/my_widgets.dart';

void main() {
  final widgetBuilder = (i) => MyText('${faker.lorem.words(i * 4)}');
  final generatedTextWidgets = Iterable.generate(10).map(widgetBuilder).toList();

  FlutterWorkbench.runWidgetTesterApp(
    title: 'WidgetTester',
    styles: MyStyle.themes,
    options: WidgetTesterOptions(
      columns: 4,
      aspectRatio: 2,
    ),
    children: generatedTextWidgets,
  );
}
