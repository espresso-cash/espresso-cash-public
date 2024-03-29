import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../routing.dart';
import '../../wallet_flow/widgets/pay_main_page.dart';
import '../models/ramp_partner.dart';
import '../models/ramp_type.dart';
import 'ramp_more_options_screen.dart';

class RampPartnerSelectScreen extends StatelessWidget {
  const RampPartnerSelectScreen({
    super.key,
    required this.topPartner,
    required this.otherPartners,
    required this.type,
    required this.onPartnerSelected,
  });

  final RampPartner topPartner;
  final IList<RampPartner> otherPartners;
  final RampType type;
  final ValueSetter<RampPartner> onPartnerSelected;

  @override
  Widget build(BuildContext context) => PayMainPage(
        title: switch (type) {
          RampType.onRamp => context.l10n.ramp_btnAddCash,
          RampType.offRamp => context.l10n.ramp_btnCashOut,
        }
            .toUpperCase(),
        headerIcon: switch (type) {
          RampType.onRamp => Assets.images.cashInGraphic,
          RampType.offRamp => Assets.images.cashOutGraphic,
        },
        headerBackground: switch (type) {
          RampType.onRamp => Assets.images.formPageOrangeBg,
          RampType.offRamp => Assets.images.formPageGoldBg,
        },
        theme: switch (type) {
          RampType.onRamp => PayTheme.dark,
          RampType.offRamp => PayTheme.light,
        },
        description: switch (type) {
          RampType.onRamp => context.l10n.onRampTopPartnerTitle,
          RampType.offRamp => context.l10n.offRampTopPartnerTitle,
        },
        subtitle:
            context.l10n.rampMinimumTransferAmount(topPartner.minimumAmount),
        moreOptionsLabel: switch (type) {
          RampType.onRamp => context.l10n.onRampMorePartnersFooter,
          RampType.offRamp => context.l10n.offRampMorePartnersFooter,
        },
        onContinue: () => onPartnerSelected(topPartner),
        onMoreOptions: () => RampMoreOptionsRoute(
          (
            type: type,
            otherPartners: otherPartners,
            onPartnerSelected: (RampPartner partner) {
              context.pop();
              onPartnerSelected(partner);
            },
          ),
        ).push<void>(context),
      );
}

class RampPartnerSelectRoute extends GoRouteData {
  const RampPartnerSelectRoute(this.$extra);

  final RampPartnerSelectParams $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      RampPartnerSelectScreen(
        topPartner: $extra.topPartner,
        otherPartners: $extra.otherPartners,
        type: $extra.type,
        onPartnerSelected: $extra.onPartnerSelected,
      );
}

typedef RampPartnerSelectParams = ({
  RampPartner topPartner,
  IList<RampPartner> otherPartners,
  RampType type,
  ValueSetter<RampPartner> onPartnerSelected,
});
