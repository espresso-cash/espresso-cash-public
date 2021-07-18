import 'package:solana/src/associated_token_account_program/associated_token_account_program.dart';
import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/encoder/buffer.dart';
import 'package:solana/src/exceptions/no_associated_token_account_exception.dart';
import 'package:solana/src/rpc_client/account.dart';
import 'package:solana/src/rpc_client/commitment.dart';
import 'package:solana/src/rpc_client/rpc_client.dart';
import 'package:solana/src/rpc_client/signature_status.dart';
import 'package:solana/src/rpc_client/transaction_signature.dart';
import 'package:solana/src/spl_token/associated_account.dart';
import 'package:solana/src/spl_token/rpc_extensions.dart';
import 'package:solana/src/token_program/token_program.dart';
import 'package:solana/src/utils.dart';

/// Represents a SPL token program
class SplToken {
  SplToken._({
    required this.mint,
    required this.supply,
    required this.decimals,
    required RPCClient rpcClient,
    this.owner,
  }) : _rpcClient = rpcClient;

  /// Passing [owner] makes this a writeable token.
  static Future<SplToken> _withOptionalOwner({
    required String mint,
    required RPCClient rpcClient,
    Ed25519HDKeyPair? owner,
  }) async {
    final supplyResponse = await rpcClient.getTokenSupply(mint);
    final supplyValue = supplyResponse.value;
    return SplToken._(
      decimals: supplyValue.decimals,
      supply: int.parse(supplyValue.amount),
      rpcClient: rpcClient,
      mint: mint,
      owner: owner,
    );
  }

  /// Create a read write account
  static Future<SplToken> readWrite({
    required String mint,
    required RPCClient rpcClient,
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
    required RPCClient rpcClient,
  }) =>
      SplToken._withOptionalOwner(
        mint: mint,
        rpcClient: rpcClient,
      );

  Future<String> findAssociatedTokenAddress(String owner) async {
    final accounts = await getAssociatedAccountsFor(owner: owner);
    if (accounts.isEmpty) {
      throw NoAssociatedTokenAccountException(owner, mint);
    }
    final address = await computeAssociatedAddress(owner: owner);
    if (accounts.indexWhere((a) => a.address == address) == -1) {
      throw NoAssociatedTokenAccountException(owner, mint);
    }
    return address;
  }

  /// Transfer [amount] tokens owned by [owner] from [source] to [destination]
  Future<TransactionSignature> transfer({
    required String source,
    required String destination,
    required int amount,
    required Ed25519HDKeyPair owner,
  }) async {
    // A sender must have the appropriate associated account, in case they
    // don't it's an error and we should throw an exception.
    final sourceAssociatedTokenAddress =
        await findAssociatedTokenAddress(source);
    // A recipient needs an associated account as well
    final destinationAssociatedTokenAddress =
        await findAssociatedTokenAddress(destination);

    final message = TokenProgram.transfer(
      source: sourceAssociatedTokenAddress,
      destination: destinationAssociatedTokenAddress,
      owner: owner.address,
      amount: amount,
    );

    return _rpcClient.signAndSendTransaction(
      message,
      [
        owner,
      ],
    );
  }

  /// Create an account for [account]
  Future<Account> createAccount({
    required Ed25519HDKeyPair account,
    required Ed25519HDKeyPair creator,
  }) async {
    const space = TokenProgram.neededAccountSpace;
    final rent = await _rpcClient.getMinimumBalanceForRentExemption(space);
    final message = TokenProgram.createAccount(
      address: account.address,
      owner: creator.address,
      mint: mint,
      rent: rent,
      space: space,
    );
    final signature = await _rpcClient.signAndSendTransaction(
      message,
      [
        creator,
        account,
      ],
    );
    await _rpcClient.waitForSignatureStatus(signature, TxStatus.finalized);

    // TODO(IA): need to check if it is executable and grab the rentEpoch
    return Account(
      owner: account.address,
      lamports: 0,
      executable: false,
      rentEpoch: 0,
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
  Future<AssociatedTokenAccount> createAssociatedAccount({
    required String owner,
    required Ed25519HDKeyPair funder,
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
    final signature = await _rpcClient.signAndSendTransaction(
      message,
      [
        funder,
      ],
    );
    await _rpcClient.waitForSignatureStatus(
      signature,
      Commitment.finalized,
    );

    // TODO(IA): populate rentEpoch correctly
    return AssociatedTokenAccount(
      address: derivedAddress,
      account: Account(
        owner: owner,
        lamports: 0,
        executable: false,
        rentEpoch: 0,
      ),
    );
  }

  /// Mint [destination] with [amount] tokens. Requires writable [Token].
  Future<void> mintTo({
    required String destination,
    required int amount,
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
    await _rpcClient.signAndSendTransaction(
      message,
      [
        owner,
      ],
    );
  }

  /// Query [owner]'s associated accounts for this token.
  ///
  /// This method returns all the accounts that are owned by [owner]
  /// and associated with this token. If there are none, then an empty
  /// list is returned.
  Future<List<AssociatedTokenAccount>> getAssociatedAccountsFor({
    required String owner,
  }) async =>
      _rpcClient.getTokenAccountsByOwner(owner, mint: mint);

  final int decimals;
  final int supply;
  final String mint;
  final Ed25519HDKeyPair? owner;
  final RPCClient _rpcClient;
}

extension TokenExt on RPCClient {
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
    String? mintAuthority,
    String? freezeAuthority,
    Commitment? commitment,
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
      commitment: commitment,
    );
    await waitForSignatureStatus(
      signature,
      Commitment.finalized,
    );

    return SplToken.readWrite(
      owner: owner,
      mint: mintWallet.address,
      rpcClient: this,
    );
  }
}

const _readonlyTokenError = FormatException('this token instance is readonly');
