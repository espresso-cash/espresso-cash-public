import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

import '../../../../../l10n/l10n.dart';
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

    final preference = context.read<LocalAuthRepository>().localAuthPreference;

    final authenticated = await preference.when(
      disabled: () async => false,
      neverAsked: _authenticate,
      enabled: _authenticate,
    );

    await preference.whenOrNull(
      neverAsked: () async {
        if (!mounted) return;
        await context.read<LocalAuthRepository>().savePreference(authenticated);
      },
    );

    if (authenticated) {
      widget.onLocalAuthComplete();
    } else {
      widget.onLocalAuthFailed?.call();
    }
  }

  Future<bool> _authenticate() async => tryEitherAsync((_) async {
        final localAuth = LocalAuthentication();

        if (!await localAuth.isDeviceSupported() ||
            !await localAuth.canCheckBiometrics) return false;

        await localAuth.stopAuthentication();

        if (!mounted) return false;

        return localAuth.authenticate(
          localizedReason: context.l10n.localAuthReason,
        );
      }).foldAsync(F, identity);

  @override
  Widget build(BuildContext context) => widget.child;
}
