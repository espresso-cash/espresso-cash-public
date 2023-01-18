import 'package:dfunc/dfunc.dart';
import 'package:solana/dto.dart';

extension TxDestinationsExt on ParsedTransaction {
  /// Retrieves all destinations of a transaction
  Iterable<String> getDestinations() => message.instructions
      .whereType<ParsedInstruction>()
      .let((it) => it.map((ix) => ix.getDestination()).compact());

  String get id => signatures.first;
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
