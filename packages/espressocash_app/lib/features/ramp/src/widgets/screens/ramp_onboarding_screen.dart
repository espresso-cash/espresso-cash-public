import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../core/email.dart';
import '../../../../../di.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../routes.gr.dart';
import '../../../../../ui/button.dart';
import '../../../../../ui/text_field.dart';
import '../../../../country_picker/models/country.dart';
import '../../../../country_picker/widgets/country_picker.dart';
import '../../../../profile/data/profile_repository.dart';
import '../../models/ramp_type.dart';
import '../ramp_page.dart';

@RoutePage()
class RampOnboardingScreen extends StatefulWidget {
  const RampOnboardingScreen({
    super.key,
    required this.rampType,
    required this.onConfirmed,
  });

  static const route = RampOnboardingRoute.new;

  final RampType rampType;
  final VoidCallback onConfirmed;

  @override
  State<RampOnboardingScreen> createState() => _RampOnboardingScreenState();
}

class _RampOnboardingScreenState extends State<RampOnboardingScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  Country? _country;

  @override
  void initState() {
    super.initState();

    final repository = sl<ProfileRepository>();

    _nameController.text = repository.firstName;
    _emailController.text = repository.email;

    final country = repository.country;
    if (country != null) {
      _country = Country.findByCode(country);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _handleSubmitted() {
    sl<ProfileRepository>()
      ..firstName = _nameController.text
      ..country = _country?.code
      ..email = _emailController.text;

    widget.onConfirmed();
  }

  bool get _isValid =>
      _nameController.text.isNotEmpty &&
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
        content: SafeArea(
          top: false,
          minimum: const EdgeInsets.only(
            top: 44,
            left: 40,
            right: 40,
            bottom: 75,
          ),
          child: Column(
            children: [
              CpTextField(
                padding: const EdgeInsets.only(
                  top: 18,
                  bottom: 16,
                  left: 26,
                  right: 26,
                ),
                controller: _nameController,
                textInputAction: TextInputAction.next,
                backgroundColor: const Color(0xFFE7E5DE),
                placeholder: context.l10n.yourFirstNamePlaceholder,
                placeholderColor: const Color(0xFF989898),
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
                backgroundColor: const Color(0xFFE7E5DE),
                placeholder: context.l10n.yourEmailPlaceholder,
                placeholderColor: const Color(0xFF989898),
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
                      _nameController,
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
        type: widget.rampType,
      );
}
