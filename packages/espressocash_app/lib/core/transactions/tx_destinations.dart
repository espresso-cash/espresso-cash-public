import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:solana/dto.dart';

extension TxDestinationsExt on ParsedTransaction {
  /// Retrieves all destinations of a transaction
  IList<String> getDestinations() => message.instructions
      .whereType<ParsedInstruction>()
      .map((ix) => ix.getDestination())
      .compact()
      .toIList();

  String get id => signatures.first;
}

extension MetaInnerInstructionExt on TransactionDetails {
  /// Retrieves all destinations of a transaction
  IList<String> getInnerDestinations() => meta
      .let((m) => m?.innerInstructions ?? [])
      .expand((e) => e.instructions)
      .whereType<ParsedInstruction>()
      .map((ix) => ix.getDestination())
      .compact()
      .toIList();
}

extension on ParsedInstruction {
  String? getDestination() => mapOrNull<String?>(
        system: (it) => it.parsed.mapOrNull(
          transfer: (t) => t.info.destination,
          transferChecked: (t) => t.info.destination,
        ),
        splToken: (it) => it.parsed.mapOrNull(
          transfer: (t) => t.info.destination,
          transferChecked: (t) => t.info.destination,
        ),
      );
}
