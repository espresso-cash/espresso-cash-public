import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class EcMarkdownText extends StatelessWidget {
  const EcMarkdownText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) =>
      MarkdownBody(data: text, styleSheet: kycMarkdownStyleSheet);
}

final kycMarkdownStyleSheet = MarkdownStyleSheet(
  em: _markdownStyle.copyWith(color: CpColors.yellowColor),
  p: _markdownStyle,
);

final _markdownStyle = TextStyle(
  fontStyle: FontStyle.normal,
  fontSize: 32.sp,
  fontWeight: FontWeight.w900,
  letterSpacing: 0.25,
  height: 1,
);
