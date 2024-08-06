import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../ui/button.dart';
import '../../../ui/form_page.dart';
import '../../../ui/snackbar.dart';
import '../services/kyc_service.dart';

class ReadPermissionScreen extends StatelessWidget {
  const ReadPermissionScreen({super.key});

  static void push(BuildContext context) => Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => const ReadPermissionScreen(),
        ),
      );

  static void pushReplacement(BuildContext context) =>
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (context) => const ReadPermissionScreen(),
        ),
      );

  @override
  Widget build(BuildContext context) => FormPage(
        colorTheme: FormPageColorTheme.gold,
        title: Text('Partner permission'.toUpperCase()),
        header: const SizedBox(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              children: [
                const Spacer(),
                CpButton(
                  width: double.infinity,
                  text: 'Allow partner to read data',
                  onPressed: () async {
                    final service = sl<KycSharingService>();

                    await service.sendUserData();

                    if (context.mounted) {
                      showCpSnackbar(
                        context,
                        message: 'Success, partner can read data',
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
