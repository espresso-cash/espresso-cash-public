import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/rounded_rectangle.dart';
import '../../../ui/snackbar.dart';
import '../../core/landing_widget.dart';

class DesktopView extends StatelessWidget {
  const DesktopView({
    super.key,
    required this.actionLink,
    required this.title,
    required this.amount,
  });

  final Uri actionLink;
  final String title;
  final String amount;

  @override
  Widget build(BuildContext context) {
    const dummy = 'BM9fRNKQe6egw5DxVfptgwzACscbqLPPeEJytKRzWpTe';

    return LandingScreenWidget(
      children: [
        const SizedBox(height: 32),
        Assets.images.logoDark.image(height: 62),
        const SizedBox(height: 48),
        Text(
          context.l10n.landingPaymentRequestTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.23,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '$amount USDC',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 41,
            fontWeight: FontWeight.w700,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 48),
        // CpButton(
        //   text: context.l10n.landingRequestPayEspressoButton,
        //   size: CpButtonSize.big,
        //   width: 350,
        //   trailing: const Arrow(),
        //   onPressed: () {},
        // ),
        // const Padding(
        //   padding: EdgeInsets.symmetric(vertical: 16.0),
        //   child: DividerWidget(),
        // ),
        // CpButton(
        //   text: context.l10n.landingRequestPayOtherWalletButton,
        //   size: CpButtonSize.big,
        //   variant: CpButtonVariant.black,
        //   width: 350,
        //   trailing: const Arrow(color: Colors.white),
        //   onPressed: () {},
        // ),
        Text(
          context.l10n.landingRequestPaymentMethod,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        CpButton(
          text: 'With USDC on Ethereum',
          size: CpButtonSize.big,
          variant: CpButtonVariant.black,
          width: 280,
          trailing: const Icon(
            Icons.keyboard_arrow_down_outlined,
            color: Colors.white,
            size: 24,
          ),
          onPressed: () {},
        ),
        const SizedBox(height: 32),
        Text(
          context.l10n.landingRequestDestinationAddress,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        const _DestinationWidget(destinationAddress: dummy),
        const SizedBox(height: 16),
        Text(
          context.l10n.landingRequestNetworkFee('1 USDC'),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          context.l10n.landingRequestTotalAmount('10 USDC'),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.23,
          ),
        ),
      ],
    );
  }
}

class _DestinationWidget extends StatelessWidget {
  const _DestinationWidget({
    required this.destinationAddress,
  });

  final String destinationAddress;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 410,
        height: 145,
        child: CpRoundedRectangle(
          padding: const EdgeInsets.all(24),
          backgroundColor: Colors.black,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: BarcodeWidget(
                  width: 100,
                  height: 100,
                  barcode: Barcode.qrCode(),
                  data: destinationAddress,
                  padding: EdgeInsets.zero,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      destinationAddress,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CpButton(
                        text: context.l10n.copy,
                        minWidth: 80,
                        onPressed: () {
                          final data = ClipboardData(text: destinationAddress);
                          Clipboard.setData(data);
                          showClipboardSnackbar(context);
                        },
                        size: CpButtonSize.micro,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
