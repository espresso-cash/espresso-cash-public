import 'package:cryptoplease/bl/outgoing_transfers/get_first_link.dart';
import 'package:cryptoplease/bl/outgoing_transfers/outgoing_payment.dart';
import 'package:cryptoplease/bl/outgoing_transfers/repository.dart';
import 'package:cryptoplease/bl/split_key_payments/models.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/decorated_window.dart';
import 'package:cryptoplease/presentation/components/share_message_wrapper.dart';
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

  @override
  Widget build(BuildContext context) {
    final message = context.l10n.shareText(
      widget.transfer.tokenType == OutgoingTransferTokenType.fungibleToken
          ? widget.transfer.toAmount().formatWithFiat(context)
          : 'NFT',
      _firstLink,
      buildSecondLink(widget.transfer.privateKey),
    );

    return DecoratedWindow(
      backgroundStyle: BackgroundStyle.gradient,
      title: context.l10n.linkCreated,
      message: context.l10n.linkSubtitle,
      isScrollable: false,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Flexible(child: ShareMessageWrapper(message: message)),
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: CpButton(
              text: context.l10n.shareLink,
              onPressed:
                  _firstLink.hasScheme ? () => Share.share(message) : null,
            ),
          ),
        ],
      ),
    );
  }
}
