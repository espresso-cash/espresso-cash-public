import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/types/json_rpc_response_object.dart';
import 'package:solana/src/types/tx_meta.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

enum Program {
  @JsonValue('system')
  system,
  @JsonValue('spl-memo')
  memo,
}

@JsonSerializable(createToJson: false)
class ConfirmedTransactionResponse
    extends JsonRpcResponse<GetTransactionResult?> {
  ConfirmedTransactionResponse(GetTransactionResult? result)
      : super(result: result);

  factory ConfirmedTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$ConfirmedTransactionResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class GetTransactionResponse extends JsonRpcResponse<GetTransactionResult> {
  GetTransactionResponse(GetTransactionResult result) : super(result: result);

  factory GetTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$GetTransactionResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class GetTransactionResult {
  GetTransactionResult({
    this.meta,
    required this.slot,
    required this.blockTime,
    required this.transaction,
  });

  factory GetTransactionResult.fromJson(Map<String, dynamic> json) =>
      _$GetTransactionResultFromJson(json);

  final TxMeta? meta;
  final int slot;
  final int blockTime;
  final Transaction transaction;
}

@JsonSerializable(createToJson: false)
class Transaction {
  Transaction({
    this.message,
    required this.signatures,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  final List<String> signatures;
  final TxMessage? message;
}

@JsonSerializable(createToJson: false)
class TxMessageHeader {
  TxMessageHeader({
    required this.numRequiredSignatures,
    required this.numReadonlySignedAccounts,
    required this.numReadonlyUnsignedAccounts,
  });

  factory TxMessageHeader.fromJson(Map<String, dynamic> json) =>
      _$TxMessageHeaderFromJson(json);

  final int numRequiredSignatures;
  final int numReadonlySignedAccounts;
  final int numReadonlyUnsignedAccounts;
}

@JsonSerializable(createToJson: false)
class _TxInstruction {
  _TxInstruction({
    required this.programId,
    required this.program,
    required this.parsed,
  });

  factory _TxInstruction.fromJson(Map<String, dynamic> json) =>
      _$_TxInstructionFromJson(json);

  final String programId;
  final Program program;
  final dynamic parsed;
}

@JsonSerializable(createToJson: false)
class _ParsedTransferInstruction {
  _ParsedTransferInstruction({
    required this.info,
    required this.type,
  });

  factory _ParsedTransferInstruction.fromJson(Map<String, dynamic> json) =>
      _$_ParsedTransferInstructionFromJson(json);
  final Map<String, dynamic> info;
  final String type; // Always 'transfer'
}

@freezed
class TxInstruction {
  const TxInstruction._();

  factory TxInstruction.fromJson(Map<String, dynamic> json) {
    final base = _TxInstruction.fromJson(json);
    switch (base.program) {
      case Program.system:
        final data = _ParsedTransferInstruction.fromJson(
          base.parsed as Map<String, dynamic>,
        );
        if (data.type != 'transfer') {
          throw const FormatException(
            'invalid parsed object from instruction, cannot be converted to a transfer',
          );
        }
        return TxInstruction.transfer(
          lamports: data.info['lamports'] as int,
          source: data.info['source'] as String,
          destination: data.info['destination'] as String,
        );
      case Program.memo:
        return TxInstruction.memo(base.parsed as String);
    }
  }
  const factory TxInstruction.transfer({
    required int lamports,
    required String source,
    required String destination,
  }) = TransferInstruction;

  const factory TxInstruction.memo(String memo) = MemoInstruction;
}

@JsonSerializable(createToJson: false)
class TxMessage {
  TxMessage({
    this.header,
    required this.accountKeys,
    required this.recentBlockhash,
    required this.instructions,
  });

  factory TxMessage.fromJson(Map<String, dynamic> json) =>
      _$TxMessageFromJson(json);

  final List<AccountKey> accountKeys;
  final TxMessageHeader? header;
  final String recentBlockhash;
  final List<TxInstruction> instructions;
}

@JsonSerializable(createToJson: false)
class AccountKey {
  AccountKey({
    required this.pubkey,
  });

  factory AccountKey.fromJson(Map<String, dynamic> json) =>
      _$AccountKeyFromJson(json);

  final String pubkey;
}
