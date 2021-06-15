import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SizeControls extends ConsumerWidget {
  final StateProvider<Size> sizeProvider;
  const SizeControls({
    Key? key,
    required this.sizeProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final size = watch(sizeProvider).state;

    return Row(
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
    );
  }
}
