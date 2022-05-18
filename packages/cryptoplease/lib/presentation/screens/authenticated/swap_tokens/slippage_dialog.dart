import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/dialogs.dart';
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

  void _onSlippageInfo(BuildContext context) {
    showWarningDialog(
      context,
      title: context.l10n.slippage,
      message: context.l10n.slippageAbout,
    );
  }

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: AlertDialog(
          backgroundColor: CpColors.primaryColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(context.l10n.slippage.toUpperCase()),
              Flexible(
                child: IconButton(
                  onPressed: () => _onSlippageInfo(context),
                  icon: const Icon(Icons.info_outline),
                ),
              )
            ],
          ),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
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
          ),
        ),
      );
}
