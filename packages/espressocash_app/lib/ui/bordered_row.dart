import 'package:flutter/material.dart';

import 'chip.dart';
import 'colors.dart';

class CpBorderedRow extends StatelessWidget {
  const CpBorderedRow({
    super.key,
    required this.title,
    required this.content,
    this.dividerColor,
  });

  final Widget title;
  final Widget content;
  final Color? dividerColor;

  @override
  Widget build(BuildContext context) => Container(
        height: MediaQuery.sizeOf(context).height < 700 ? 56 : 74,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: dividerColor ?? CpColors.accentDisabledColor,
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

class BorderedRowChip extends StatelessWidget {
  const BorderedRowChip({super.key, required this.child, this.backgroundColor});

  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) => Expanded(
        // ignore: avoid-single-child-column-or-row, check if needed
        child: Wrap(
          children: [
            CpChip(
              padding: CpChipPadding.small,
              backgroundColor: backgroundColor,
              child: child,
            ),
          ],
        ),
      );
}
