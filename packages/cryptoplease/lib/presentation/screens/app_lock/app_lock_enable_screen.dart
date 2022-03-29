import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/decorated_window.dart';
import 'package:cryptoplease/presentation/screens/app_lock/app_lock_setup_flow_screen.dart';
import 'package:cryptoplease/presentation/screens/app_lock/components/pin_input_display_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppLockEnableScreen extends StatefulWidget {
  const AppLockEnableScreen({Key? key}) : super(key: key);

  @override
  State<AppLockEnableScreen> createState() => _AppLockEnableScreenState();
}

class _AppLockEnableScreenState extends State<AppLockEnableScreen> {
  String? _firstPass;
  String? _secondPass;

  void _onComplete(String value) {
    if (_firstPass == null) {
      setState(() => _firstPass = value);
    } else {
      setState(() => _secondPass = value);
      if (_firstPass == _secondPass) {
        context.read<AppLockSetupRouter>().onEnableFinished(_firstPass!);
      }
    }
  }

  String get _instructions {
    if (_firstPass == null) {
      return context.l10n.enterPasscode;
    }

    return context.l10n.reEnterPasscode;
  }

  @override
  Widget build(BuildContext context) => DecoratedWindow(
        hasLogo: true,
        backgroundStyle: BackgroundStyle.dark,
        child: PinInputDisplayWidget(
          message: _instructions,
          onCompleted: _onComplete,
        ),
      );
}
