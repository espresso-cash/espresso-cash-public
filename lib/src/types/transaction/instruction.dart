import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/types/transaction/transaction.dart';

part 'instruction.freezed.dart';
part 'instruction.g.dart';

/// An instruction which is part of a [TxMessage]
@freezed
class TxInstruction {
  const TxInstruction._();

  factory TxInstruction.fromJson(Map<String, dynamic> json) {
    final base = _Instruction.fromJson(json);
    switch (base.program) {
      case ProgramType.system:
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
      case ProgramType.memo:
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
class _Instruction {
  _Instruction({
    required this.programId,
    required this.program,
    required this.parsed,
  });

  factory _Instruction.fromJson(Map<String, dynamic> json) =>
      _$_InstructionFromJson(json);

  final String programId;
  final ProgramType program;
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
