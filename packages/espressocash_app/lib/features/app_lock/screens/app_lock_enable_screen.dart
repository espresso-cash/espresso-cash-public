import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/back_button.dart';
import '../../../ui/decorated_window/decorated_window.dart';
import '../services/app_lock_bloc.dart';
import '../widgets/pin_input_display_widget.dart';

class AppLockEnableScreen extends StatefulWidget {
  const AppLockEnableScreen({super.key});

  static void push(BuildContext context) => Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => const AppLockEnableScreen(),
        ),
      );

  @override
  State<AppLockEnableScreen> createState() => _AppLockEnableScreenState();
}

class _AppLockEnableScreenState extends State<AppLockEnableScreen> {
  String? _firstPass;
  String? _secondPass;

  void _handleComplete(String value) {
    if (_firstPass == null) {
      setState(() => _firstPass = value);
    } else {
      setState(() => _secondPass = value);
      if (_firstPass == _secondPass) {
        // ignore: avoid-non-null-assertion, cannot be null here
        context.read<AppLockBloc>().add(AppLockEvent.enable(_firstPass!));
        Navigator.pop(context);
      }
    }
  }

  String get _instructions => _firstPass == null
      ? context.l10n.enterPasscode
      : context.l10n.reEnterPasscode;

  @override
  Widget build(BuildContext context) => DecoratedWindow(
        backButton: const CpBackButton(),
        hasLogo: true,
        backgroundStyle: BackgroundStyle.dark,
        child: PinInputDisplayWidget(
          message: _instructions,
          onCompleted: _handleComplete,
        ),
      );
}
