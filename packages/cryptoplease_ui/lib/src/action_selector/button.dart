import 'package:cryptoplease_ui/src/colors.dart';
import 'package:flutter/material.dart';

class CpActionSelectorButton extends StatelessWidget {
  const CpActionSelectorButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.help,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String text;
  final String? help;

  @override
  Widget build(BuildContext context) {
    final help = this.help;

    return Opacity(
      opacity: onPressed == null ? 0.25 : 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      size: 20,
                      color: CpColors.primaryTextColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (help != null)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                help,
                textAlign: TextAlign.left,
                style: const TextStyle(
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
