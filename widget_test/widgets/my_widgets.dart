import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  const MyText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(text,
        textAlign: TextAlign.center,
        style: theme.textTheme.headline4!.copyWith(
          color: theme.primaryColor,
        ));
  }
}
