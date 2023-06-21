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
import '../../profile/models/country.dart';

typedef ProfileCallback = void Function(
  String name,
  File? photo,
  String countryCode,
);

class CreateProfile extends StatefulWidget {
  const CreateProfile({
    super.key,
    required this.onSubmitted,
    required this.onBackButtonPressed,
    this.initial,
  });

  final Profile? initial;
  final ProfileCallback onSubmitted;
  final VoidCallback onBackButtonPressed;

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final _nameController = TextEditingController();
  Country? _country;
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
        _country = Country.findByCode(country);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _onUpdateCountry() async {
    final code = await context.router.push<Country?>(
      CountryPickerRoute(initial: _country),
    );

    if (!mounted) return;

    if (code != null) {
      setState(() {
        _country = code;
      });
    }
  }

  void _handleSubmitted() => widget.onSubmitted.call(
        _nameController.text,
        _photo,
        _country?.code ?? '',
      );

  bool get _isValid => _nameController.text.isNotEmpty && _country != null;

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
              _CountryPickerItem(
                country: _country,
                onTap: _onUpdateCountry,
              ),
            ],
          ),
        ),
      );
}

class _CountryPickerItem extends StatelessWidget {
  const _CountryPickerItem({
    this.country,
    required this.onTap,
  });
  final Country? country;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => OnboardingPadding(
        child: Container(
          margin: const EdgeInsets.only(top: 16),
          // padding: const EdgeInsets.all(24),
          decoration: const ShapeDecoration(
            color: CpColors.darkBackground,
            shape: StadiumBorder(),
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            onTap: onTap,
            title: Text(
              country?.name ?? context.l10n.countryOfResidence,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 20,
                color: Colors.white,
                height: 1.2,
              ),
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_down_outlined,
              color: Colors.white,
              size: 34,
            ),
          ),
        ),
      );
}

const keyCreateProfileName = Key('createProfileName');
