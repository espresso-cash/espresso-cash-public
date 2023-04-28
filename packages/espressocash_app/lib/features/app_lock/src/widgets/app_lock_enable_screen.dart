import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/l10n.dart';
import '../../../../ui/decorated_window/decorated_window.dart';
import 'app_lock_setup_flow_screen.dart';
import 'components/local_auth_wrapper.dart';
import 'components/pin_input_display_widget.dart';

class AppLockEnableScreen extends StatefulWidget {
  const AppLockEnableScreen({Key? key}) : super(key: key);

  @override
  State<AppLockEnableScreen> createState() => _AppLockEnableScreenState();
}

class _AppLockEnableScreenState extends State<AppLockEnableScreen> {
  String? _firstPass;
  String? _secondPass;
  bool _askForBiometrics = false;

  Future<void> _onComplete(String value) async {
    if (_firstPass == null) {
      setState(() => _firstPass = value);
    } else {
      setState(() => _secondPass = value);
      if (_firstPass == _secondPass) {
        setState(() => _askForBiometrics = true);
      }
    }
  }

  String get _instructions {
    if (_firstPass == null) {
      return context.l10n.enterPasscode;
    }

    return context.l10n.reEnterPasscode;
  }

  void _finish() {
    context.read<AppLockSetupRouter>().onEnableFinished(
          // ignore: avoid-non-null-assertion, cannot be null here
          _firstPass!,
        );
  }

  @override
  Widget build(BuildContext context) => DecoratedWindow(
        backButton: BackButton(
          onPressed: () => context.read<AppLockSetupRouter>().closeFlow(),
        ),
        hasLogo: true,
        backgroundStyle: BackgroundStyle.dark,
        child: LocalAuthWrapper(
          shouldAskForLocalAuth: _askForBiometrics,
          onLocalAuthComplete: _finish,
          onLocalAuthFailed: _finish,
          child: PinInputDisplayWidget(
            message: _instructions,
            onCompleted: _onComplete,
          ),
        ),
      );
}
