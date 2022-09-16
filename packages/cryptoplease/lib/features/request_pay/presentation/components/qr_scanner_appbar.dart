import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

class QrScannerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const QrScannerAppBar({
    Key? key,
    required this.onQrScanner,
  }) : super(key: key);

  final VoidCallback onQrScanner;

  @override
  Size get preferredSize => const Size.fromHeight(2 * kToolbarHeight);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            top: 8,
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: onQrScanner,
                icon: Assets.icons.qrScanner.svg(height: 24),
              ),
            ],
          ),
        ),
      );
}

class AddressAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AddressAppBar({
    Key? key,
    required this.onClose,
    required this.address,
    required this.token,
  }) : super(key: key);

  final VoidCallback onClose;
  final String address;
  final Token token;

  @override
  Size get preferredSize => const Size.fromHeight(3 * kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w500,
    );
    const padding = EdgeInsets.symmetric(horizontal: 16, vertical: 8);

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
          Container(
            height: kToolbarHeight,
            padding: padding,
            child: Row(
              children: [
                const Text('To', style: textStyle),
                const SizedBox(width: 12),
                Flexible(
                  child: FittedBox(
                    child: CpChip(
                      padding: CpChipPadding.small,
                      child: Text.rich(
                        TextSpan(
                          text: 'William Prince',
                          children: [
                            const WidgetSpan(child: SizedBox(width: 24)),
                            TextSpan(
                              text: formattedAddress,
                              style: textStyle.copyWith(
                                color: CpColors.disabledColor,
                              ),
                            ),
                          ],
                        ),
                        maxLines: 1,
                        style: textStyle,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const Divider(color: CpColors.accentDisabledColor, height: 1),
          Container(
            height: kToolbarHeight,
            padding: padding,
            child: Row(
              children: [
                const Text('Send as', style: textStyle),
                const SizedBox(width: 12),
                FittedBox(
                  child: CpChip(
                    padding: CpChipPadding.small,
                    child: Text(token.symbol, style: textStyle),
                  ),
                )
              ],
            ),
          ),
          const Divider(color: CpColors.accentDisabledColor, height: 1),
        ],
      ),
    );
  }
}
