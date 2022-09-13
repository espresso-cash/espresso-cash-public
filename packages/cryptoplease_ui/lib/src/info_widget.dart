import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class CpInfoWidget extends StatelessWidget {
  const CpInfoWidget({
    Key? key,
    required this.icon,
    required this.message,
    this.padding = const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
  }) : super(key: key);

  final Widget icon;
  final Widget message;
  final EdgeInsetsGeometry padding;

  static const _radius = Radius.circular(32);

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: const BoxDecoration(
          color: CpColors.backgroundAccentColor,
          borderRadius: BorderRadius.only(
            bottomLeft: _radius,
            bottomRight: _radius,
            topLeft: _radius,
          ),
        ),
        child: Padding(
          padding: padding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  maxRadius: 14,
                  backgroundColor: CpColors.yellowColor,
                  child: icon,
                ),
              ),
              Flexible(
                child: DefaultTextStyle.merge(
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                  ),
                  child: message,
                ),
              ),
            ],
          ),
        ),
      );
}
