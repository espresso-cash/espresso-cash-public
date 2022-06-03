import 'package:collection/collection.dart';
import 'package:cryptoplease/bl/accounts/account.dart';
import 'package:cryptoplease/bl/nft/nft_collection/utils.dart';
import 'package:cryptoplease/bl/solana_helpers.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:solana/dto.dart';
import 'package:solana/metaplex.dart';
import 'package:solana/solana.dart';

AsyncResult<IList<NonFungibleToken>> loadNftCollection({
  required MyAccount account,
  required SolanaClient client,
}) =>
    tryEitherAsync((_) async {
      final wallet = account.wallet;

      final accounts = await client.getSplAccounts(wallet.address);
      final nftCollection = await _extractNftsFromAccounts(
        accounts,
        client: client,
      );

      return nftCollection
          .toIList()
          .sort((m1, m2) => m1.name.compareTo(m2.name));
    });

Future<Iterable<NonFungibleToken>> _extractNftsFromAccounts(
  Iterable<ProgramAccount> accounts, {
  required SolanaClient client,
}) async {
  final nftMints =
      accounts.map((d) => d.toNftAccountDataOrNull()).whereNotNull();

  final unfiltered = await Future.wait(
    nftMints.map((info) async {
      final metadata = await client.rpcClient
          .getMetadata(mint: Ed25519HDPublicKey.fromBase58(info.mint));

      return metadata == null
          ? null
          : NonFungibleToken(address: info.mint, metadata: metadata);
    }),
  );

  return unfiltered.whereNotNull();
}
