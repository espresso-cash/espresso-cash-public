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

  Future<bool> isLoopbackTx(String txId, String address) async {
    final destinations = await rpcClient
        .getTransaction(
          txId,
          commitment: Commitment.confirmed,
          encoding: Encoding.jsonParsed,
        )
        .then((txDetails) => txDetails?.transaction as ParsedTransaction)
        .letAsync((tx) => tx.message.instructions.cast<ParsedInstruction>())
        .letAsync((it) => it.map((ix) => ix.getDestination()).compact());

    if (destinations.isEmpty) return false;

    return getSplAccounts(address)
        .then((it) => it.map((e) => e.pubkey))
        .letAsync((it) => it.toSet().intersection(destinations.toSet()))
        .letAsync((it) => it.isNotEmpty);
  }
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
