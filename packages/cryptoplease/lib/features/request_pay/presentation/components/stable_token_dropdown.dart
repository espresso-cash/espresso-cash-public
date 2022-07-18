import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class StableTokenDropdown extends StatelessWidget {
  const StableTokenDropdown({
    Key? key,
    required this.selectedToken,
    required this.onTap,
    required this.suffixWidget,
  }) : super(key: key);

  final Token selectedToken;
  final VoidCallback onTap;
  final Widget suffixWidget;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(left: 4),
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          height: kToolbarHeight + 8,
          decoration: const ShapeDecoration(
            color: CpColors.darkBackground,
            shape: StadiumBorder(),
          ),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  selectedToken.symbol,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Icon(Icons.expand_more, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
