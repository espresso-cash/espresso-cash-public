import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/bl/transactions/create_transaction_link.dart';
import 'package:cryptoplease/bl/transactions/details/transaction_details_bloc.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/authenticated/transaction_details_screen/components/instruction_details_item.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:solana/dto.dart' hide TransactionStatus;
import 'package:url_launcher/url_launcher.dart';

class TransactionDetails extends StatelessWidget {
  const TransactionDetails({
    Key? key,
    required this.instructions,
    required this.token,
    required this.status,
    required this.dateTime,
    required this.signature,
  }) : super(key: key);

  final List<ParsedInstruction> instructions;
  final Token token;
  final TransactionStatus status;
  final DateTime? dateTime;
  final String signature;

  Future<void> _openBlockExplorer() => launch(createTransactionLink(signature));

  @override
  Widget build(BuildContext context) => CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, index) => InstructionDetailsItem(
                instruction: instructions[index],
                token: token,
                dateTime: dateTime,
                status: status,
              ),
              childCount: instructions.length,
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: CpButton(
                  text: context.l10n.viewOnBlockExplorer,
                  onPressed: _openBlockExplorer,
                ),
              ),
            ),
          ),
        ],
      );
}
