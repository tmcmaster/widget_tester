import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WidgetTesterProviders {
  static final sizeProvider = StateProvider<Size>((ref) => Size(80, 80));

  static final constraintsProvider = StateNotifierProvider<ConstraintsNotifier, BoxConstraints>(
    (ref) {
      return ConstraintsNotifier(
        BoxConstraints(
          minWidth: 10,
          maxWidth: 10,
          minHeight: 10,
          maxHeight: 10,
        ),
      );
    },
  );
}

class ConstraintsNotifier extends StateNotifier<BoxConstraints> {
  ConstraintsNotifier(BoxConstraints state) : super(state);
  void setConstraints(BoxConstraints constraints) {
    if (state.maxWidth != constraints.maxWidth || state.maxHeight != constraints.maxHeight) {
      if (constraints.maxWidth > 50 && constraints.maxHeight > 50) {
        print('New Constraints: $constraints');
        state = constraints;
      }
    }
  }
}
