import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

extension TxDestinationsExt on SignedTx {
  /// Retrieves all destinations of a Token Program transaction
  Iterable<String> getTransferProgramDestinations() => message.instructions
      .where((it) => it.programId == TokenProgram.id)
      .map((it) => it.accounts.elementAt(1))
      .map((it) => it.pubKey.toBase58());
}
