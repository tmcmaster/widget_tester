import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WidgetTesterSizeControls extends ConsumerWidget {
  final StateProvider<Size> sizeProvider;
  const WidgetTesterSizeControls({
    Key? key,
    required this.sizeProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = ref.watch(sizeProvider);

    return Card(
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
        child: Wrap(
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
                      ref.read(sizeProvider.notifier).state = Size(value, size.height);
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
                      ref.read(sizeProvider.notifier).state = Size(size.width, value);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
