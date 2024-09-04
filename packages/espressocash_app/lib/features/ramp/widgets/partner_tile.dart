import 'package:flutter/material.dart';

import '../../../ui/colors.dart';
import '../../ramp_partner/models/payment_methods.dart';
import '../../ramp_partner/models/ramp_partner.dart';

class PartnerTile extends StatelessWidget {
  const PartnerTile({
    super.key,
    required this.partner,
    required this.onPartnerSelected,
  });

  final RampPartner partner;
  final ValueSetter<RampPartner> onPartnerSelected;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 18,
        ),
        child: DecoratedBox(
          decoration: const ShapeDecoration(
            color: CpColors.darkBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
          ),
          child: ListTile(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            leading: Container(
              alignment: Alignment.center,
              width: 40,
              child: partner.logo.image(),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                partner.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            subtitle: Row(
              children: [
                for (final method in partner.paymentMethods) ...[
                  method.logo.image(),
                  const SizedBox(width: 4),
                ],
                if (partner == RampPartner.moneygram) ...[
                  const Text('Cash deposits', style: _subtitleStyle),
                ],
                const Spacer(),
                Text('Min ${partner.minimumAmount}', style: _subtitleStyle),
              ],
            ),
            onTap: () => onPartnerSelected(partner),
          ),
        ),
      );
}

const _subtitleStyle = TextStyle(
  fontSize: 14,
  color: Colors.white,
  fontWeight: FontWeight.w400,
);
