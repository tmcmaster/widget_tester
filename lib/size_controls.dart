import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widget_tester/widget_tester.dart';

class SizeControls extends ConsumerWidget {
  final StateProvider<Size> sizeProvider;
  const SizeControls({
    Key? key,
    required this.sizeProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final constraints = watch(WidgetTester.constraintsProvider);
    final divisions = watch(WidgetTester.sliderDivisionsProvider).state;
    final size = watch(WidgetTester.sizeProvider).state;
    return Row(
      children: [
        Text('Width: '),
        Slider(
          value: size.width,
          min: constraints.minWidth,
          max: constraints.maxWidth,
          divisions: divisions,
          onChanged: (double value) {
            watch(WidgetTester.sizeProvider).state = Size(value, size.height);
          },
        ),
        Text('Height: '),
        Slider(
          value: size.height,
          min: constraints.minHeight,
          max: constraints.maxHeight,
          divisions: divisions,
          onChanged: (double value) {
            watch(WidgetTester.sizeProvider).state = Size(size.width, value);
          },
        ),
      ],
    );
  }
}
