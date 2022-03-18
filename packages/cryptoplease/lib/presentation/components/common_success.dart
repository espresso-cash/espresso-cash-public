import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class CommonSuccess extends StatelessWidget {
  const CommonSuccess({
    Key? key,
    required this.text,
    required this.onClosePressed,
  }) : super(key: key);

  final String text;
  final VoidCallback onClosePressed;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CpContentPadding(
          child: Container(
            width: double.infinity,
            // This compensates for the app bar by shifting the content
            // a little up
            padding: const EdgeInsets.only(bottom: kToolbarHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.icons.successIcon.svg(width: 72, height: 72),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: CpColors.primaryTextColor,
                      fontSize: 21,
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 250,
                  ),
                  child: CpButton(
                    text: context.l10n.ok,
                    onPressed: onClosePressed,
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
