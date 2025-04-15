import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class EcMarkdownText extends StatelessWidget {
  const EcMarkdownText({super.key, required this.text, this.textAlign = WrapAlignment.start});

  final String text;
  final WrapAlignment textAlign;

  @override
  Widget build(BuildContext context) => MarkdownBody(
    data: text,
    styleSheet: MarkdownStyleSheet(
      em: _markdownStyle.copyWith(color: CpColors.yellowColor),
      p: _markdownStyle,
      textAlign: textAlign,
    ),
  );
}

final _markdownStyle = TextStyle(
  fontStyle: FontStyle.normal,
  fontSize: 32.sp,
  fontWeight: FontWeight.w900,
  letterSpacing: 0.25,
  height: 1,
);
