import 'package:flutter/material.dart';

import '../rounded_rectangle.dart';

class ShareMessageBubble extends StatefulWidget {
  const ShareMessageBubble({
    super.key,
    required this.textSpan,
  });

  final TextSpan textSpan;

  @override
  State<ShareMessageBubble> createState() => _ShareMessageBubbleState();
}

class _ShareMessageBubbleState extends State<ShareMessageBubble> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        child: CpRoundedRectangle(
          scrollable: true,
          margin: const EdgeInsets.symmetric(vertical: 24),
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 48,
          ),
          child: Text.rich(widget.textSpan),
        ),
      );
}
