import 'package:cryptoplease/app/components/share_message_wrapper.dart';
import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/features/incoming_split_key_payment/bl/models.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/get_first_link.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/repository.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
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
  Uri _firstLink = Uri();

  static const _newLine = TextSpan(text: '\n\n');

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

  InlineSpan _buildHeader(String amount) =>
      widget.transfer.tokenType != OutgoingTransferTokenType.fungibleToken
          ? TextSpan(text: context.l10n.shareIntroNft)
          : TextSpan(
              text: context.l10n.shareIntroFt,
              children: [
                TextSpan(
                  text: amount,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            );

  InlineSpan _buildInstructions() => TextSpan(
        children: [
          _newLine,
          TextSpan(text: context.l10n.shareInstructions),
          _newLine,
        ],
      );

  InlineSpan _buildLinks(Uri firstLink, Uri secondLink) => TextSpan(
        children: [
          TextSpan(text: context.l10n.shareStep1),
          _newLine,
          TextSpan(text: firstLink.toString(), style: _linkStyle),
          _newLine,
          TextSpan(text: context.l10n.shareStep2),
          _newLine,
          TextSpan(text: secondLink.toString(), style: _linkStyle),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final amount = widget.transfer.toAmount().formatWithFiat(context);
    final firstLink = _firstLink;
    final secondLink = buildSecondLink(widget.transfer.privateKey);
    final message = context.l10n.shareText(amount, firstLink, secondLink);

    return CpTheme.dark(
      child: Scaffold(
        appBar: CpAppBar(
          title: Text(
            context.l10n.yourLinkIsReady.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 17,
            ),
          ),
        ),
        body: CpContentPadding(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  context.l10n.linkSubtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
              Flexible(
                child: ShareMessageWrapper(
                  textSpan: TextSpan(
                    children: [
                      _buildHeader(amount),
                      _buildInstructions(),
                      _buildLinks(firstLink, secondLink),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              CpButton(
                text: context.l10n.shareLink,
                width: double.infinity,
                size: CpButtonSize.big,
                onPressed:
                    _firstLink.hasScheme ? () => Share.share(message) : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const _linkStyle = TextStyle(
  fontWeight: FontWeight.w600,
  color: CpColors.linkColor,
);
