import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';

import '../../../../di.dart';
import '../../../../saga.dart';
import '../../../../ui/splash_screen.dart';
import '../bl/sign_in_bloc.dart';

@RoutePage()
class CreateWalletLoadingScreen extends StatefulWidget {
  const CreateWalletLoadingScreen({super.key});

  @override
  State<CreateWalletLoadingScreen> createState() =>
      _CreateWalletLoadingScreenState();
}

class _CreateWalletLoadingScreenState extends State<CreateWalletLoadingScreen> {
  Future<void> _createWallet() async {
    SignInEvent event = const SignInEvent.newLocalWalletRequested();

    if (isSaga) {
      final hasPermission = await sl<SeedVault>().checkPermission();

      if (hasPermission) {
        event = const SignInEvent.existingSagaWalletRequested();
      }
    }

    if (!mounted) return;

    context.read<SignInBloc>().add(event);
  }

  @override
  void initState() {
    super.initState();
    _createWallet();
  }

  @override
  Widget build(BuildContext context) => const SplashScreen();
}
