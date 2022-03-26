import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/bl/transactions/details/transaction_details_bloc.dart';
import 'package:cryptoplease/presentation/screens/authenticated/transaction_details_screen/components/basic_transaction_information.dart';
import 'package:cryptoplease/presentation/screens/authenticated/transaction_details_screen/components/transfer_instruction_details.dart';
import 'package:cryptoplease/presentation/screens/authenticated/transaction_details_screen/dto/transfer_instruction_data.dart';
import 'package:flutter/widgets.dart';
import 'package:solana/dto.dart' hide TransactionStatus;

class SplTokenInstructionDetails extends StatelessWidget {
  const SplTokenInstructionDetails({
    Key? key,
    required this.instruction,
    required this.token,
    required this.dateTime,
    required this.status,
  }) : super(key: key);

  final ParsedInstructionSplToken instruction;
  final Token token;
  final TransactionStatus status;
  final DateTime? dateTime;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          BasicTransactionInformation(
            dateTime: dateTime,
            status: status,
          ),
          instruction.parsed.maybeMap(
            transfer: (t) => TransferInstructionDetails(
              data: TransferInstructionData.fromSplTransfer(
                info: t.info,
                status: status,
                dateTime: dateTime,
                token: token,
              ),
            ),
            transferChecked: (t) => TransferInstructionDetails(
              data: TransferInstructionData.fromSplTransferChecked(
                info: t.info,
                status: status,
                dateTime: dateTime,
                token: token,
              ),
            ),
            orElse: () => const SizedBox(),
          )
        ],
      );
}
