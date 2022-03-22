import 'dart:math';

import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class PickRecipientTypeButton extends StatelessWidget {
  const PickRecipientTypeButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.helpString,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String text;
  final String? helpString;

  @override
  Widget build(BuildContext context) {
    final helpString = this.helpString;

    return Opacity(
      opacity: onPressed == null ? 0.25 : 1,
      child: Column(
        children: [
          Material(
            clipBehavior: Clip.antiAlias,
            color: CpColors.lightGreyBackground,
            shape: const StadiumBorder(),
            child: InkWell(
              onTap: onPressed,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 18,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      text,
                      style: Theme.of(context).textTheme.button!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          ),
                    ),
                    IgnorePointer(
                      child: Transform.rotate(
                        angle: pi,
                        child: Assets.icons.back.svg(
                          color: CpColors.primaryTextColor,
                          height: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          if (helpString != null)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                helpString,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headline2?.copyWith(
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                      fontSize: 15,
                    ),
              ),
            ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
