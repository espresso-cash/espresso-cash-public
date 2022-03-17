import 'dart:io';

import 'package:cryptoplease/bl/accounts/accounts_bloc.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/decorated_window.dart';
import 'package:cryptoplease/presentation/screens/sign_up/elements/pick_profile_picture.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _controller = TextEditingController();
  File? _photo;

  @override
  void initState() {
    super.initState();
    final state = context.read<AccountsBloc>().state;
    final photoPath = state.account?.photoPath;
    _controller.text = state.account?.firstName ?? '';
    if (photoPath != null) {
      _photo = File(photoPath);
    }
  }

  void _updateProfile() {
    context
        .read<AccountsBloc>()
        .add(ProfileUpdated(name: _controller.text, photo: _photo));
  }

  void _closeFlow() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AccountsBloc>().state.isProcessing;

    return BlocListener<AccountsBloc, AccountsState>(
      listenWhen: (s1, s2) => s1.isProcessing && !s2.isProcessing,
      listener: (context, state) => _closeFlow(),
      child: CpLoader(
        isLoading: isLoading,
        child: DecoratedWindow(
          backgroundStyle: BackgroundStyle.dark,
          bottomButton: CpBottomButton(
            text: context.l10n.save,
            onPressed: _updateProfile,
          ),
          backButton: BackButton(onPressed: _closeFlow),
          child: CpContentPadding(
            child: Column(
              children: [
                PickProfilePicture(
                  onChanged: (photo) => setState(() {
                    _photo = photo;
                  }),
                  onLabelClicked: _photo == null
                      ? null
                      : () => setState(() => _photo = null),
                  label: _photo == null
                      ? context.l10n.uploadPhoto
                      : context.l10n.removePhoto,
                  labelStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                  photo: _photo,
                ),
                const SizedBox(height: 32),
                CpTextField(
                  margin: const EdgeInsets.only(top: 16),
                  placeholder: context.l10n.yourFirstNamePlaceholder,
                  controller: _controller,
                  disabled: isLoading,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
