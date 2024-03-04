import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/email.dart';
import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/text_field.dart';
import '../../country_picker/models/country.dart';
import '../../country_picker/widgets/country_picker.dart';
import '../../profile/data/profile_repository.dart';
import '../models/ramp_type.dart';
import '../src/widgets/ramp_page.dart';

class RampOnboardingScreen extends StatefulWidget {
  const RampOnboardingScreen({
    super.key,
    required this.rampType,
    required this.onConfirmed,
  });

  final RampType rampType;
  final VoidCallback onConfirmed;

  @override
  State<RampOnboardingScreen> createState() => _RampOnboardingScreenState();
}

class _RampOnboardingScreenState extends State<RampOnboardingScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  Country? _country;

  @override
  void initState() {
    super.initState();

    final repository = sl<ProfileRepository>();

    _firstNameController.text = repository.firstName;
    _lastNameController.text = repository.lastName;
    _emailController.text = repository.email;

    final country = repository.country;
    if (country != null) {
      _country = Country.findByCode(country);
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _handleSubmitted() {
    sl<ProfileRepository>()
      ..firstName = _firstNameController.text
      ..lastName = _lastNameController.text
      ..country = _country?.code
      ..email = _emailController.text;

    widget.onConfirmed();
  }

  bool get _isValid =>
      _firstNameController.text.isNotEmpty &&
      _lastNameController.text.isNotEmpty &&
      _emailController.text.isValidEmail &&
      _country != null;

  @override
  Widget build(BuildContext context) => RampPage(
        headerIcon: Assets.images.identityGraphic,
        headerContent: Column(
          children: [
            const SizedBox(height: 7),
            Text(
              context.l10n.rampBasicInfoRequired,
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              context.l10n.yourEmailDisclaimer,
              style: const TextStyle(fontSize: 13),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 70),
          ],
        ),
        content: ColoredBox(
          color: switch (widget.rampType) {
            RampType.onRamp => CpColors.darkOrangeBackgroundColor,
            RampType.offRamp => CpColors.goldBackgroundColor,
          },
          child: SafeArea(
            top: false,
            minimum: const EdgeInsets.only(bottom: 75, left: 40, right: 40),
            child: Column(
              children: [
                CpTextField(
                  padding: const EdgeInsets.only(
                    top: 18,
                    bottom: 16,
                    left: 26,
                    right: 26,
                  ),
                  controller: _firstNameController,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  backgroundColor: switch (widget.rampType) {
                    RampType.onRamp => _onRampTextfieldColor,
                    RampType.offRamp => _offRampTextfieldColor,
                  },
                  placeholder: context.l10n.yourFirstNamePlaceholder,
                  placeholderColor: Colors.white,
                  textColor: Colors.white,
                  fontSize: 16,
                ),
                const SizedBox(height: 14),
                CpTextField(
                  padding: const EdgeInsets.only(
                    top: 18,
                    bottom: 16,
                    left: 26,
                    right: 26,
                  ),
                  controller: _lastNameController,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  backgroundColor: switch (widget.rampType) {
                    RampType.onRamp => _onRampTextfieldColor,
                    RampType.offRamp => _offRampTextfieldColor,
                  },
                  placeholder: context.l10n.yourLastNamePlaceholder,
                  placeholderColor: Colors.white,
                  textColor: Colors.white,
                  fontSize: 16,
                ),
                const SizedBox(height: 14),
                CpTextField(
                  padding: const EdgeInsets.only(
                    top: 18,
                    bottom: 16,
                    left: 26,
                    right: 26,
                  ),
                  controller: _emailController,
                  inputType: TextInputType.emailAddress,
                  backgroundColor: switch (widget.rampType) {
                    RampType.onRamp => _onRampTextfieldColor,
                    RampType.offRamp => _offRampTextfieldColor,
                  },
                  placeholder: context.l10n.yourEmailPlaceholder,
                  placeholderColor: Colors.white,
                  textColor: Colors.white,
                  fontSize: 16,
                ),
                const SizedBox(height: 14),
                CountryPicker(
                  country: _country,
                  onSubmitted: (country) => setState(() => _country = country),
                ),
                const SizedBox(height: 28),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ListenableBuilder(
                      listenable: Listenable.merge([
                        _firstNameController,
                        _lastNameController,
                        _emailController,
                      ]),
                      builder: (context, child) => CpButton(
                        width: double.infinity,
                        text: context.l10n.next,
                        onPressed: _isValid ? _handleSubmitted : null,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        type: widget.rampType,
      );
}

class RampOnboardingRoute extends GoRouteData {
  const RampOnboardingRoute(this.$extra);

  final RampOnboardingParams $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      RampOnboardingScreen(
        rampType: $extra.rampType,
        onConfirmed: $extra.onConfirmed,
      );
}

typedef RampOnboardingParams = ({
  RampType rampType,
  VoidCallback onConfirmed,
});

const _onRampTextfieldColor = Color(0xFFB84D12);
const _offRampTextfieldColor = Color(0xFF9D8A59);
