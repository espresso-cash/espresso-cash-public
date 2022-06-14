import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class AmountInputWidget extends StatelessWidget {
  const AmountInputWidget({
    Key? key,
    required this.text,
    required this.onMaxRequested,
    required this.suffixWidget,
  }) : super(key: key);

  final String text;
  final VoidCallback? onMaxRequested;
  final Widget? suffixWidget;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, ctrs) {
          final suffix = suffixWidget;

          return Container(
            height: ctrs.maxHeight,
            width: ctrs.maxWidth,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: const BoxDecoration(
              color: CpColors.darkPrimaryColor,
              borderRadius: BorderRadius.all(Radius.circular(7)),
            ),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          text.isEmpty ? '0' : text,
                          style: const TextStyle(fontSize: 24),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ),
                  if (suffix != null) suffix,
                ],
              ),
            ),
          );
        },
      );
}
