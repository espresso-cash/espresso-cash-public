import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/email.dart';
import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../routing.dart';
import '../../../ui/button.dart';
import '../../../ui/form_page.dart';
import '../../../ui/text_field.dart';
import '../../country_picker/models/country.dart';
import '../../country_picker/widgets/country_picker.dart';
import '../../investments/screens/main_screen.dart';
import '../../profile/data/profile_repository.dart';

class OnboardingProfileScreen extends StatefulWidget {
  const OnboardingProfileScreen({
    super.key,
    required this.onConfirmed,
  });

  final VoidCallback onConfirmed;

  @override
  State<OnboardingProfileScreen> createState() =>
      _OnboardingProfileScreenState();
}

class _OnboardingProfileScreenState extends State<OnboardingProfileScreen> {
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
  Widget build(BuildContext context) => FormPage(
        title: Text(context.l10n.onboardingProfileTitle),
        colorTheme: FormPageColorTheme.gold,
        header: FormPageHeader(
          title: Text(context.l10n.rampBasicInfoRequired),
          description: Text(context.l10n.yourEmailDisclaimer),
          icon: Assets.images.identityGraphic,
        ),
        child: Column(
          children: [
            _ProfileTextField(
              emailController: _firstNameController,
              inputType: TextInputType.name,
              placeholder: context.l10n.yourFirstNamePlaceholder,
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 14),
            _ProfileTextField(
              emailController: _lastNameController,
              inputType: TextInputType.name,
              placeholder: context.l10n.yourLastNamePlaceholder,
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 14),
            _ProfileTextField(
              emailController: _emailController,
              inputType: TextInputType.emailAddress,
              placeholder: context.l10n.yourEmailPlaceholder,
            ),
            const SizedBox(height: 14),
            CountryPicker(
              country: _country,
              onSubmitted: (country) => setState(() => _country = country),
            ),
            const SizedBox(height: 28),
            const Spacer(),
            ListenableBuilder(
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
          ],
        ),
      );
}

class OnboardingProfileRoute extends GoRouteData {
  const OnboardingProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      OnboardingProfileScreen(
        onConfirmed: () => const HomeRoute().go(context),
      );
}

class _ProfileTextField extends StatelessWidget {
  const _ProfileTextField({
    required this.emailController,
    required this.inputType,
    required this.placeholder,
    this.textCapitalization = TextCapitalization.none,
  });

  final TextEditingController emailController;
  final TextInputType inputType;
  final TextCapitalization textCapitalization;
  final String placeholder;

  static const _offRampTextfieldColor = Color(0xFF9D8A59);

  @override
  Widget build(BuildContext context) => CpTextField(
        padding: const EdgeInsets.only(
          top: 18,
          bottom: 16,
          left: 26,
          right: 26,
        ),
        controller: emailController,
        inputType: inputType,
        textInputAction: TextInputAction.next,
        textCapitalization: textCapitalization,
        backgroundColor: _offRampTextfieldColor,
        placeholder: placeholder,
        placeholderColor: Colors.white,
        textColor: Colors.white,
        fontSize: 16,
      );
}
