import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomColorSelectionHandle extends TextSelectionControls {
  CustomColorSelectionHandle(this.handleColor)
      : _controls = Platform.isIOS
            ? cupertinoTextSelectionControls
            : materialTextSelectionControls;

  final Color handleColor;
  final TextSelectionControls _controls;

  /// Wrap the given handle builder with the needed theme data for
  /// each platform to modify the color.
  Widget _wrapWithThemeData(Widget Function(BuildContext) builder) =>
      Platform.isIOS
          // ios handle uses the CupertinoTheme primary color, so override that.
          ? CupertinoTheme(
              data: CupertinoThemeData(primaryColor: handleColor),
              child: Builder(builder: builder),
            )
          // material handle uses the selection handle color, so override that.
          : TextSelectionTheme(
              data: TextSelectionThemeData(selectionHandleColor: handleColor),
              child: Builder(builder: builder),
            );

  @override
  Widget buildHandle(
    BuildContext context,
    TextSelectionHandleType type,
    double textLineHeight, [
    VoidCallback? onTap,
    double? startGlyphHeight,
    double? endGlyphHeight,
  ]) =>
      _wrapWithThemeData(
        (BuildContext context) =>
            _controls.buildHandle(context, type, textLineHeight),
      );

  @override
  Widget buildToolbar(
    BuildContext context,
    Rect globalEditableRegion,
    double textLineHeight,
    Offset position,
    List<TextSelectionPoint> endpoints,
    TextSelectionDelegate delegate,
    ClipboardStatusNotifier clipboardStatus,
    Offset? lastSecondaryTapDownPosition,
  ) =>
      _controls.buildToolbar(
        context,
        globalEditableRegion,
        textLineHeight,
        position,
        endpoints,
        delegate,
        clipboardStatus,
        lastSecondaryTapDownPosition,
      );

  @override
  Offset getHandleAnchor(
    TextSelectionHandleType type,
    double textLineHeight, [
    double? startGlyphHeight,
    double? endGlyphHeight,
  ]) =>
      _controls.getHandleAnchor(type, textLineHeight);

  @override
  Size getHandleSize(double textLineHeight) =>
      _controls.getHandleSize(textLineHeight);
}
