import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WidgetTesterSizeControls extends ConsumerWidget {
  final StateProvider<Size> sizeProvider;
  const WidgetTesterSizeControls({
    Key? key,
    required this.sizeProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final size = watch(sizeProvider).state;

    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        SizedBox(
          width: 250,
          child: Row(
            children: [
              Text('Width: '),
              Slider(
                value: size.width,
                min: 1,
                max: 100,
                divisions: 100,
                onChanged: (double value) {
                  watch(sizeProvider).state = Size(value, size.height);
                },
              ),
            ],
          ),
        ),
        SizedBox(
          width: 250,
          child: Row(
            children: [
              Text('Height: '),
              Slider(
                value: size.height,
                min: 1,
                max: 100,
                divisions: 100,
                onChanged: (double value) {
                  watch(sizeProvider).state = Size(size.width, value);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
