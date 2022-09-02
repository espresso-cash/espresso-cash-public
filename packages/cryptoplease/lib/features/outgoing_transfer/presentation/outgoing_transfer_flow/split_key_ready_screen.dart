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

  TextSpan _buildHeader() =>
      widget.transfer.tokenType == OutgoingTransferTokenType.fungibleToken
          ? const TextSpan(text: 'NFT')
          : TextSpan(
              text: '',
              children: [
                TextSpan(
                  text: widget.transfer.toAmount().formatWithFiat(context),
                ),
              ],
            );

  TextSpan _buildLinks() => TextSpan(
        children: [
          const TextSpan(text: 'Step 1 - Click on the first link:'),
          TextSpan(text: _firstLink.toString()),
          const TextSpan(
            text:
                'Step 2 - When the application asks you, click on the second link:',
          ),
          TextSpan(
            text: buildSecondLink(widget.transfer.privateKey).toString(),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          appBar: CpAppBar(
            title: Text(
              'Your link is ready'.toUpperCase(),
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
                    header: _buildHeader(),
                    links: _buildLinks(),
                  ),
                ),
                const SizedBox(height: 24),
                const CpButton(
                  text: 'Share payment links',
                  width: double.infinity,
                  size: CpButtonSize.big,
                ),
              ],
            ),
          ),
        ),
      );
}
