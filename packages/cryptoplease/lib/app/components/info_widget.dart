import 'package:cryptoplease/app/ui/rounded_rectangle.dart';
import 'package:flutter/material.dart';

class MessageInfoWidget extends StatelessWidget {
  const MessageInfoWidget({
    Key? key,
    required this.content,
    this.backgroundColor,
    this.padding = const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
  }) : super(key: key);

  final Widget content;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) => CpRoundedRectangle(
        backgroundColor: backgroundColor,
        padding: padding,
        child: Center(
          child: DefaultTextStyle(
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.left,
            child: content,
          ),
        ),
      );
}
