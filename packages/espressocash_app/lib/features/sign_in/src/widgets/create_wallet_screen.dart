import 'package:flutter/material.dart';

import '../../../../ui/splash_screen.dart';
import '../extensions.dart';

class CreateWalletLoadingScreen extends StatefulWidget {
  const CreateWalletLoadingScreen({super.key});

  @override
  State<CreateWalletLoadingScreen> createState() =>
      _CreateWalletLoadingScreenState();
}

class _CreateWalletLoadingScreenState extends State<CreateWalletLoadingScreen> {
  @override
  void initState() {
    super.initState();
    context.createWallet();
  }

  @override
  Widget build(BuildContext context) => const SplashScreen();
}
