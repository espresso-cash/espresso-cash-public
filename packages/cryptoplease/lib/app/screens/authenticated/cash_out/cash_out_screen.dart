import 'package:cryptoplease/app/components/partner_button.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:flutter/material.dart';

class CashOutScreen extends StatelessWidget {
  const CashOutScreen({
    Key? key,
    required this.onFtxSelected,
  }) : super(key: key);

  final VoidCallback onFtxSelected;

  @override
  Widget build(BuildContext context) => ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text(
            context.l10n.cashOutSubtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14.5),
          ),
          const SizedBox(height: 24),
          PartnerButton(
            onTap: onFtxSelected,
            image: Assets.images.logoFtx,
            backgroundColor: const Color(0xff12a8c9),
          ),
        ],
      );
}
