import 'package:flutter/material.dart';

class WidgetTesterOptions {
  final int columns;
  late final BorderOptions? _border;
  late final BorderOptions? _controlsBorder;
  late final BorderOptions? _viewPaneBorder;
  late final BorderOptions? _resizePaneBorder;
  late final BorderOptions? _widgetPaneBorder;
  WidgetTesterOptions({
    this.columns = 1,
    BorderOptions? border,
    BorderOptions? controlsBorder,
    BorderOptions? viewPaneBorder,
    BorderOptions? resizePaneBorder,
    BorderOptions? widgetPaneBorder,
  }) {
    _border = border;
    _controlsBorder = controlsBorder;
    _viewPaneBorder = viewPaneBorder;
    _resizePaneBorder = resizePaneBorder;
    _widgetPaneBorder = widgetPaneBorder;
  }

  /// WidgetTester Border
  BorderOptions get border =>
      _border ??
      BorderOptions(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),
        color: Colors.purple,
      );

  /// Slide Controls Border
  BorderOptions get controlsBorder =>
      _controlsBorder ??
      BorderOptions(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(10.0),
        color: Colors.blueGrey,
      );

  /// View Pane Border
  BorderOptions get viewPaneBorder =>
      _viewPaneBorder ??
      BorderOptions(
        margin: EdgeInsets.all(15.0),
        padding: EdgeInsets.all(3.0),
        color: Colors.blue,
      );

  /// Resize Pane Border
  BorderOptions get resizePaneBorder =>
      _resizePaneBorder ??
      BorderOptions(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),
        color: Colors.green,
      );

  /// Widget Pane Border
  BorderOptions get widgetPaneBorder =>
      _widgetPaneBorder ??
      BorderOptions(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),
        color: Colors.yellow,
      );
}

class BorderOptions {
  final EdgeInsets margin;
  final EdgeInsets padding;
  late final BoxDecoration decoration;

  BorderOptions({
    this.margin = const EdgeInsets.all(0.0),
    this.padding = const EdgeInsets.all(0.0),
    Color? color,
  }) {
    decoration = BoxDecoration(
      border: Border.all(color: color ?? Colors.transparent),
    );
  }
}
