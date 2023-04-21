import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';

import '../../../core/extensions.dart';
import '../../../di.dart';
import 'bl/sign_in_bloc.dart';

extension SignUpExt on BuildContext {
  Future<void> createWallet() async {
    final hasSeedVault = await sl<SeedVault>().isReady();

    if (!mounted) return;

    final event = hasSeedVault
        ? const SignInEvent.newSagaWalletRequested()
        : const SignInEvent.newLocalWalletRequested();

    read<SignInBloc>().add(event);
  }
}
