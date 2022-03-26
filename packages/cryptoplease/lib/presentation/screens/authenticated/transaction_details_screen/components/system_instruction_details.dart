import 'package:cryptoplease/bl/transactions/details/transaction_details_bloc.dart';
import 'package:cryptoplease/presentation/screens/authenticated/transaction_details_screen/components/basic_transaction_information.dart';
import 'package:cryptoplease/presentation/screens/authenticated/transaction_details_screen/components/transfer_instruction_details.dart';
import 'package:cryptoplease/presentation/screens/authenticated/transaction_details_screen/dto/transfer_instruction_data.dart';
import 'package:flutter/widgets.dart';
import 'package:solana/dto.dart' hide TransactionStatus;

class SystemInstructionDetails extends StatelessWidget {
  const SystemInstructionDetails({
    Key? key,
    required this.instruction,
    required this.status,
    required this.dateTime,
  }) : super(key: key);

  final ParsedSystemInstruction instruction;
  final DateTime? dateTime;
  final TransactionStatus status;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          BasicTransactionInformation(
            dateTime: dateTime,
            status: status,
          ),
          instruction.maybeMap(
            transfer: (ix) => TransferInstructionDetails(
              data: TransferInstructionData.fromSystemTransfer(
                info: ix.info,
                dateTime: dateTime,
                status: status,
              ),
            ),
            transferChecked: (ix) => TransferInstructionDetails(
              data: TransferInstructionData.fromSystemTransfer(
                info: ix.info,
                dateTime: dateTime,
                status: status,
              ),
            ),
            orElse: () => const SizedBox(),
          ),
        ],
      );
}
