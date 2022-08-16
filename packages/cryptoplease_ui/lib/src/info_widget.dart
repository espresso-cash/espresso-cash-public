import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class CpInfoWidget extends StatelessWidget {
  const CpInfoWidget({
    Key? key,
    required this.icon,
    required this.message,
  }) : super(key: key);

  final Widget icon;
  final String message;

  static const _radius = Radius.circular(32);

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        decoration: const BoxDecoration(
          color: CpColors.backgroundAccentColor,
          borderRadius: BorderRadius.only(
            bottomLeft: _radius,
            bottomRight: _radius,
            topLeft: _radius,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
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
                child: Text(
                  message,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
