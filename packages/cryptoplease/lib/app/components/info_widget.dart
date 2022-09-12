import 'package:cryptoplease_ui/cryptoplease_ui.dart';
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

  static const _radius = Radius.circular(32);

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor ?? CpColors.darkBackground,
          borderRadius: const BorderRadius.only(
            bottomLeft: _radius,
            bottomRight: _radius,
            topLeft: _radius,
          ),
        ),
        child: Padding(
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
        ),
      );
}
