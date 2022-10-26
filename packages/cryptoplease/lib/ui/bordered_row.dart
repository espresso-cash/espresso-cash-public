import 'package:cryptoplease/ui/colors.dart';
import 'package:flutter/material.dart';

class CpBorderedRow extends StatelessWidget {
  const CpBorderedRow({
    super.key,
    required this.title,
    required this.content,
  });

  final Widget title;
  final Widget content;

  @override
  Widget build(BuildContext context) => Container(
        height: 74,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: CpColors.accentDisabledColor,
              width: 1,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            children: [
              DefaultTextStyle(
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
                child: title,
              ),
              const SizedBox(width: 22),
              content,
            ],
          ),
        ),
      );
}
