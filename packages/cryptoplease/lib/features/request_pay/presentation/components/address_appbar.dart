import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

class AddressAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AddressAppBar({
    Key? key,
    required this.onClose,
    required this.label,
    required this.address,
    required this.token,
  }) : super(key: key);

  final VoidCallback onClose;
  final String? label;
  final String address;
  final Token token;

  @override
  Size get preferredSize => const Size.fromHeight(3 * kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final formattedAddress = '${substring(address, 0, 4)}'
        '\u2026'
        '${substring(address, address.length - 4)}';

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: IconButton(
              onPressed: onClose,
              icon: const Icon(Icons.close),
            ),
          ),
          _AppBarRow(
            text: context.l10n.to,
            chipContent: Text.rich(
              TextSpan(
                text: label ?? '',
                children: [
                  if (label != null)
                    const WidgetSpan(child: SizedBox(width: 24)),
                  TextSpan(
                    text: formattedAddress,
                    style: _textStyle.copyWith(
                      color: CpColors.disabledColor,
                    ),
                  ),
                ],
              ),
              maxLines: 1,
              style: _textStyle,
            ),
          ),
          const Divider(color: CpColors.accentDisabledColor, height: 1),
          _AppBarRow(
            text: context.l10n.sendAs,
            chipContent: Text(token.symbol, style: _textStyle),
          ),
          const Divider(color: CpColors.accentDisabledColor, height: 1),
        ],
      ),
    );
  }
}

class _AppBarRow extends StatelessWidget {
  const _AppBarRow({
    Key? key,
    required this.text,
    required this.chipContent,
  }) : super(key: key);

  final String text;
  final Widget chipContent;

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(horizontal: 16, vertical: 8);

    return Container(
      height: kToolbarHeight,
      padding: padding,
      child: Row(
        children: [
          Text(text, style: _textStyle),
          const SizedBox(width: 12),
          Flexible(
            child: FittedBox(
              child: CpChip(
                padding: CpChipPadding.small,
                child: chipContent,
              ),
            ),
          )
        ],
      ),
    );
  }
}

const _textStyle = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w500,
);
