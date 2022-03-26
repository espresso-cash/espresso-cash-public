import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/bl/transactions/details/transaction_details_bloc.dart';
import 'package:cryptoplease/presentation/screens/authenticated/transaction_details_screen/components/memo_instruction_details.dart';
import 'package:cryptoplease/presentation/screens/authenticated/transaction_details_screen/components/spl_token_instruction_details.dart';
import 'package:cryptoplease/presentation/screens/authenticated/transaction_details_screen/components/system_instruction_details.dart';
import 'package:flutter/widgets.dart';
import 'package:solana/dto.dart' hide TransactionStatus;

class InstructionDetailsItem extends StatelessWidget {
  const InstructionDetailsItem({
    Key? key,
    required this.instruction,
    required this.token,
    required this.status,
    required this.dateTime,
  }) : super(key: key);

  final ParsedInstruction instruction;
  final Token token;
  final TransactionStatus status;
  final DateTime? dateTime;

  @override
  Widget build(BuildContext context) => instruction.map(
        system: (i) => SystemInstructionDetails(
          instruction: i.parsed,
          status: status,
          dateTime: dateTime,
        ),
        splToken: (i) => SplTokenInstructionDetails(
          instruction: i,
          token: token,
          status: status,
          dateTime: dateTime,
        ),
        memo: (i) => MemoInstructionDetails(memo: i.memo),
        unsupported: (_) => const SizedBox(),
      );
}
