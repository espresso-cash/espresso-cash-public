import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/fungible_token/confirm_screen/components/list_item.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class FeeView extends StatelessWidget {
  const FeeView({
    Key? key,
    required this.formattedFee,
    required this.formattedFiatFee,
  }) : super(key: key);

  final String formattedFee;
  final String? formattedFiatFee;

  @override
  Widget build(BuildContext context) => ListItem(
        label: context.l10n.labelFee,
        child: Text.rich(
          TextSpan(
            text: formattedFee,
            children: [
              if (formattedFiatFee != null)
                TextSpan(
                  text: '\n≈ $formattedFiatFee',
                  style: const TextStyle(fontSize: 15),
                ),
            ],
          ),
          style: const TextStyle(
            color: CpColors.primaryTextColor,
            fontWeight: FontWeight.w600,
            fontSize: 21,
          ),
          textAlign: TextAlign.center,
        ),
      );
}
