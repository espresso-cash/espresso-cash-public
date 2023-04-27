import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/l10n.dart';
import '../../../../ui/button.dart';
import '../../../../ui/decorated_window/decorated_window.dart';
import 'app_lock_setup_flow_screen.dart';
import 'components/pin_input_display_widget.dart';

class AppLockEnableScreen extends StatefulWidget {
  const AppLockEnableScreen({Key? key}) : super(key: key);

  @override
  State<AppLockEnableScreen> createState() => _AppLockEnableScreenState();
}

class _AppLockEnableScreenState extends State<AppLockEnableScreen> {
  String? _firstPass;
  String? _secondPass;

  Future<void> _onComplete(String value) async {
    if (_firstPass == null) {
      setState(() => _firstPass = value);
    } else {
      setState(() => _secondPass = value);
      if (_firstPass == _secondPass) {
        context.read<AppLockSetupRouter>().onEnableFinished(
              // ignore: avoid-non-null-assertion, cannot be null here
              _firstPass!,
              await _askToUseBiometricds(),
            );
      }
    }
  }

  Future<bool> _askToUseBiometricds() => tryEitherAsync((_) async {
        final localAuth = LocalAuthentication();

        if (!await localAuth.isDeviceSupported() ||
            !await localAuth.canCheckBiometrics) return false;

        if (mounted) {
          final shouldUse = await showDialog<bool>(
                context: context,
                builder: (context) => SimpleDialog(
                  title: const Text('Use biometrics?'),
                  children: [
                    CpButton(
                      text: 'Yes',
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                    CpButton(
                      text: 'No',
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                  ],
                ),
              ) ??
              false;

          if (!shouldUse) return false;
        }

        return localAuth.authenticate(localizedReason: 'test');
      }).foldAsync(F, identity);

  String get _instructions {
    if (_firstPass == null) {
      return context.l10n.enterPasscode;
    }

    return context.l10n.reEnterPasscode;
  }

  @override
  Widget build(BuildContext context) => DecoratedWindow(
        backButton: BackButton(
          onPressed: () => context.read<AppLockSetupRouter>().closeFlow(),
        ),
        hasLogo: true,
        backgroundStyle: BackgroundStyle.dark,
        child: PinInputDisplayWidget(
          message: _instructions,
          onCompleted: _onComplete,
        ),
      );
}
