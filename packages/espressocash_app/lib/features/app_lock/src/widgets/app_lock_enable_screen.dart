import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/l10n.dart';
import '../../../../ui/back_button.dart';
import '../../../../ui/decorated_window/decorated_window.dart';
import 'app_lock_setup_flow_screen.dart';
import 'components/local_auth_wrapper.dart';
import 'components/pin_input_display_widget.dart';

@RoutePage()
class AppLockEnableScreen extends StatefulWidget {
  const AppLockEnableScreen({super.key});

  @override
  State<AppLockEnableScreen> createState() => _AppLockEnableScreenState();
}

class _AppLockEnableScreenState extends State<AppLockEnableScreen> {
  String? _firstPass;
  String? _secondPass;
  bool _askForBiometrics = false;

  void _onComplete(String value) {
    if (_firstPass == null) {
      setState(() => _firstPass = value);
    } else {
      setState(() => _secondPass = value);
      if (_firstPass == _secondPass) {
        setState(() => _askForBiometrics = true);
      }
    }
  }

  String get _instructions => _firstPass == null
      ? context.l10n.enterPasscode
      : context.l10n.reEnterPasscode;

  void _finish() {
    final passCode = _firstPass;
    if (passCode != null && _secondPass != null && passCode == _secondPass) {
      context.read<AppLockSetupRouter>().onEnableFinished(passCode);
    }
  }

  @override
  Widget build(BuildContext context) => DecoratedWindow(
        backButton: CpBackButton(
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
