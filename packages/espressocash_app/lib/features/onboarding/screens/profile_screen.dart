import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/form_page.dart';
import '../../../ui/loader.dart';
import '../../../ui/text_field.dart';
import '../../../utils/email.dart';
import '../../country_picker/models/country.dart';
import '../../country_picker/widgets/country_picker.dart';
import '../../profile/data/profile_repository.dart';
import '../../profile/service/update_profile.dart';

class OnboardingProfileScreen extends StatefulWidget {
  const OnboardingProfileScreen({
    super.key,
    required this.onConfirmed,
  });

  final VoidCallback onConfirmed;

  static void open(
    BuildContext context, {
    required VoidCallback onConfirmed,
    NavigatorState? navigator,
  }) =>
      (navigator ?? Navigator.of(context, rootNavigator: true))
          .pushAndRemoveUntil<void>(
        MaterialPageRoute(
          builder: (_) => OnboardingProfileScreen(onConfirmed: onConfirmed),
        ),
        F,
      );

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

  void _handleSubmitted() => runWithLoader(
        context,
        () async {
          await sl<UpdateProfile>()
              .call(
                firstName: _firstNameController.text,
                lastName: _lastNameController.text,
                // ignore: avoid-non-null-assertion, should not be null
                countryCode: _country!.code,
                photoPath: null,
                email: _emailController.text,
              )
              .foldAsync((e) => throw e, ignore);

          unawaited(Future.microtask(() => widget.onConfirmed()));
        },
        onError: (error) => showErrorDialog(
          context,
          context.l10n.lblProfileUpdateFailed,
          error,
        ),
      );

  bool get _isValid =>
      _firstNameController.text.isNotEmpty &&
      _lastNameController.text.isNotEmpty &&
      _emailController.text.isValidEmail &&
      _country != null;

  @override
  Widget build(BuildContext context) => FormPage(
        title: Text(context.l10n.onboardingProfileTitle.toUpperCase()),
        colorTheme: FormPageColorTheme.gold,
        header: FormPageHeader(
          title: const SizedBox.shrink(),
          description: Text(
            context.l10n.yourEmailDisclaimer,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
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
        backgroundColor: const Color(0xFF9D8A59),
        placeholder: placeholder,
        placeholderColor: Colors.white,
        textColor: Colors.white,
        fontSize: 16,
      );
}
