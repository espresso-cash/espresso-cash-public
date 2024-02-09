import 'package:auto_route/auto_route.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/arrow.dart';
import '../../../wallet_flow/widgets/pay_details_page.dart';
import '../../models/ramp_partner.dart';
import '../models/ramp_type.dart';

@RoutePage()
class RampMoreOptionsPartnerScreen extends StatelessWidget {
  const RampMoreOptionsPartnerScreen({
    super.key,
    required this.otherPartners,
    required this.type,
    required this.onPartnerSelected,
  });

  static const route = RampMoreOptionsPartnerRoute.new;

  final IList<RampPartner> otherPartners;
  final RampType type;
  final ValueSetter<RampPartner> onPartnerSelected;

  @override
  Widget build(BuildContext context) => PayDetailsPage(
        title: switch (type) {
          RampType.onRamp => context.l10n.ramp_btnAddCash,
          RampType.offRamp => context.l10n.ramp_btnCashOut,
        }
            .toUpperCase(),
        headerIcon: switch (type) {
          RampType.onRamp => Assets.images.cashInGraphic,
          RampType.offRamp => Assets.images.cashOutGraphic,
        },
        headerBackground: Assets.images.sendManualBg,
        content: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 300,
                child: Text(
                  switch (type) {
                    RampType.onRamp => context.l10n.onRampMorePartnersTitle,
                    RampType.offRamp => context.l10n.offRampMorePartnersTitle,
                  },
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              for (final partner in otherPartners)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 18,
                  ),
                  child: DecoratedBox(
                    decoration: const ShapeDecoration(
                      color: Colors.black,
                      shape: StadiumBorder(),
                    ),
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 28),
                      title: Text(
                        partner.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        context.l10n
                            .rampMinimumTransferAmount(partner.minimumAmount),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: const Arrow(color: Colors.white),
                      onTap: () => onPartnerSelected(partner),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
}
