import 'dart:io';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../ui/app_bar.dart';
import '../../../../../ui/onboarding_screen.dart';
import '../../../../../ui/text_field.dart';
import '../../../../../ui/theme.dart';
import '../../../data/file_manager.dart';
import '../../../di.dart';
import '../../../ui/colors.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/loader.dart';
import '../../../utils/email.dart';
import '../../country_picker/models/country.dart';
import '../../country_picker/widgets/country_picker.dart';
import '../data/profile_repository.dart';
import '../service/update_profile.dart';
import '../widgets/pick_profile_picture.dart';

class ManageProfileScreen extends StatefulWidget {
  const ManageProfileScreen({super.key});

  static void push(BuildContext context) => Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => const ManageProfileScreen(),
        ),
      );

  @override
  State<ManageProfileScreen> createState() => _ManageProfileScreenState();
}

class _ManageProfileScreenState extends State<ManageProfileScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  Country? _country;
  File? _photo;

  @override
  void initState() {
    super.initState();

    final repository = sl<ProfileRepository>();

    _firstNameController.text = repository.firstName;
    _lastNameController.text = repository.lastName;
    _emailController.text = repository.email;

    _photo = repository.photoPath?.let(File.new);

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
          final photo = await _photo?.let(sl<FileManager>().copyToAppDir);

          await sl<UpdateProfile>()
              .call(
                firstName: _firstNameController.text,
                lastName: _lastNameController.text,
                // ignore: avoid-non-null-assertion, should not be null
                countryCode: _country!.code,
                photoPath: photo?.path,
                email: _emailController.text,
              )
              .foldAsync((e) => throw e, ignore);

          if (!mounted) return;
          Navigator.of(context).pop();
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
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          appBar: const CpAppBar(),
          extendBodyBehindAppBar: true,
          body: OnboardingScreen(
            footer: ListenableBuilder(
              listenable: Listenable.merge([
                _firstNameController,
                _lastNameController,
                _emailController,
              ]),
              builder: (context, child) => OnboardingFooterButton(
                text: context.l10n.save,
                onPressed: _isValid ? _handleSubmitted : null,
              ),
            ),
            children: [
              SizedBox(height: MediaQuery.paddingOf(context).top + 24),
              ProfileImagePicker(
                photo: _photo,
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
                  controller: _firstNameController,
                  textColor: Colors.white,
                  placeholderColor: _placeholderTextColor,
                  backgroundColor: CpColors.blackTextFieldBackgroundColor,
                  fontSize: 16,
                  inputType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                ),
              ),
              OnboardingPadding(
                child: CpTextField(
                  margin: const EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  placeholder: context.l10n.yourLastNamePlaceholder,
                  controller: _lastNameController,
                  textColor: Colors.white,
                  placeholderColor: _placeholderTextColor,
                  backgroundColor: CpColors.blackTextFieldBackgroundColor,
                  fontSize: 16,
                  inputType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
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
                  inputType: TextInputType.emailAddress,
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
