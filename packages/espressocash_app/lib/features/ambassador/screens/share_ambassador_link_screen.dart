import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/bottom_button.dart';
import '../../../ui/button.dart';
import '../../../ui/rounded_rectangle.dart';
import '../../../ui/theme.dart';
import '../../../utils/routing.dart';
import '../../accounts/models/ec_wallet.dart';
import '../models/ambassador_referral.dart';

class ShareAmbassadorLinkScreen extends StatefulWidget {
  const ShareAmbassadorLinkScreen({super.key});

  static void push(BuildContext context) => Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => const ShareAmbassadorLinkScreen(),
        ),
      );

  @override
  State<ShareAmbassadorLinkScreen> createState() =>
      _ShareAmbassadorLinkScreenState();
}

class _ShareAmbassadorLinkScreenState extends State<ShareAmbassadorLinkScreen> {
  late final Uri _uri;

  @override
  void initState() {
    super.initState();

    final wallet = sl<ECWallet>().publicKey;

    final referral = AmbassadorReferral(address: wallet);
    _uri = referral.toLink();
  }

  @override
  Widget build(BuildContext context) {
    const title = Text(
      'Ambassador Link',
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
    );

    const message = 'Share Your Ambassador Link';

    return CpTheme.black(
      child: Scaffold(
        appBar: const CpAppBar(title: title),
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: CpRoundedRectangle(
                  backgroundColor: Colors.black,
                  scrollable: false,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 35),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: message,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: BarcodeWidget(
                          height: 250,
                          barcode: Barcode.qrCode(),
                          data: _uri.toString(),
                          padding: EdgeInsets.zero,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              CpBottomButton(
                variant: CpButtonVariant.grey,
                text: context.l10n.done,
                onPressed: () => context.openFirstScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
