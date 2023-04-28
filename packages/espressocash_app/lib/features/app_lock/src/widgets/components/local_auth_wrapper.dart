import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../ui/button.dart';
import '../../bl/local_auth_repository.dart';

class LocalAuthWrapper extends StatefulWidget {
  const LocalAuthWrapper({
    Key? key,
    required this.onLocalAuthComplete,
    this.shouldAskForLocalAuth = true,
    this.onLocalAuthFailed,
    required this.child,
  }) : super(key: key);

  final VoidCallback onLocalAuthComplete;
  final VoidCallback? onLocalAuthFailed;
  final bool shouldAskForLocalAuth;
  final Widget child;

  @override
  State<LocalAuthWrapper> createState() => _LocalAuthWrapperState();
}

class _LocalAuthWrapperState extends State<LocalAuthWrapper> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _doLocalAuthenticate(widget.shouldAskForLocalAuth),
    );
  }

  @override
  void didUpdateWidget(covariant LocalAuthWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shouldAskForLocalAuth != oldWidget.shouldAskForLocalAuth) {
      _doLocalAuthenticate(widget.shouldAskForLocalAuth);
    }
  }

  Future<void> _doLocalAuthenticate(bool shouldAskForLocalAuth) async {
    if (!shouldAskForLocalAuth) return;

    final authenticated =
        await context.read<LocalAuthRepository>().askForBiometrics.when(
              disabled: () async => false,
              neverAsked: () => _authenticate(true),
              enabled: () => _authenticate(false),
            );

    if (!mounted) return;
    await context
        .read<LocalAuthRepository>()
        .saveBiometricsPreference(authenticated);

    if (authenticated) {
      widget.onLocalAuthComplete();
    } else {
      widget.onLocalAuthFailed?.call();
    }
  }

  Future<bool> _authenticate(bool firstRun) async => tryEitherAsync((_) async {
        final localAuth = LocalAuthentication();

        if (!await localAuth.isDeviceSupported() ||
            !await localAuth.canCheckBiometrics) return false;

        await localAuth.stopAuthentication();

        if (firstRun) {
          final shouldUse = await _askToUseBiometrics();
          if (!shouldUse) return false;
        }

        if (!mounted) return false;

        return localAuth.authenticate(
          localizedReason: context.l10n.enableLocalAuth,
        );
      }).foldAsync(F, identity);

  Future<bool> _askToUseBiometrics() async =>
      await showDialog<bool>(
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

  @override
  Widget build(BuildContext context) => widget.child;
}
