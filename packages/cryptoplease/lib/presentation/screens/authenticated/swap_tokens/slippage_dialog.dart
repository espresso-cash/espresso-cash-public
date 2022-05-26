import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/authenticated/swap_tokens/components/slippage_dropdown.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

class SlippageDialog extends StatelessWidget {
  const SlippageDialog({
    Key? key,
    required this.currentSlippage,
    required this.onSlippageChange,
  }) : super(key: key);

  final Decimal currentSlippage;
  final ValueSetter<Decimal> onSlippageChange;

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: AlertDialog(
          backgroundColor: CpColors.primaryColor,
          title: Text(context.l10n.slippage.toUpperCase()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: SlippageDropdown(
                    currentSlippage: currentSlippage,
                    onSlippageChanged: (slippage) {
                      onSlippageChange(slippage);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                context.l10n.slippageAbout,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              )
            ],
          ),
        ),
      );
}
