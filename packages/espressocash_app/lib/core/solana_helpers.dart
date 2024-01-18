import 'dart:async';

import 'package:solana/dto.dart' hide Instruction;
import 'package:solana/solana.dart';
import 'package:solana/solana_pay.dart';

import '../config.dart';

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

SolanaPayRequest? tryParseSolanaPayRequest(Uri link) {
  final linkWithCorrectScheme = link.scheme == 'http' &&
          link.host == espressoCashLinkDomain &&
          link.queryParameters['t'] == 'solanapay' &&
          link.queryParameters['recipient'] != null
      ? Uri(
          scheme: 'solana',
          path: link.queryParameters['recipient'],
          queryParameters: {...link.queryParameters}
            ..remove('t')
            ..remove('recipient'),
        )
      : link;

  return SolanaPayRequest.tryParse(linkWithCorrectScheme.toString());
}
