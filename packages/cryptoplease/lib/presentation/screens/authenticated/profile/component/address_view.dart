import 'package:cryptoplease/presentation/snackbars.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddressView extends StatelessWidget {
  const AddressView({
    Key? key,
    required this.address,
    this.textStyle,
    this.decorate = true,
    this.width = 150,
    this.alignment = Alignment.center,
    this.color = CpColors.lightGreyBackground,
  }) : super(key: key);

  final String address;
  final TextStyle? textStyle;
  final double? width;
  final bool decorate;
  final Alignment alignment;
  final Color color;

  void _onTap(BuildContext context) {
    final data = ClipboardData(text: address);
    Clipboard.setData(data);
    showClipboardSnackbar(context);
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => _onTap(context),
        child: Container(
          width: width,
          constraints: const BoxConstraints(minHeight: 32),
          decoration: decorate
              ? BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                )
              : null,
          alignment: alignment,
          child: FittedBox(
            child: Text.rich(
              TextSpan(
                text: '${substring(address, 0, 4)}'
                    '\u2026'
                    '${substring(address, address.length - 4)}',
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Icon(
                        Icons.copy,
                        size: 16,
                        color: textStyle?.color ?? CpColors.primaryTextColor,
                      ),
                    ),
                  ),
                ],
              ),
              style: textStyle ??
                  const TextStyle(
                    color: CpColors.primaryTextColor,
                    fontSize: 18,
                  ),
            ),
          ),
        ),
      );
}
