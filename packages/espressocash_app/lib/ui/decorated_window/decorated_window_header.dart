import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../gen/assets.gen.dart';

class DecoratedWindowHeader extends StatelessWidget {
  const DecoratedWindowHeader({
    super.key,
    this.title,
    this.message,
    this.hasLogo = true,
    this.markdownMessage = false,
  });

  final String? title;
  final String? message;
  final bool hasLogo;
  final bool markdownMessage;

  @override
  Widget build(BuildContext context) {
    final messageStyle =
        Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 18);
    final title = this.title;
    final message = this.message;

    return Column(
      children: <Widget>[
        if (hasLogo)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Assets.images.logoIcon.image(height: 96),
          ),
        if (title != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(fontSize: 30),
            ),
          ),
        if (message != null)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: markdownMessage
                ? Markdown(
                    data: message,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    styleSheet: MarkdownStyleSheet(p: messageStyle),
                  )
                : Text(
                    message,
                    textAlign: TextAlign.center,
                    style: messageStyle,
                  ),
          ),
      ],
    );
  }
}
