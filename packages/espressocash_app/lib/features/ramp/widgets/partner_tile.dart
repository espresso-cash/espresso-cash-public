import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/arrow.dart';
import '../../../ui/colors.dart';
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
            leading: Container(
              alignment: Alignment.center,
              width: 40,
              child: partner.logo.image(),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
            title: Text(
              partner.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Row(
              children: [
                Text(
                  context.l10n.rampMinimumTransferAmount(partner.minimumAmount),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                const Text(
                  'min 10h',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            onTap: () => onPartnerSelected(partner),
          ),
        ),
      );
}
