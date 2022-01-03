import 'package:solana/src/associated_token_account_program/associated_token_account_program.dart';
import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/encoder/buffer.dart';
import 'package:solana/src/exceptions/no_associated_token_account_exception.dart';
import 'package:solana/src/helpers.dart';
import 'package:solana/src/programs/token_program/token_program.dart';
import 'package:solana/src/rpc/client.dart';
import 'package:solana/src/rpc/dto/account.dart';
import 'package:solana/src/rpc/dto/commitment.dart';
import 'package:solana/src/rpc/dto/confirmation_status.dart';
import 'package:solana/src/rpc/dto/encoding.dart';
import 'package:solana/src/rpc/dto/program_account.dart';
import 'package:solana/src/rpc/dto/token_accounts_filter.dart';
import 'package:solana/src/subscription_client/subscription_client.dart';

/// Represents a SPL token program
class SplToken {
  SplToken._({
    required this.mint,
    required this.supply,
    required this.decimals,
    this.owner,
  });

  /// Passing [owner] makes this a writeable token.
  static Future<SplToken> _withOptionalOwner({
    required String mint,
    required RpcClient rpcClient,
    Ed25519HDKeyPair? owner,
  }) async {
    // TODO(IA): perhaps delay this or use a user provided token information
    final supplyValue = await rpcClient.getTokenSupply(mint);

    return SplToken._(
      decimals: supplyValue.decimals,
      supply: BigInt.parse(supplyValue.amount),
      mint: mint,
      owner: owner,
    );
  }

  /// Create a read write account
  static Future<SplToken> readWrite({
    required RpcClient rpcClient,
    required String mint,
    required Ed25519HDKeyPair owner,
  }) =>
      SplToken._withOptionalOwner(
        mint: mint,
        rpcClient: rpcClient,
        owner: owner,
      );

  /// Create a readonly account for [mint].
  static Future<SplToken> readonly({
    required String mint,
    required RpcClient rpcClient,
  }) =>
      SplToken._withOptionalOwner(
        mint: mint,
        rpcClient: rpcClient,
      );

  Future<ProgramAccount?> getAssociatedAccount(
    String owner, {
    required RpcClient rpcClient,
  }) async {
    final accounts = await rpcClient.getTokenAccountsByOwner(
      owner,
      TokenAccountsFilter.byMint(mint),
      encoding: Encoding.jsonParsed,
    );
    if (accounts.isEmpty) {
      return null;
    }
    return accounts.first;
  }

  /// Transfer [amount] tokens owned by [owner] from [source] to [destination]
  Future<String> transfer({
    required RpcClient rpcClient,
    required SubscriptionClient subscriptionClient,
    required String source,
    required String destination,
    required int amount,
    required Ed25519HDKeyPair owner,
    String? memo,
    Commitment commitment = ConfirmationStatus.finalized,
  }) async {
    final associatedRecipientAccount = await getAssociatedAccount(
      destination,
      rpcClient: rpcClient,
    );
    final associatedSenderAccount = await getAssociatedAccount(
      source,
      rpcClient: rpcClient,
    );
    // Throw an appropriate exception if the sender has no associated
    // token account
    if (associatedSenderAccount == null) {
      throw NoAssociatedTokenAccountException(source, mint);
    }
    // Also throw an adequate exception if the recipient has no associated
    // token account
    if (associatedRecipientAccount == null) {
      throw NoAssociatedTokenAccountException(destination, mint);
    }

    final message = TokenProgram.transfer(
      source: associatedSenderAccount.pubkey,
      destination: associatedRecipientAccount.pubkey,
      owner: owner.address,
      amount: amount,
      memo: memo,
    );

    final signature = await rpcClient.signAndSendTransaction(
      message,
      [
        owner,
      ],
    );
    await subscriptionClient.waitForSignatureStatus(
      signature,
      status: commitment,
    );

    return signature;
  }

  /// Create an account for [account]
  Future<Account> createAccount({
    required RpcClient rpcClient,
    required SubscriptionClient subscriptionClient,
    required Ed25519HDKeyPair account,
    required Ed25519HDKeyPair creator,
    Commitment commitment = Commitment.finalized,
  }) async {
    const space = TokenProgram.neededAccountSpace;
    final rent = await rpcClient.getMinimumBalanceForRentExemption(space);
    final message = TokenProgram.createAccount(
      address: account.address,
      owner: creator.address,
      mint: mint,
      rent: rent,
      space: space,
    );
    final signature = await rpcClient.signAndSendTransaction(
      message,
      [
        creator,
        account,
      ],
    );
    await subscriptionClient.waitForSignatureStatus(
      signature,
      status: commitment,
    );

    // TODO(IA): need to check if it is executable and grab the rentEpoch
    return Account(
      owner: account.address,
      lamports: 0,
      executable: false,
      rentEpoch: 0,
      data: null,
    );
  }

  /// Compute and derive the associated token address of [owner]
  Future<String> computeAssociatedAddress({
    required String owner,
  }) =>
      findProgramAddress(
        seeds: [
          Buffer.fromBase58(owner),
          Buffer.fromBase58(TokenProgram.programId),
          Buffer.fromBase58(mint),
        ],
        programId: AssociatedTokenAccountProgram.programId,
      );

  /// Create the associated account for [owner] funded by [funder].
  Future<ProgramAccount> createAssociatedAccount({
    required RpcClient rpcClient,
    required SubscriptionClient subscriptionClient,
    required String owner,
    required Ed25519HDKeyPair funder,
    Commitment commitment = Commitment.finalized,
  }) async {
    final derivedAddress = await computeAssociatedAddress(
      owner: owner,
    );
    final message = AssociatedTokenAccountProgram(
      mint: mint,
      address: derivedAddress,
      owner: owner,
      funder: funder.address,
    );
    final signature = await rpcClient.signAndSendTransaction(
      message,
      [
        funder,
      ],
    );
    await subscriptionClient.waitForSignatureStatus(
      signature,
      status: commitment,
    );

    // TODO(IA): populate rentEpoch correctly
    return ProgramAccount(
      pubkey: derivedAddress,
      account: Account(
        owner: owner,
        lamports: 0,
        executable: false,
        rentEpoch: 0,
        data: null,
      ),
    );
  }

  /// Mint [destination] with [amount] tokens. Requires writable [Token].
  Future<void> mintTo({
    required RpcClient rpcClient,
    required SubscriptionClient subscriptionClient,
    required String destination,
    required int amount,
    Commitment commitment = Commitment.finalized,
  }) async {
    final owner = this.owner;
    if (owner == null) {
      throw _readonlyTokenError;
    }
    final message = TokenProgram.mintTo(
      mint: mint,
      destination: destination,
      authority: owner.address,
      amount: amount,
    );
    final signature = await rpcClient.signAndSendTransaction(
      message,
      [owner],
    );
    await subscriptionClient.waitForSignatureStatus(
      signature,
      status: commitment,
    );
  }

  final int decimals;
  final BigInt supply;
  final String mint;
  final Ed25519HDKeyPair? owner;
}

extension TokenExt on RpcClient {
  /// Create a new token owned by [owner] with [decimals] base 10 decimal digits.
  ///
  /// You can optionally specify a [mintAuthority] address. By default the [owner]
  /// address will be used as the _Mint Authority_.
  ///
  /// Also optional, you can specify a [freezeAuthority]. By default the
  /// [freezeAuthority] is not set.
  ///
  /// Finally, you can also send the transaction with optional [commitment].
  Future<SplToken> initializeMint({
    required Ed25519HDKeyPair owner,
    required int decimals,
    required RpcClient rpcClient,
    required SubscriptionClient subscriptionClient,
    String? mintAuthority,
    String? freezeAuthority,
    Commitment commitment = Commitment.finalized,
  }) async {
    const space = TokenProgram.neededMintAccountSpace;
    final mintWallet = await Ed25519HDKeyPair.random();
    final rent = await getMinimumBalanceForRentExemption(space);

    final message = TokenProgram.initializeMint(
      mint: mintWallet.address,
      mintAuthority: mintAuthority ?? owner.address,
      freezeAuthority: freezeAuthority,
      rent: rent,
      space: space,
      decimals: decimals,
    );
    final signature = await signAndSendTransaction(
      message,
      [
        owner,
        mintWallet,
      ],
    );
    await subscriptionClient.waitForSignatureStatus(
      signature,
      status: commitment,
    );

    return SplToken.readWrite(
      owner: owner,
      mint: mintWallet.address,
      rpcClient: rpcClient,
    );
  }
}

const _readonlyTokenError = FormatException('this token instance is readonly');
