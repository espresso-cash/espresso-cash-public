import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../ui/colors.dart';

final kycMarkdownStyleSheet = MarkdownStyleSheet(
  em: _markdownStyle.copyWith(color: CpColors.yellowColor),
  p: _markdownStyle,
);

const _markdownStyle = TextStyle(
  fontStyle: FontStyle.normal,
  fontSize: 32,
  fontWeight: FontWeight.w900,
  letterSpacing: 0.25,
  height: 1,
);
