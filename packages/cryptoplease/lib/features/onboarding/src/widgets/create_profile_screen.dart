import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/l10n.dart';
import '../../../../ui/app_bar.dart';
import '../../../../ui/dialogs.dart';
import '../../../../ui/loader.dart';
import '../../../../ui/onboarding_screen.dart';
import '../../../../ui/profile_image_picker/pick_profile_picture.dart';
import '../../../../ui/text_field.dart';
import '../../../../ui/theme.dart';
import '../bl/onboarding_bloc.dart';

class CreateProfileScreen extends StatelessWidget {
  const CreateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<OnboardingBloc, OnboardingState>(
        listener: (context, state) => state.processingState.maybeWhen(
          error: (e) => showErrorDialog(context, 'Error', e),
          orElse: ignore,
        ),
        builder: (context, state) => CpLoader(
          isLoading: state.processingState.isProcessing,
          child: EnterFirstName(
            onSubmitted: (name, photo) async {
              context
                  .read<OnboardingBloc>()
                  .add(OnboardingEvent.submitted(name: name, photo: photo));
            },
            onBackButtonPressed: () => context.router.pop(),
          ),
        ),
      );
}

class EnterFirstName extends StatefulWidget {
  const EnterFirstName({
    Key? key,
    required this.onSubmitted,
    required this.onBackButtonPressed,
  }) : super(key: key);

  final void Function(String value, File? photo) onSubmitted;
  final VoidCallback onBackButtonPressed;

  @override
  State<EnterFirstName> createState() => _EnterFirstNameState();
}

class _EnterFirstNameState extends State<EnterFirstName> {
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
              CpAppBar(),
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
