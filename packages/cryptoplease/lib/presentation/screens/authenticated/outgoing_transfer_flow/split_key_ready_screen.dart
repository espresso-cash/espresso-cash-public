import 'package:cryptoplease/bl/currency.dart';
import 'package:cryptoplease/bl/outgoing_transfers/get_first_link.dart';
import 'package:cryptoplease/bl/outgoing_transfers/outgoing_payment.dart';
import 'package:cryptoplease/bl/outgoing_transfers/repository.dart';
import 'package:cryptoplease/bl/split_key_payments/models.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/bl/tokens/token_list.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/decorated_window.dart';
import 'package:cryptoplease/presentation/conversion_rates.dart';
import 'package:cryptoplease/presentation/format_amount.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class SplitKeyReadyScreen extends StatefulWidget {
  const SplitKeyReadyScreen({
    Key? key,
    required this.transfer,
  }) : super(key: key);

  final OutgoingTransferSplitKey transfer;

  @override
  State<SplitKeyReadyScreen> createState() => _SplitKeyReadyScreenState();
}

class _SplitKeyReadyScreenState extends State<SplitKeyReadyScreen> {
  final _scrollController = ScrollController();
  Uri _firstLink = Uri();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    getFirstLink(
      widget.transfer,
      repository: context.read<OutgoingTransferRepository>(),
    ).then((firstLink) {
      if (!mounted) return;
      setState(() => _firstLink = firstLink);
    });
  }

  String get _message {
    final token = TokenList().findTokenByMint(widget.transfer.tokenAddress) ??
        UnknownToken(address: widget.transfer.tokenAddress);
    final fiatAmount = context.convertToFiat(
      amount: widget.transfer.amount,
      token: token,
      fiatCurrency: Currency.usd,
    );
    final fiatAmountString = fiatAmount == null
        ? ''
        : ' (${fiatAmount.format(DeviceLocale.localeOf(context))})';

    final amount =
        widget.transfer.toAmount().format(DeviceLocale.localeOf(context)) +
            fiatAmountString;

    return context.l10n.shareText(
      widget.transfer.tokenType == OutgoingTransferTokenType.fungibleToken
          ? amount
          : 'NFT',
      _firstLink,
      buildSecondLink(widget.transfer.privateKey),
    );
  }

  Future<void> _sharePendingScreen() async => Share.share(_message);

  @override
  Widget build(BuildContext context) => DecoratedWindow(
        backgroundStyle: BackgroundStyle.gradient,
        title: context.l10n.linkCreated,
        message: context.l10n.linkSubtitle,
        isScrollable: false,
        child: Flex(
          direction: Axis.vertical,
          children: [
            Flexible(
              child: Container(
                margin: const EdgeInsets.all(24),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 4,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: CupertinoScrollbar(
                  isAlwaysShown: true,
                  radius: const Radius.circular(10),
                  controller: _scrollController,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        _message,
                        style: const TextStyle(
                          fontSize: 18,
                          color: CpColors.primaryTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: CpButton(
                text: context.l10n.shareLink,
                onPressed: _firstLink.hasScheme ? _sharePendingScreen : null,
              ),
            ),
          ],
        ),
      );
}
