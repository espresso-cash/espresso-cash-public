import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:solana/dto.dart';

extension TxDestinationsExt on ParsedTransaction {
  /// Retrieves all destinations of a transaction
  IList<String> getDestinations() =>
      message.instructions
          .whereType<ParsedInstruction>()
          .map((ix) => ix.getDestination())
          .compact()
          .toIList();

  String get id => signatures.first;
}

extension MetaInnerInstructionExt on TransactionDetails {
  /// Retrieves all destinations of a transaction
  IList<String> getInnerDestinations() =>
      meta
          .let((m) => m?.innerInstructions ?? [])
          .expand((e) => e.instructions)
          .whereType<ParsedInstruction>()
          .map((ix) => ix.getDestination())
          .compact()
          .toIList();
}

extension on ParsedInstruction {
  String? getDestination() => switch (this) {
    ParsedInstructionSystem(:final parsed) => switch (parsed) {
      ParsedSystemTransferInstruction(:final info) ||
      ParsedSystemTransferCheckedInstruction(:final info) => info.destination,
      _ => null,
    },
    ParsedInstructionSplToken(:final parsed) => switch (parsed) {
      ParsedSplTokenTransferInstruction(:final info) => info.destination,
      ParsedSplTokenTransferCheckedInstruction(info: final checkedInfo) => checkedInfo.destination,
      _ => null,
    },
    _ => null,
  };
}
