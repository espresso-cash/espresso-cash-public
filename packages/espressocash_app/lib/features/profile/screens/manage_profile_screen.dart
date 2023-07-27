import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../ui/app_bar.dart';
import '../../../../../ui/onboarding_screen.dart';
import '../../../../../ui/text_field.dart';
import '../../../../../ui/theme.dart';
import '../../../core/file_manager.dart';
import '../../../di.dart';
import '../../../routes.gr.dart';
import '../../../ui/back_button.dart';
import '../../../ui/colors.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/loader.dart';
import '../data/profile_repository.dart';
import '../models/country.dart';
import '../models/profile.dart';
import '../widgets/pick_profile_picture.dart';
import 'country_picker_screen.dart';

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
  Country? _country;
  File? _photo;

  @override
  void initState() {
    super.initState();

    final profile = sl<ProfileRepository>().profile;

    _nameController
      ..addListener(() => setState(() {}))
      ..text = profile.firstName;

    _photo = profile.photoPath?.let(File.new);

    final country = profile.country;
    if (country != null) {
      _country = Country.findByCode(country);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _handleCountryPressed() => context.router.push<Country>(
        CountryPickerScreen.route(
          initial: _country,
          onSubmitted: (country) {
            context.router.pop();
            setState(() => _country = country);
          },
        ),
      );

  void _handleSubmitted() => runWithLoader(context, () async {
        try {
          final photo = await _photo?.let(sl<FileManager>().copyToAppDir);

          sl<ProfileRepository>().profile = Profile(
            firstName: _nameController.text,
            country: _country?.code,
            photoPath: photo?.path,
          );

          if (!mounted) return;

          widget.onSubmitted();
        } on Exception catch (e) {
          if (!mounted) return;

          showErrorDialog(context, 'Error', e);
        }
      });

  bool get _isValid => _nameController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          body: OnboardingScreen(
            footer: OnboardingFooterButton(
              text: context.l10n.save,
              onPressed: _isValid ? _handleSubmitted : null,
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
                  backgroundColor: Colors.white,
                ),
              ),
              _CountryPickerItem(
                country: _country,
                onTap: _handleCountryPressed,
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
