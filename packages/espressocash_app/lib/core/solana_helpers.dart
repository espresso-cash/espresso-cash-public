import 'dart:async';

import 'package:solana/dto.dart' hide Instruction;
import 'package:solana/solana.dart';

extension SolanaClientExt on SolanaClient {
  Future<Iterable<ProgramAccount>> getSplAccounts(String address) => rpcClient
      .getTokenAccountsByOwner(
        address,
        const TokenAccountsFilter.byProgramId(TokenProgram.programId),
        commitment: Commitment.confirmed,
        encoding: Encoding.jsonParsed,
      )
      .value;
}
