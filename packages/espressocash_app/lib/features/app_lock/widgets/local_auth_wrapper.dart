import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../ui/dialogs.dart';
import '../services/local_auth_repository.dart';

class LocalAuthWrapper extends StatefulWidget {
  const LocalAuthWrapper({
    super.key,
    required this.onLocalAuthComplete,
    this.onLocalAuthFailed,
    this.shouldUseLocalAuth = true,
    required this.child,
  });

  final VoidCallback onLocalAuthComplete;
  final VoidCallback? onLocalAuthFailed;
  final bool shouldUseLocalAuth;
  final Widget child;

  @override
  State<LocalAuthWrapper> createState() => _LocalAuthWrapperState();
}

class _LocalAuthWrapperState extends State<LocalAuthWrapper> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _doLocalAuthenticate(),
    );
  }

  @override
  void didUpdateWidget(covariant LocalAuthWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shouldUseLocalAuth != oldWidget.shouldUseLocalAuth) {
      _doLocalAuthenticate();
    }
  }

  Future<void> _doLocalAuthenticate() async {
    if (!widget.shouldUseLocalAuth) return;

    final preference = context.read<LocalAuthRepository>().localAuthPreference;

    final authenticated = await preference.when(
      disabled: () async => false,
      enabled: () => _authenticate(false),
      neverAsked: () => _authenticate(true),
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

  Future<bool> _authenticate(bool askFirst) async => tryEitherAsync((_) async {
        final localAuth = LocalAuthentication();

        if (!await localAuth.isDeviceSupported() ||
            !await localAuth.canCheckBiometrics) return false;

        await localAuth.stopAuthentication();

        if (askFirst) {
          final shouldUseLocalAuth = await _askForLocalAuth();
          if (!shouldUseLocalAuth) return false;
        }

        if (!mounted) return false;

        return localAuth.authenticate(
          localizedReason: context.l10n.localAuthReason,
        );
      }).foldAsync(F, identity);

  Future<bool> _askForLocalAuth() async {
    final completer = Completer<bool>();

    await showConfirmationDialog(
      context,
      title: context.l10n.localAuthTitle,
      message: context.l10n.localAuthMessage,
      onConfirm: () => completer.complete(true),
    );

    if (!completer.isCompleted) completer.complete(false);

    return completer.future;
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
