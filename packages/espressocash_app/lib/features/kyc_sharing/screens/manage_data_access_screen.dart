import 'package:flutter/material.dart';

import '../../../ui/app_bar.dart';
import '../../../ui/colors.dart';
import '../../../ui/theme.dart';
import '../widgets/kyc_button.dart';

class ManageDataAccessScreen extends StatelessWidget {
  const ManageDataAccessScreen({super.key});

  static void push(BuildContext context) => Navigator.of(
    context,
  ).push<void>(MaterialPageRoute(builder: (context) => const ManageDataAccessScreen()));

  @override
  Widget build(BuildContext context) => CpTheme.dark(
    child: Scaffold(
      backgroundColor: CpColors.blackGreyColor,
      appBar: CpAppBar(title: Text('Manage Data Access'.toUpperCase())),
      body: const _Content(),
    ),
  );
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(
      top: 40,
      left: 40,
      right: 40,
      bottom: MediaQuery.paddingOf(context).bottom,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text('Network partners'.toUpperCase()),
        ),
        const Spacer(),
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          child: Material(
            color: CpColors.blackGreyColor,
            child: KycButton(
              label: 'Delete All Data',
              onPressed: () {},
              textColor: CpColors.dangerButtonTextColor,
              backgroundColor: CpColors.dangerButtonBackground,
              showIcon: false,
              centerText: true,
            ),
          ),
        ),
      ],
    ),
  );
}
