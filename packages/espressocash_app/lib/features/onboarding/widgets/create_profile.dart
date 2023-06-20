import 'dart:io';

import 'package:auto_route/auto_route.dart';
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

class CreateProfile extends StatefulWidget {
  const CreateProfile({
    super.key,
    required this.onSubmitted,
    required this.onBackButtonPressed,
  });

  final void Function(String value, File? photo, String country) onSubmitted;
  final VoidCallback onBackButtonPressed;

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final _controller = TextEditingController();
  final _countryCodeController = TextEditingController();
  File? _photo;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
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

  void _handleSubmitted() =>
      widget.onSubmitted(_controller.text, _photo, _countryCodeController.text);

  bool get _isValid =>
      _controller.text.isNotEmpty && _countryCodeController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          body: OnboardingScreen(
            footer: OnboardingFooterButton(
              text: context.l10n.next,
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
                  controller: _controller,
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
