import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../ui/app_bar.dart';
import '../../../../../ui/onboarding_screen.dart';
import '../../../../../ui/text_field.dart';
import '../../../../../ui/theme.dart';
import '../../../core/email.dart';
import '../../../data/files/file_manager.dart';
import '../../../di.dart';
import '../../../routes.gr.dart';
import '../../../ui/back_button.dart';
import '../../../ui/colors.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/loader.dart';
import '../../country_picker/models/country.dart';
import '../../country_picker/widgets/country_picker.dart';
import '../../intercom/services/intercom_service.dart';
import '../data/profile_repository.dart';
import '../widgets/pick_profile_picture.dart';

@RoutePage()
class ManageProfileScreen extends StatefulWidget {
  const ManageProfileScreen({
    super.key,
    required this.onSubmitted,
  });

  static const route = ManageProfileRoute.new;

  final VoidCallback onSubmitted;

  @override
  State<ManageProfileScreen> createState() => _ManageProfileScreenState();
}

class _ManageProfileScreenState extends State<ManageProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  Country? _country;
  File? _photo;

  @override
  void initState() {
    super.initState();

    final repository = sl<ProfileRepository>();

    _nameController.text = repository.firstName;
    _emailController.text = repository.email;

    _photo = repository.photoPath?.let(File.new);

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

  void _handleSubmitted() => runWithLoader(
        context,
        () async {
          final photo = await _photo?.let(sl<FileManager>().copyToAppDir);

          final newCountryCode = _country?.code;
          final wasCountryChanged =
              newCountryCode != sl<ProfileRepository>().country;
          if (wasCountryChanged && newCountryCode != null) {
            final request = WalletCountryRequestDto(
              countryCode: newCountryCode,
            );
            await sl<EspressoCashClient>().updateUserWalletCountry(request);
            sl<IntercomService>().updateCountry(newCountryCode);
          }

          sl<ProfileRepository>()
            ..firstName = _nameController.text
            ..country = _country?.code
            ..photoPath = photo?.path
            ..email = _emailController.text;

          widget.onSubmitted();
        },
        onError: (error) => showErrorDialog(context, 'Error', error),
      );

  bool get _isValid =>
      _nameController.text.isNotEmpty &&
      _emailController.text.isValidEmail &&
      _country != null;

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          appBar: CpAppBar(
            leading: CpBackButton(
              onPressed: () => context.router.pop(),
            ),
          ),
          extendBodyBehindAppBar: true,
          body: OnboardingScreen(
            footer: ListenableBuilder(
              listenable: Listenable.merge([_nameController, _emailController]),
              builder: (context, child) => OnboardingFooterButton(
                text: context.l10n.save,
                onPressed: _isValid ? _handleSubmitted : null,
              ),
            ),
            children: [
              SizedBox(height: MediaQuery.paddingOf(context).top + 24),
              ProfileImagePicker(
                photo: _photo,
                label: context.l10n.uploadPhoto,
                onChanged: (File? value) => setState(() => _photo = value),
              ),
              const SizedBox(height: 32),
              OnboardingPadding(
                child: CpTextField(
                  key: keyCreateProfileName,
                  margin: const EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  placeholder: context.l10n.yourFirstNamePlaceholder,
                  controller: _nameController,
                  textColor: Colors.white,
                  placeholderColor: _placeholderTextColor,
                  backgroundColor: CpColors.blackTextFieldBackgroundColor,
                  fontSize: 16,
                ),
              ),
              OnboardingPadding(
                child: CpTextField(
                  margin: const EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  placeholder: context.l10n.yourEmailPlaceholder,
                  controller: _emailController,
                  textColor: Colors.white,
                  placeholderColor: _placeholderTextColor,
                  backgroundColor: CpColors.blackTextFieldBackgroundColor,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              OnboardingPadding(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    context.l10n.profileDisclaimer,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              OnboardingPadding(
                child: CountryPicker(
                  country: _country,
                  onSubmitted: (country) => setState(() => _country = country),
                ),
              ),
            ],
          ),
        ),
      );
}

const _placeholderTextColor = Color(0xff858585);
const keyCreateProfileName = Key('createProfileName');
