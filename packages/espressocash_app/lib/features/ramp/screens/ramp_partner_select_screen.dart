import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/back_button.dart';
import '../../../ui/colors.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/loader.dart';
import '../../../ui/onboarding_screen.dart';
import '../../../ui/theme.dart';
import '../../country_picker/models/country.dart';
import '../../country_picker/widgets/country_picker.dart';
import '../../profile/data/profile_repository.dart';
import '../../profile/service/update_profile.dart';
import '../../ramp_partner/models/ramp_partner.dart';
import '../models/ramp_type.dart';
import '../widgets/partner_config.dart';
import '../widgets/partner_tile.dart';

class RampPartnerSelectScreen extends StatefulWidget {
  const RampPartnerSelectScreen({
    super.key,
    required this.type,
    required this.onPartnerSelected,
  });

  static void push(
    BuildContext context, {
    required RampType type,
    required ValueSetter<RampPartner> onPartnerSelected,
  }) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => RampPartnerSelectScreen(
            type: type,
            onPartnerSelected: onPartnerSelected,
          ),
        ),
      );

  final RampType type;
  final ValueSetter<RampPartner> onPartnerSelected;

  @override
  State<RampPartnerSelectScreen> createState() =>
      _RampPartnerSelectScreenState();
}

class _RampPartnerSelectScreenState extends State<RampPartnerSelectScreen> {
  Country? _country;

  IList<RampPartner> get _partners => switch (widget.type) {
        RampType.onRamp => getOnRampPartners(_country?.code),
        RampType.offRamp => getOffRampPartners(_country?.code),
      };

  @override
  void initState() {
    super.initState();

    final repository = sl<ProfileRepository>();

    final country = repository.country;
    if (country != null) {
      _country = Country.findByCode(country);
    }
  }

  void _handleCountryChange(Country country) => runWithLoader(
        context,
        () async {
          await sl<UpdateProfile>()
              .call(countryCode: country.code)
              .foldAsync((e) => throw e, ignore);

          if (!mounted) return;

          setState(() {
            _country = country;
          });
        },
        onError: (error) => showErrorDialog(
          context,
          context.l10n.lblProfileUpdateFailed,
          error,
        ),
      );

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
              if (_partners.isEmpty) ...[
                Assets.icons.errorIcon.svg(height: 100.h),
              ] else
                switch (widget.type) {
                  RampType.onRamp =>
                    Assets.images.cashInGraphic.image(height: 100.h),
                  RampType.offRamp =>
                    Assets.images.cashOutGraphic.image(height: 100.h),
                },
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 42.w),
                child: MarkdownBody(
                  data: switch (widget.type) {
                    RampType.onRamp =>
                      context.l10n.selectPartnerOnRampTitle.toUpperCase(),
                    RampType.offRamp =>
                      context.l10n.selectPartnerOffRampTitle.toUpperCase(),
                  },
                  styleSheet: MarkdownStyleSheet(
                    em: _markdownStyle.copyWith(color: CpColors.yellowColor),
                    p: _markdownStyle,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 42.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    context.l10n.selectPartnerAdditionalText,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.sp),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: CountryPicker(
                  backgroundColor: CpColors.darkBackgroundColor,
                  country: _country,
                  onSubmitted: _handleCountryChange,
                ),
              ),
              if (_partners.isEmpty) ...[
                const Spacer(),
                const _CountryNotSupportedWidget(),
              ],
              SizedBox(height: 20.h),
              for (final partner in _partners)
                PartnerTile(
                  partner: partner,
                  type: widget.type,
                  onPartnerSelected: widget.onPartnerSelected,
                ),
            ],
          ),
        ),
      );
}

class _CountryNotSupportedWidget extends StatelessWidget {
  const _CountryNotSupportedWidget();

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(
            context.l10n.countryNotSupportedText.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.sp,
              height: 24 / 20,
              letterSpacing: 0.23,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            context.l10n.countryNotSupportedAdditionalText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      );
}

final _markdownStyle = TextStyle(
  fontStyle: FontStyle.normal,
  fontSize: 32.sp,
  fontWeight: FontWeight.w900,
  letterSpacing: 0.25,
  height: 1,
);
