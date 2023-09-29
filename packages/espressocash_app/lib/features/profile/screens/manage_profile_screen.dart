import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../ui/app_bar.dart';
import '../../../../../ui/onboarding_screen.dart';
import '../../../../../ui/text_field.dart';
import '../../../../../ui/theme.dart';
import '../../../core/email.dart';
import '../../../core/file_manager.dart';
import '../../../di.dart';
import '../../../routes.gr.dart';
import '../../../ui/back_button.dart';
import '../../../ui/colors.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/loader.dart';
import '../../country_picker/models/country.dart';
import '../../country_picker/widgets/country_picker.dart';
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

  void _handleSubmitted() => runWithLoader(context, () async {
        try {
          final photo = await _photo?.let(sl<FileManager>().copyToAppDir);

          if (!mounted) return;

          sl<ProfileRepository>()
            ..firstName = _nameController.text
            ..country = _country?.code
            ..photoPath = photo?.path
            ..email = _emailController.text;

          widget.onSubmitted();
        } on Exception catch (e) {
          if (!mounted) return;

          showErrorDialog(context, 'Error', e);
        }
      });

  bool get _isValid =>
      _nameController.text.isNotEmpty &&
      _emailController.text.isValidEmail &&
      _country != null;

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          body: OnboardingScreen(
            footer: ListenableBuilder(
              listenable: Listenable.merge([_nameController, _emailController]),
              builder: (context, child) => OnboardingFooterButton(
                text: context.l10n.save,
                onPressed: _isValid ? _handleSubmitted : null,
              ),
            ),
            children: [
              CpAppBar(
                leading: CpBackButton(
                  onPressed: () => context.router.pop(),
                ),
              ),
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
                  placeholder: context.l10n.yourFirstNamePlaceholder,
                  controller: _nameController,
                  textColor: Colors.white,
                  backgroundColor: CpColors.blackTextFieldBackgroundColor,
                ),
              ),
              OnboardingPadding(
                child: CpTextField(
                  margin: const EdgeInsets.only(top: 16),
                  placeholder: context.l10n.yourEmailPlaceholder,
                  controller: _emailController,
                  textColor: Colors.white,
                  backgroundColor: CpColors.blackTextFieldBackgroundColor,
                ),
              ),
              const SizedBox(height: 8),
              OnboardingPadding(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    context.l10n.yourEmailDisclaimer,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
              ),
              const SizedBox(height: 40),
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

const keyCreateProfileName = Key('createProfileName');
