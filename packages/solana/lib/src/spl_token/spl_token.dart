import 'package:solana/solana.dart';
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
    // TODO(IA): perhaps delay this or use a user provided token information
    final supplyResponse = await rpcClient.getTokenSupply(mint);
    final supplyValue = supplyResponse.value;
    return SplToken._(
      decimals: supplyValue.decimals,
      supply: BigInt.parse(supplyValue.amount),
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

  Future<AssociatedTokenAccount?> getAssociatedAccount(
    String owner,
  ) async {
    final accounts = await _rpcClient.getTokenAccountsByOwner(
      owner: owner,
      mint: mint,
    );
    if (accounts.isEmpty) {
      return null;
    }
    return accounts.first;
  }

  /// Transfer [amount] tokens owned by [owner] from [source] to [destination]
  Future<TransactionSignature> transfer({
    required String source,
    required String destination,
    required int amount,
    required Ed25519HDKeyPair owner,
    Commitment commitment = TxStatus.finalized,
  }) async {
    final associatedRecipientAccount = await getAssociatedAccount(destination);
    final associatedSenderAccount = await getAssociatedAccount(source);
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
      source: associatedSenderAccount.address,
      destination: associatedRecipientAccount.address,
      owner: owner.address,
      amount: amount,
    );

    final signature = await _rpcClient.signAndSendTransaction(
      message,
      [
        owner,
      ],
    );
    return signature;
  }

  /// Transfer [amount] tokens owned by [owner] from [source] to [destination]
  Future<TransactionSignature> createAssociatedAccountAndTransfer({
    required String source,
    required String destination,
    required int amount,
    required Ed25519HDKeyPair payer,
    Commitment commitment = Commitment.finalized,
  }) async {
    final List<Instruction> instructions = <Instruction>[];
    final AssociatedTokenAccount? associatedSenderAccount = await getAssociatedAccount(source);
    final AssociatedTokenAccount? associatedRecipientAccount = await getAssociatedAccount(destination);

    // Throw an appropriate exception if the sender has no associated
    // token account
    if (associatedSenderAccount == null) {
      throw NoAssociatedTokenAccountException(source, mint);
    }
    // Also throw an adequate exception if the recipient has no associated
    // token account
    String? associatedRecipientAccountAddres = associatedRecipientAccount?.address;
    if (associatedRecipientAccount == null) {
      final derivedAddress = await computeAssociatedAddress(
        owner: destination,
      );
      final associatedTokenAccountProgramMessage = AssociatedTokenAccountProgram(
        mint: mint,
        address: derivedAddress,
        owner: destination,
        funder: payer.address,
      );
      associatedRecipientAccountAddres = derivedAddress;
      instructions.addAll(associatedTokenAccountProgramMessage.instructions);
    }

    if (associatedRecipientAccountAddres == null) {
      throw NoAssociatedTokenAccountException(destination, mint);
    }

    final transferMessage = TokenProgram.transfer(
      source: associatedSenderAccount.address,
      destination: associatedRecipientAccountAddres,
      owner: payer.address,
      amount: amount,
    );
    instructions.addAll(transferMessage.instructions);
    final Message message = Message(instructions: instructions);
    final signature = await _rpcClient.signAndSendTransaction(
      message,
      [
        payer,
      ],
    );
    return signature;
  }

  /// Create an account for [account]
  Future<Account> createAccount({
    required Ed25519HDKeyPair account,
    required Ed25519HDKeyPair creator,
    Commitment commitment = Commitment.finalized,
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
    await _rpcClient.waitForSignatureStatus(signature, commitment);

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
    final signature = await _rpcClient.signAndSendTransaction(
      message,
      [
        funder,
      ],
    );
    await _rpcClient.waitForSignatureStatus(signature, commitment);

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
    final signature = await _rpcClient.signAndSendTransaction(
      message,
      [owner],
    );
    await _rpcClient.waitForSignatureStatus(signature, commitment);
  }

  final int decimals;
  final BigInt supply;
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
    await waitForSignatureStatus(signature, commitment);

    return SplToken.readWrite(
      owner: owner,
      mint: mintWallet.address,
      rpcClient: this,
    );
  }
}

const _readonlyTokenError = FormatException('this token instance is readonly');
