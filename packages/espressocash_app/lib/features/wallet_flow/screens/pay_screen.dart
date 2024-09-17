import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solana/solana.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/back_button.dart';
import '../../../ui/colors.dart';
import '../../../ui/onboarding_screen.dart';
import '../../../ui/theme.dart';
import '../../blockchain/models/blockchain.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
import '../../outgoing_direct_payments/screens/odp_confirmation_screen.dart';
import '../../outgoing_direct_payments/screens/odp_details_screen.dart';
import '../../outgoing_direct_payments/screens/odp_input_screen.dart';
import '../../outgoing_direct_payments/widgets/extensions.dart';
import '../../outgoing_dln_payments/screens/confirmation_screen.dart';
import '../../outgoing_link_payments/screens/olp_confirmation_screen.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({
    super.key,
    required this.amount,
  });

  static void push(BuildContext context, {required CryptoAmount amount}) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => PayScreen(amount: amount),
        ),
      );

  final CryptoAmount amount;

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  void _handlePrimaryPressed() =>
      OLPConfirmationScreen.push(context, tokenAmount: widget.amount);

  void _handleSecondaryPressed() {
    ODPInputScreen.push(
      context,
      onSubmit: (Blockchain network, String address) async {
        if (network == Blockchain.solana) {
          final formatted =
              widget.amount.format(context.locale, skipSymbol: true);

          final recipient = Ed25519HDPublicKey.fromBase58(address);

          final confirmedFiatAmount = await ODPConfirmationScreen.push(
            context,
            initialAmount: formatted,
            recipient: recipient,
            label: null,
            token: widget.amount.token,
            isEnabled: false,
          );

          if (confirmedFiatAmount == null) return;
          if (!mounted) return;

          final confirmedCryptoAmount = widget.amount.decimal;

          if (!mounted) return;
          final id = await context.createODP(
            amountInUsdc: confirmedCryptoAmount,
            receiver: recipient,
            reference: null,
          );

          if (!mounted) return;

          ODPDetailsScreen.open(context, id: id);
        } else {
          OutgoingDlnPaymentConfirmationScreen.push(
            context,
            amount: widget.amount,
            blockchain: network,
            receiverAddress: address,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          appBar: CpAppBar(
            leading: const CpBackButton(),
            title:
                Text(context.l10n.walletTransactionMethodTitle.toUpperCase()),
          ),
          body: OnboardingScreen(
            children: [
              SizedBox(height: 10.h),
              Assets.images.sendMoney.image(height: 90.h),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 42.w),
                child: MarkdownBody(
                  data: context.l10n.walletEspressoPayLabel.toUpperCase(),
                  styleSheet: MarkdownStyleSheet(
                    em: _markdownStyle.copyWith(color: CpColors.yellowColor),
                    p: _markdownStyle,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 42.w),
                child: Text(
                  context.l10n.walletEspressoPayDescription,
                  style: TextStyle(
                    fontSize: 16.sp,
                    height: 21 / 16,
                    letterSpacing: 0.23,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              _Item(
                title: context.l10n.linkMethodText,
                onPressed: _handlePrimaryPressed,
                icon: Assets.icons.subtract,
                subtitleIcons: [
                  Assets.icons.telegram,
                  Assets.icons.whatsapp,
                  Assets.icons.messanger,
                  Assets.icons.sms,
                  Assets.icons.snapchat,
                  Assets.icons.wechat,
                  Assets.icons.signal,
                  Assets.icons.qr,
                ],
              ),
              SizedBox(height: 20.h),
              _Item(
                title: context.l10n.addressMethodText,
                onPressed: _handleSecondaryPressed,
                icon: Assets.icons.walletAddress,
                subtitleIcons: [
                  Assets.icons.solanaIcon,
                  Assets.icons.ethereumIcon,
                  Assets.icons.polygonIcon,
                  Assets.icons.arbitrumIcon,
                ],
              ),
            ],
          ),
        ),
      );
}

class _Item extends StatelessWidget {
  const _Item({
    required this.title,
    required this.onPressed,
    required this.icon,
    required this.subtitleIcons,
  });

  final String title;
  final SvgGenImage icon;
  final List<SvgGenImage> subtitleIcons;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(
          vertical: 6.h,
          horizontal: 18.w,
        ),
        child: DecoratedBox(
          decoration: ShapeDecoration(
            color: CpColors.darkBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30.r),
              ),
            ),
          ),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30.r),
              ),
            ),
            leading: Container(
              alignment: Alignment.center,
              width: 40.w,
              child: icon.svg(),
            ),
            minLeadingWidth: 40.w,
            contentPadding: EdgeInsets.only(
              left: 20.w,
              top: 10.h,
              bottom: 10.h,
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.sp,
                  height: 21 / 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            subtitle: Row(
              children: [
                for (final icon in subtitleIcons) ...[
                  icon.svg(width: 30.w),
                  SizedBox(width: 5.w),
                ],
              ],
            ),
            onTap: onPressed,
          ),
        ),
      );
}

final _markdownStyle = TextStyle(
  fontStyle: FontStyle.normal,
  fontSize: 32.sp,
  fontWeight: FontWeight.w900,
  letterSpacing: 0.25,
  height: 1,
);
