import 'dart:ui';

import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/bl/transactions/details/transaction_details_bloc.dart';
import 'package:cryptoplease/presentation/format_amount.dart';
import 'package:intl/intl.dart';
import 'package:solana/dto.dart' hide Transaction, TransactionStatus;

class TransferInstructionData {
  const TransferInstructionData._({
    required this.date,
    required this.status,
    required this.from,
    required this.to,
    required this.token,
    required this.amount,
  });

  factory TransferInstructionData.fromSystemTransfer({
    required ParsedSystemTransferInformation info,
    required TransactionStatus status,
    required DateTime? dateTime,
  }) =>
      TransferInstructionData._(
        date: TransferInstructionData._formatNullableDateTime(dateTime),
        status: status,
        from: info.source,
        to: info.destination,
        amount: info.lamports,
        token: Token.sol,
      );

  factory TransferInstructionData.fromSplTransfer({
    required SplTokenTransferInfo info,
    required TransactionStatus status,
    required DateTime? dateTime,
    required Token token,
  }) =>
      TransferInstructionData._(
        date: TransferInstructionData._formatNullableDateTime(dateTime),
        status: status,
        from: info.source,
        to: info.destination,
        token: token,
        amount: int.parse(info.amount),
      );

  factory TransferInstructionData.fromSplTransferChecked({
    required SplTokenTransferCheckedInfo info,
    required TransactionStatus status,
    required DateTime? dateTime,
    required Token token,
  }) =>
      TransferInstructionData._(
        date: TransferInstructionData._formatNullableDateTime(dateTime),
        status: status,
        from: info.source,
        to: info.destination,
        token: token,
        amount: int.parse(info.tokenAmount.amount),
      );

  static String _formatNullableDateTime(DateTime? dateTime) {
    if (dateTime == null) {
      return '';
    }
    final formatter = DateFormat('dd/MM/yyyy HH:mm');

    return formatter.format(dateTime);
  }

  String getAmount(Locale locale) {
    if (token == Token.sol) {
      return Amount.sol(value: amount).format(locale);
    } else {
      return Amount.fromToken(value: amount, token: token).format(locale);
    }
  }

  final String date;
  final TransactionStatus status;
  final String from;
  final String to;
  final int amount;
  final Token token;
}
