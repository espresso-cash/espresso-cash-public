import 'package:flutter/material.dart';

import '../../../ui/colors.dart';
import '../../tokens/token.dart';
import '../../tokens/widgets/token_icon.dart';
import '../screens/token_picker_screen.dart';

class TokenPicker extends StatelessWidget {
  const TokenPicker({
    super.key,
    required this.token,
    required this.title,
    required this.onSubmitted,
    this.isExpanded = false,
  });

  final Token token;
  final String title;
  final ValueSetter<Token> onSubmitted;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: const ShapeDecoration(
          color: CpColors.blackGreyColor,
          shape: StadiumBorder(),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
          onTap: () async {
            final Token? updated = await TokenPickerScreen.push(
              context,
              initial: token,
              title: title,
            );

            if (context.mounted && updated != null) {
              onSubmitted(updated);
            }
          },
          leading: TokenIcon(token: token, size: 42),
          title: SizedBox(
            height: 28,
            child: Text(
              isExpanded ? (token.symbol) : '',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.white,
                height: 1.5,
                overflow: TextOverflow.fade,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          titleAlignment: ListTileTitleAlignment.threeLine,
          trailing: const Icon(
            Icons.keyboard_arrow_down_outlined,
            color: Colors.white,
            size: 30,
          ),
        ),
      );
}
