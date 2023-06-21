import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../ui/app_bar.dart';
import '../../../../../ui/onboarding_screen.dart';
import '../../../../../ui/profile_image_picker/pick_profile_picture.dart';
import '../../../../../ui/text_field.dart';
import '../../../../../ui/theme.dart';
import '../../../routes.gr.dart';
import '../../../ui/back_button.dart';
import '../../../ui/colors.dart';
import '../../accounts/models/profile.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({
    super.key,
    required this.onSubmitted,
    required this.onBackButtonPressed,
    this.initial,
  });

  final Profile? initial;
  final void Function(String value, File? photo, String country) onSubmitted;
  final VoidCallback onBackButtonPressed;

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final _nameController = TextEditingController();
  final _countryCodeController = TextEditingController();
  File? _photo;

  @override
  void initState() {
    super.initState();

    final profile = widget.initial;

    _nameController.addListener(() => setState(() {}));

    if (profile != null) {
      _nameController.text = profile.firstName;

      _photo = profile.photoPath?.let(File.new);

      final country = profile.country;
      if (country != null) {
        _countryCodeController.text = country;
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _countryCodeController.dispose();
    super.dispose();
  }

  Future<void> _onUpdateCountry() async {
    final code = await context.router.push<String?>(
      CountryPickerRoute(initialCountryCode: _countryCodeController.text),
    );

    if (!mounted) return;

    if (code != null) {
      setState(() {
        _countryCodeController.text = code;
      });
    }
  }

  void _handleSubmitted() => widget.onSubmitted(
        _nameController.text,
        _photo,
        _countryCodeController.text,
      );

  bool get _isValid =>
      _nameController.text.isNotEmpty && _countryCodeController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          body: OnboardingScreen(
            footer: OnboardingFooterButton(
              text: widget.initial == null
                  ? context.l10n.next
                  : context.l10n.save,
              onPressed: _isValid ? _handleSubmitted : null,
            ),
            children: [
              CpAppBar(
                leading: CpBackButton(onPressed: widget.onBackButtonPressed),
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
                  backgroundColor: Colors.white,
                ),
              ),
              OnboardingPadding(
                child: InkWell(
                  onTap: _onUpdateCountry,
                  child: IgnorePointer(
                    child: CpTextField(
                      margin: const EdgeInsets.only(top: 16),
                      placeholder: context.l10n.countryOfResidence,
                      backgroundColor: CpColors.darkBackground,
                      placeholderColor: Colors.white,
                      suffix: const Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                      readOnly: true,
                      textColor: Colors.white,
                      controller: _countryCodeController,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

const keyCreateProfileName = Key('createProfileName');
