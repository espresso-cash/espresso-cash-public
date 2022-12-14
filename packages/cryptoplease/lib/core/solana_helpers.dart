import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:solana/dto.dart' hide Instruction;
import 'package:solana/solana.dart';

extension SolanaClientExt on SolanaClient {
  Future<Iterable<ProgramAccount>> getSplAccounts(String address) =>
      rpcClient.getTokenAccountsByOwner(
        address,
        const TokenAccountsFilter.byProgramId(TokenProgram.programId),
        commitment: Commitment.confirmed,
        encoding: Encoding.jsonParsed,
      );

  /// Retrieves all destinations of a transaction
  Future<Iterable<String>> getDestinations(String signature) => rpcClient
      .getTransaction(
        signature,
        commitment: Commitment.confirmed,
        encoding: Encoding.jsonParsed,
      )
      .then((txDetails) => txDetails?.transaction as ParsedTransaction)
      .then((tx) => tx.message.instructions.cast<ParsedInstruction>())
      .then((it) => it.map((ix) => ix.getDestination()).compact());
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
