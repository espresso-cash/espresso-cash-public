import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../ui/app_bar.dart';
import '../../../../../ui/onboarding_screen.dart';
import '../../../../../ui/profile_image_picker/pick_profile_picture.dart';
import '../../../../../ui/text_field.dart';
import '../../../../../ui/theme.dart';
import '../../../ui/back_button.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({
    super.key,
    required this.onSubmitted,
    required this.onBackButtonPressed,
  });

  final void Function(String value, File? photo) onSubmitted;
  final VoidCallback onBackButtonPressed;

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final _controller = TextEditingController();
  File? _photo;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSubmitted() => widget.onSubmitted(_controller.text, _photo);

  bool get _isValid => _controller.text.isNotEmpty;

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
            ],
          ),
        ),
      );
}

const keyCreateProfileName = Key('createProfileName');
