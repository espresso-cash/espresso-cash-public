import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../ui/button.dart';
import '../../../ui/form_page.dart';
import '../../../ui/loader.dart';
import '../../../ui/snackbar.dart';
import '../service/recovery_service.dart';

class RecoverStellarScreen extends StatefulWidget {
  const RecoverStellarScreen({super.key, required this.onConfirmed});

  final VoidCallback onConfirmed;

  static void push(
    BuildContext context, {
    required VoidCallback onConfirmed,
  }) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => RecoverStellarScreen(
            onConfirmed: onConfirmed,
          ),
        ),
      );

  @override
  State<RecoverStellarScreen> createState() => _RecoverStellarScreenState();
}

class _RecoverStellarScreenState extends State<RecoverStellarScreen> {
  double _amount = 0.0;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _amount = sl<StellarRecoveryService>().stellarUsdcAmount ?? 0.0;
  }

  Future<void> _recover() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await sl<StellarRecoveryService>().recover();

      if (!mounted) return;

      showCpSnackbar(context, message: 'Success! USDC will be recovered soon');
      widget.onConfirmed();
    } on Exception {
      if (!mounted) return;

      showCpErrorSnackbar(context, message: 'Error. Please try again');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) => CpLoader(
        isLoading: _isLoading,
        child: FormPage(
          title: Text('Recover Stellar'.toUpperCase()),
          colorTheme: FormPageColorTheme.gold,
          header: FormPageHeader(
            title: const SizedBox.shrink(),
            description: const Text(
              'Stellar USDC Found',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            icon: Assets.images.identityGraphic,
          ),
          child: Column(
            children: [
              Text('${_amount.toStringAsFixed(2)} USDC'),
              CpButton(
                width: double.infinity,
                text: 'Recover',
                onPressed: _recover,
              ),
            ],
          ),
        ),
      );
}
