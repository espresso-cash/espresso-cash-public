import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../../l10n/l10n.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText({
    super.key,
    required this.text,
    required this.maxLines,
  });

  final TextSpan text;
  final int maxLines;

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  static const String _ellipsis = '\u2026\u0020';

  GestureRecognizer get _tapRecognizer => TapGestureRecognizer()
    ..onTap = () {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    };

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final maxLines = widget.maxLines;

          final String lineEnding = '$_ellipsis${context.l10n.more}';

          final richText = Text.rich(widget.text).build(context) as RichText;

          final boxes = richText.measure(context, constraints);
          final overflowed = boxes.length <= maxLines;

          if (overflowed || _isExpanded) {
            return _buildAllText(
              widget.text.text,
              tapRecognizer: _tapRecognizer,
              showLessButton: !overflowed,
            );
          }
          final croppedText = _ellipsizeText(boxes);
          final ellipsizedText =
              _buildEllipsizedText(croppedText, _tapRecognizer);

          if (ellipsizedText.measure(context, constraints).length <= maxLines) {
            return ellipsizedText;
          }

          final fixedEllipsizedText = croppedText.substring(
            0,
            croppedText.length - lineEnding.length,
          );

          return _buildEllipsizedText(fixedEllipsizedText, _tapRecognizer);
        },
      );

  String _ellipsizeText(List<TextBox> boxes) {
    final text = widget.text.text ?? '';
    final maxLines = widget.maxLines;

    double calculateLinesLength(List<TextBox> boxes) => boxes
        .map((box) => box.right - box.left)
        .reduce((acc, value) => acc += value);

    final requiredLength = calculateLinesLength(boxes.sublist(0, maxLines));
    final totalLength = calculateLinesLength(boxes);

    final requiredTextFraction = requiredLength / totalLength;

    return text.substring(0, (text.length * requiredTextFraction).floor());
  }

  RichText _buildAllText(
    String? text, {
    required GestureRecognizer tapRecognizer,
    required bool showLessButton,
  }) =>
      RichText(
        text: TextSpan(
          text: text,
          style: widget.text.style,
          children: [
            if (showLessButton)
              TextSpan(
                text: '$_ellipsis${context.l10n.less}',
                style: const TextStyle(fontWeight: FontWeight.bold),
                recognizer: tapRecognizer,
              ),
          ],
        ),
      );

  RichText _buildEllipsizedText(String text, GestureRecognizer tapRecognizer) =>
      RichText(
        text: TextSpan(
          text: text,
          style: widget.text.style,
          children: [
            TextSpan(
              text: '$_ellipsis${context.l10n.more}',
              style: const TextStyle(fontWeight: FontWeight.bold),
              recognizer: tapRecognizer,
            ),
          ],
        ),
      );
}

extension _TextMeasurer on RichText {
  List<TextBox> measure(BuildContext context, Constraints constraints) {
    final renderObject = createRenderObject(context)..layout(constraints);

    return renderObject.getBoxesForSelection(
      TextSelection(
        baseOffset: 0,
        extentOffset: text.toPlainText().length,
      ),
    );
  }
}
