import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/bullet_item.dart';
import '../../../../ui/button.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/theme.dart';
import '../../../qr_scanner/models/qr_scanner_request.dart';
import '../../widgets/extensions.dart';
import 'components/terms_disclaimer.dart';

class FirstPartQrScreen extends StatefulWidget {
  const FirstPartQrScreen({super.key});

  @override
  State<FirstPartQrScreen> createState() => _FirstPartQrScreenState();
}

class _FirstPartQrScreenState extends State<FirstPartQrScreen> {
  Future<void> _onQrScanner() async {
    final request =
        await context.router.push<QrScannerRequest>(const QrScannerRoute());

    if (request == null) return;
    if (!mounted) return;

    if (request is QrScannerPaymentRequest) {
      final id = await context.createISLP(
        first: request.firstPart,
        second: request.secondPart,
      );

      if (!mounted) return;
      await context.router.push(IncomingSingleLinkRoute(id: id));
    }
  }

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          backgroundColor: const Color(0xff2D2B2C),
          body: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Assets.icons.logoDark.svg(
                  alignment: Alignment.bottomCenter,
                ),
              ),
              SafeArea(
                top: false,
                child: LayoutBuilder(
                  builder: (context, constraints) => SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: constraints.copyWith(
                        minHeight: constraints.maxHeight,
                        maxHeight: double.infinity,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            const _Header(),
                            const _Body(),
                            Expanded(
                              child: _Footer(
                                onScan: _onQrScanner,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          children: [
            Assets.images.logo.image(height: 110, width: 210),
          ],
        ),
      );
}

class _Footer extends StatelessWidget {
  const _Footer({Key? key, required this.onScan}) : super(key: key);
  final VoidCallback onScan;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CpButton(
              text: 'Open in-app QR Scanner',
              width: double.infinity,
              onPressed: onScan,
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TermsDisclaimer(),
            ),
            const SizedBox(height: 24),
          ],
        ),
      );
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 36, right: 36, top: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'MONEY',
              style: TextStyle(
                color: CpColors.yellowDarkAccentColor,
                fontWeight: FontWeight.w900,
                fontSize: 50,
                height: 0.9,
              ),
            ),
            const Text(
              'IS WAITING FOR YOU.',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 50,
                height: 0.9,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Assets.icons.qrScanner.svg(height: 36),
                const SizedBox(width: 16),
                const Expanded(
                  child: CpBulletItemWidget(
                    text:
                        'For security reasons, please scan the senders QR code using the in-app scanner.',
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
