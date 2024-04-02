import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:dfunc/dfunc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../currency/models/currency.dart';

extension SolanaClientExt on SolanaClient {
  Future<({int amountTransferred, BigInt slot})?> simulateTransfer({
    required SignedTx tx,
    required Ed25519HDPublicKey account,
    required CryptoCurrency currency,
  }) async {
    final tokenAddress = await findAssociatedTokenAddress(
      owner: account,
      mint: currency.token.publicKey,
    );

    // TODO(KB): It's better to run both requests at the same time,
    // JSON RPC allows batch requests, we need to add support for it.

    final simulation = await rpcClient.simulateTransaction(
      tx.encode(),
      commitment: Commitment.confirmed,
      accounts: SimulateTransactionAccounts(
        encoding: Encoding.base64,
        addresses: [tokenAddress.toBase58()],
      ),
    );

    if (simulation.value.err != null) return null;

    final postBalance =
        simulation.value.accounts?.first.data?.parseTokenBalance();
    final preBalance = await rpcClient
        .getAccountInfo(
          tokenAddress.toBase58(),
          commitment: Commitment.confirmed,
          encoding: Encoding.base64,
        )
        .then((e) => e.value?.data?.parseTokenBalance());

    if (postBalance == null || preBalance == null) return null;

    return (
      amountTransferred: preBalance - postBalance,
      slot: simulation.context.slot,
    );
  }
}

extension on AccountData {
  int? parseTokenBalance() {
    try {
      final data = this;
      if (data is! BinaryAccountData) return null;

      // Token Account Layout (see https://github.com/solana-labs/solana-program-library/blob/48fbb5b7c49ea35848442bba470b89331dea2b2b/token/js/src/state/account.ts#L59):
      //
      // export const AccountLayout = struct<RawAccount>([
      //     publicKey('mint'),
      //     publicKey('owner'),
      //     u64('amount'),
      //     u32('delegateOption'),
      //     publicKey('delegate'),
      //     u8('state'),
      //     u32('isNativeOption'),
      //     u64('isNative'),
      //     u64('delegatedAmount'),
      //     u32('closeAuthorityOption'),
      //     publicKey('closeAuthority'),
      // ]);
      //
      // We only need amount field, so we skip first 64 bytes (2 * 32 bytes
      // for mint and owner fields)
      return data.data
          .skip(64)
          .toList()
          .let(Uint8List.fromList)
          .buffer
          .asByteData()
          .let(BinaryReader.new)
          .readU64()
          .toInt();
    } on Object catch (error, stackTrace) {
      Sentry.captureException(error, stackTrace: stackTrace);

      return null;
    }
  }
}
