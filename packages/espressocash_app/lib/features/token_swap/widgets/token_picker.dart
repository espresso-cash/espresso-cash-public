import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../ui/colors.dart';
import '../../tokens/token.dart';
import '../screens/token_picker_screen.dart';

class TokenPicker extends StatelessWidget {
  const TokenPicker({
    super.key,
    this.token,
    required this.title,
    required this.onSubmitted,
    this.isExpanded = false,
  });

  final Token? token;
  final String title;
  final ValueSetter<Token> onSubmitted;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final tokenLogo = token?.logoURI;

    return DecoratedBox(
      decoration: const ShapeDecoration(
        color: CpColors.blackGreyColor,
        shape: StadiumBorder(),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
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
        leading: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          child: tokenLogo != null
              ? CachedNetworkImage(
                  imageUrl: tokenLogo,
                  width: 42,
                  height: 42,
                  errorListener: (_) {},
                )
              : const _DefaultIcon(
                  size: 42,
                ),
        ),
        title: SizedBox(
          height: 28,
          child: Text(
            isExpanded ? (token?.symbol ?? Token.usdc.symbol) : '',
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
}

class _DefaultIcon extends StatelessWidget {
  const _DefaultIcon({this.size});

  @override
  Widget build(BuildContext context) => Image.asset(
        Assets.images.tokenLogo.path,
        width: size,
        height: size,
      );

  final double? size;
}
