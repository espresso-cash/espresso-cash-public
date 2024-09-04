import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/back_button.dart';
import '../../../ui/colors.dart';
import '../../../ui/onboarding_screen.dart';
import '../../../ui/theme.dart';
import '../../country_picker/models/country.dart';
import '../../country_picker/widgets/country_picker.dart';
import '../../profile/data/profile_repository.dart';
import '../../ramp_partner/models/ramp_partner.dart';
import '../models/ramp_type.dart';
import '../widgets/partner_tile.dart';

class RampPartnerSelectScreen extends StatefulWidget {
  const RampPartnerSelectScreen({
    super.key,
    required this.partners,
    required this.type,
    required this.onPartnerSelected,
  });

  static void push(
    BuildContext context, {
    required IList<RampPartner> partners,
    required RampType type,
    required ValueSetter<RampPartner> onPartnerSelected,
  }) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => RampPartnerSelectScreen(
            partners: partners,
            type: type,
            onPartnerSelected: onPartnerSelected,
          ),
        ),
      );

  final IList<RampPartner> partners;
  final RampType type;
  final ValueSetter<RampPartner> onPartnerSelected;

  @override
  State<RampPartnerSelectScreen> createState() =>
      _RampPartnerSelectScreenState();
}

class _RampPartnerSelectScreenState extends State<RampPartnerSelectScreen> {
  Country? _country;

  @override
  void initState() {
    super.initState();

    final repository = sl<ProfileRepository>();

    final country = repository.country;
    if (country != null) {
      _country = Country.findByCode(country);
    }
  }

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          appBar: CpAppBar(
            leading: const CpBackButton(),
            title: Text(
              switch (widget.type) {
                RampType.onRamp => context.l10n.ramp_btnAddCash.toUpperCase(),
                RampType.offRamp => context.l10n.ramp_btnCashOut.toUpperCase(),
              },
            ),
          ),
          body: OnboardingScreen(
            children: [
              switch (widget.type) {
                RampType.onRamp =>
                  Assets.images.cashInGraphic.image(height: 100),
                RampType.offRamp =>
                  Assets.images.cashOutGraphic.image(height: 100),
              },
              const SizedBox(height: 20),
              OnboardingPadding(
                child: Text.rich(
                  TextSpan(
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.25,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Withdrawals'.toUpperCase(),
                        style: const TextStyle(
                          color: CpColors.yellowColor,
                        ),
                      ),
                      TextSpan(
                        text: ' are processed by our network partners'
                            .toUpperCase(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const OnboardingPadding(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Payment methods & fees vary by region.\nConfirm your current location:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: CountryPicker(
                  country: _country,
                  onSubmitted: (country) => setState(() => _country = country),
                ),
              ),
              const SizedBox(height: 20),
              for (final partner in widget.partners)
                PartnerTile(
                  partner: partner,
                  onPartnerSelected: widget.onPartnerSelected,
                ),
            ],
          ),
        ),
      );
}
