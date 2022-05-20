import 'dart:io';

import 'package:cryptoplease/bl/sign_up/sign_up_bloc.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/onboarding_screen.dart';
import 'package:cryptoplease/presentation/dialogs.dart';
import 'package:cryptoplease/presentation/screens/sign_up/elements/pick_profile_picture.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateProfileScreen extends StatelessWidget {
  const CreateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) => state.processingState.maybeWhen(
          error: (e) => showErrorDialog(context, 'Error', e),
          orElse: ignore,
        ),
        builder: (context, state) => CpLoader(
          isLoading: state.processingState.isProcessing,
          child: EnterFirstName(
            onSubmitted: (name, photo) async {
              context
                  .read<SignUpBloc>()
                  .add(SignUpEvent.submitted(name: name, photo: photo));
            },
            onBackButtonPressed: () => Navigator.of(context).pop(),
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

  void _onSubmitted() => widget.onSubmitted(_controller.text, _photo);

  bool get _isValid => _controller.text.isNotEmpty;

  @override
  Widget build(BuildContext context) => OnboardingScreen(
        onNextPressed: _isValid ? _onSubmitted : null,
        nextLabel: context.l10n.next,
        child: Column(
          children: [
            PickProfilePicture(
              photo: _photo,
              label: context.l10n.uploadPhoto,
              onChanged: (File? value) => setState(() {
                _photo = value;
              }),
            ),
            const SizedBox(height: 32),
            CpTextField(
              key: keyCreateProfileName,
              margin: const EdgeInsets.only(top: 16),
              placeholder: context.l10n.yourFirstNamePlaceholder,
              controller: _controller,
              backgroundColor: Colors.white,
            ),
          ],
        ),
      );
}

const keyCreateProfileName = Key('createProfileName');
