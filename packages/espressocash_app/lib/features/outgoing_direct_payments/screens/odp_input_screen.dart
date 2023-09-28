import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../routes.gr.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/bottom_button.dart';
import '../../../ui/icon_button.dart';
import '../../../ui/text_field.dart';
import '../../../ui/theme.dart';
import '../../network_picker/models/network.dart';
import '../../wallet_flow/screens/pay_flow_screen.dart';

@RoutePage()
class ODPInputScreen extends StatefulWidget {
  const ODPInputScreen({super.key});

  static const route = ODPInputRoute.new;

  @override
  State<ODPInputScreen> createState() => _ODPInputScreenState();
}

class _ODPInputScreenState extends State<ODPInputScreen> {
  final Network _selectedNetwork = networks.first;

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          appBar: CpAppBar(
            title: Text('SEND TO A WALLET ADDRESS'.toUpperCase()),
          ),
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  PayItem(
                    title: 'Networks',
                    buttonText: _selectedNetwork.name,
                    onPressed: () {},
                    buttonTrailing: const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),
                  const _Item(
                    title: 'Wallet Address',
                  ),
                  const Spacer(),
                  CpBottomButton(
                    text: 'Next',
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
        ),
      );
}

class _Item extends StatelessWidget {
  const _Item({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 12),
            CpTextField(
              controller: TextEditingController(),
              placeholder: 'Type, Paste or Scan Address Here',
              backgroundColor: const Color(0xFF4D4B4C),
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 18,
              ),
              textColor: Colors.white,
              fontSize: 16,
              suffix: Padding(
                padding: const EdgeInsets.only(right: 24),
                child: CpIconButton(
                  onPressed: () {},
                  icon: Assets.icons.qrScanner.svg(color: Colors.white),
                  variant: CpIconButtonVariant.black,
                ),
              ),
            ),
          ],
        ),
      );
}
