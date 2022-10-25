import 'package:cryptoplease/app/components/partner_button.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:flutter/material.dart';

class AddFundsScreen extends StatelessWidget {
  const AddFundsScreen({
    Key? key,
    required this.onMoonpaySelected,
    required this.onKadoSelected,
    required this.onFtxSelected,
  }) : super(key: key);

  final VoidCallback onMoonpaySelected;
  final VoidCallback onKadoSelected;
  final VoidCallback onFtxSelected;

  @override
  Widget build(BuildContext context) => ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text(
            context.l10n.addCashSubtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14.5),
          ),
          const SizedBox(height: 24),
          PartnerButton(
            onTap: onKadoSelected,
            image: Assets.images.logoKado,
            backgroundColor: const Color(0xff5272d6),
          ),
          PartnerButton(
            onTap: onMoonpaySelected,
            image: Assets.images.logoMoonpay,
            backgroundColor: const Color(0xff6800f3),
          ),
          PartnerButton(
            onTap: onFtxSelected,
            image: Assets.images.logoFtx,
            backgroundColor: const Color(0xff12a8c9),
          ),
        ],
      );
}
