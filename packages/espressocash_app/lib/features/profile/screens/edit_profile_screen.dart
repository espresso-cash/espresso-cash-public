// ignore_for_file: unnecessary_const

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../ui/app_bar.dart';
import '../../../../../ui/back_button.dart';
import '../../../../../ui/loader.dart';
import '../../../../../ui/onboarding_screen.dart';
import '../../../../../ui/profile_image_picker/pick_profile_picture.dart';
import '../../../../../ui/text_field.dart';
import '../../../../../ui/theme.dart';
import '../../../routes.gr.dart';
import '../../../ui/colors.dart';
import '../../accounts/services/accounts_bloc.dart';

@RoutePage()
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _countryCodeController = TextEditingController();
  File? _photo;

  @override
  void initState() {
    super.initState();
    final state = context.read<AccountsBloc>().state;
    final profile = state.account?.profile;

    final photoPath = profile?.photoPath;
    _nameController.text = profile?.firstName ?? '';
    if (photoPath != null) {
      _photo = File(photoPath);
    }

    final countryCode = profile?.country;
    if (countryCode != null) {
      _countryCodeController.text = countryCode;
    }
  }

  void _updateProfile() {
    context.read<AccountsBloc>().add(
          ProfileUpdated(
            name: _nameController.text,
            photo: _photo,
            country: _countryCodeController.text,
          ),
        );
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

  void _closeFlow() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _countryCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AccountsBloc>().state.isProcessing;

    return BlocListener<AccountsBloc, AccountsState>(
      listenWhen: (s1, s2) => s1.isProcessing && !s2.isProcessing,
      listener: (context, state) => _closeFlow(),
      child: CpLoader(
        isLoading: isLoading,
        child: CpTheme.dark(
          child: Scaffold(
            body: OnboardingScreen(
              footer: OnboardingFooterButton(
                text: context.l10n.save,
                onPressed: _updateProfile,
              ),
              children: [
                CpAppBar(
                  leading: CpBackButton(onPressed: _closeFlow),
                ),
                ProfileImagePicker(
                  onChanged: (photo) => setState(() {
                    _photo = photo;
                  }),
                  onLabelClicked: _photo == null
                      ? null
                      : () => setState(() => _photo = null),
                  label: _photo == null
                      ? context.l10n.uploadPhoto
                      : context.l10n.removePhoto,
                  labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                  photo: _photo,
                ),
                const SizedBox(height: 32),
                OnboardingPadding(
                  child: CpTextField(
                    margin: const EdgeInsets.only(top: 16),
                    placeholder: context.l10n.yourFirstNamePlaceholder,
                    controller: _nameController,
                    disabled: isLoading,
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
                          child: const Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                        readOnly: true,
                        disabled: isLoading,
                        textColor: Colors.white,
                        controller: _countryCodeController,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
