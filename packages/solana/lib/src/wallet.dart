import 'package:solana/solana.dart';
import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/encoder/message.dart';
import 'package:solana/src/exceptions/bad_state_exception.dart';
import 'package:solana/src/rpc_client/commitment.dart';
import 'package:solana/src/rpc_client/rpc_client.dart';
import 'package:solana/src/rpc_client/signature_status.dart';
import 'package:solana/src/rpc_client/transaction_signature.dart';
import 'package:solana/src/spl_token/associated_account.dart';
import 'package:solana/src/spl_token/spl_token.dart';
import 'package:solana/src/spl_token/token_amount.dart';
import 'package:solana/src/token_program/token_program.dart';

/// Convenient object for common operations
class Wallet {
  Wallet({
    required this.signer,
    required RPCClient rpcClient,
  })  : _rpcClient = rpcClient,
        _tokens = <String, _TokenInfo>{};

  Future<TransactionSignature> _genericTransfer({
    required String source,
    required String destination,
    required int lamports,
    String? memo,
    Commitment? commitment,
  }) {
    final instructions = [
      SystemInstruction.transfer(
        source: source,
        destination: destination,
        lamports: lamports,
      ),
      if (memo != null) MemoInstruction(signers: [source], memo: memo),
    ];

    final message = Message(
      instructions: instructions,
    );

    return _rpcClient.signAndSendTransaction(
      message,
      [signer],
      commitment: commitment,
    );
  }

  /// Loads the [mint] token into the tokens list
  Future<void> addSplToken({required String mint}) async {
    late final _TokenInfo tokenInfo;
    if (_tokens.containsKey(mint)) {
      throw const BadStateException('token already added to this wallet');
    }
    final token = await SplToken.readonly(mint: mint, rpcClient: _rpcClient);
    final associatedTokenAddress = await token.computeAssociatedAddress(
      owner: address,
    );
    late final List<AssociatedTokenAccount> accounts;
    try {
      accounts = await token.getAssociatedAccountsFor(owner: address);
    } on FormatException {
      accounts = [];
    }
    if (accounts.isEmpty) {
      tokenInfo = _TokenInfo(
        token: token,
        associatedAddress: associatedTokenAddress,
      );
    } else {
      final indexOfExistingAccount =
          accounts.indexWhere((a) => a.address == associatedTokenAddress);
      if (indexOfExistingAccount == -1) {
        tokenInfo = _TokenInfo(
          token: token,
          associatedAddress: associatedTokenAddress,
        );
      } else {
        tokenInfo = _TokenInfo(
          token: token,
          account: accounts[indexOfExistingAccount],
          associatedAddress: associatedTokenAddress,
        );
      }
    }
    _tokens[mint] = tokenInfo;
  }

  /// Creates a solana transfer message to send [lamports] SOL tokens from [source]
  /// to [destination].
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<TransactionSignature> transfer({
    required String destination,
    required int lamports,
    Commitment? commitment,
  }) =>
      _genericTransfer(
        source: address,
        destination: destination,
        lamports: lamports,
        commitment: commitment,
      );

  /// Creates a solana transfer message to send [lamports] SOL tokens from [source]
  /// to [destination].
  ///
  /// To add additional data to the transaction you can use the [memo] field.
  /// It accepts an arbitrary string of utf-8 characters. As of now the maximum
  /// allowed length for the memo is 566 bytes of utf-8 data.
  ///
  /// NOTE: This constructor creates a transaction with 2 instructions when a [memo]
  /// is provided.
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<TransactionSignature> transferWithMemo({
    required String destination,
    required int lamports,
    required String memo,
    Commitment? commitment,
  }) =>
      _genericTransfer(
        source: address,
        destination: destination,
        lamports: lamports,
        memo: memo,
        commitment: commitment,
      );

  /// Request airdrop for [amount] to this wallet's account.
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<TransactionSignature> requestAirdrop({
    required int lamports,
    Commitment? commitment,
  }) async {
    final signature = await _rpcClient.requestAirdrop(
      address: address,
      lamports: lamports,
      commitment: commitment,
    );
    await _rpcClient.waitForSignatureStatus(
      signature,
      commitment ?? TxStatus.finalized,
    );

    return signature;
  }

  /// Transfers [amount] SPL token with [mint] from this wallet to the
  /// [destination address.
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<TransactionSignature>? transferSplToken({
    required String mint,
    required String destination,
    required int amount,
    Commitment? commitment,
  }) async {
    if (!hasAssociatedTokenAccount(mint: mint)) {
      throw const FormatException(
          'this wallet has no associated token account');
    }
    final tokenInfo = _getTokenInfoOrThrow(mint);
    final token = tokenInfo.token;

    return token.transfer(
      source: address,
      amount: amount,
      destination: destination,
      owner: signer,
    );
  }

  Future<TransactionSignature>? transferSplTokenWithMemo({
    required String mint,
    required String destination,
    required int amount,
    required String memo,
    Commitment? commitment,
  }) async {
    if (!hasAssociatedTokenAccount(mint: mint)) {
      throw const FormatException(
          'this wallet has no associated token account');
    }

    final tokenInfo = _getTokenInfoOrThrow(mint);
    final token = tokenInfo.token;
    final source = tokenInfo.associatedAddress;

    final message = Message(
      instructions: [
        TokenInstruction.transfer(
          source: source,
          destination: await token.findAssociatedTokenAddress(destination),
          amount: amount,
          owner: address,
        ),
        MemoInstruction(
          signers: [address],
          memo: memo,
        ),
      ],
    );

    return _rpcClient.signAndSendTransaction(
      message,
      [signer],
      commitment: commitment,
    );
  }

  /// Create the account associated to the SPL token [mint] for this wallet.
  ///
  /// If you want to use another wallet as a funder use the [funder] parameter.
  ///
  /// Also adds the token to the wallet object.
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<AssociatedTokenAccount> createAssociatedTokenAccount({
    required String mint,
    Commitment? commitment,
    Wallet? funder,
  }) async {
    final token = await SplToken.readonly(mint: mint, rpcClient: _rpcClient);
    final associatedTokenAccount = await token.createAssociatedAccount(
      owner: address,
      funder: funder?.signer ?? signer,
    );

    /// Add the token to the list
    _tokens[mint] = _TokenInfo(
      token: token,
      associatedAddress: associatedTokenAccount.address,
      account: associatedTokenAccount,
    );

    return associatedTokenAccount;
  }

  /// Whether this wallet has an associated token account for the SPL token [mint].
  ///
  /// If the [mint] was not added to the list of known tokens for this wallet
  /// this method simply returns `false`.
  bool hasAssociatedTokenAccount({
    required String mint,
  }) {
    final tokenInfo = _tokens[mint];
    if (tokenInfo == null) {
      return false;
    }
    return tokenInfo.hasAssociatedAccount;
  }

  /// Get the account associated to the SPL token [mint] for this wallet.
  ///
  /// Note: this method always returns the address because it is computed
  /// when the [Wallet.loadToken()] method is called
  String getAssociatedTokenAccountAddress({
    required String mint,
  }) {
    final tokenInfo = _getTokenInfoOrThrow(mint);
    return tokenInfo.associatedAddress;
  }

  /// Get token [mint] balance for this wallet's account.
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<TokenAmount> getTokenBalance({
    required String mint,
    Commitment? commitment,
  }) async {
    final tokenInfo = _getTokenInfoOrThrow(mint);
    return _rpcClient.getTokenAccountBalance(
      associatedTokenAccountAddress: tokenInfo.associatedAddress,
      commitment: commitment,
    );
  }

  /// Get the balance in lamports for this wallet's account
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<int> getLamports({Commitment? commitment}) =>
      _rpcClient.getBalance(address, commitment: commitment);

  _TokenInfo _getTokenInfoOrThrow(String mint) {
    final tokenInfo = _tokens[mint];
    if (tokenInfo == null) {
      throw BadStateException('token $mint was not added to this wallet.');
    }
    return tokenInfo;
  }

  /// The address associated to this wallet
  String get address => signer.address;

  /// The [signer] associated to this wallet. This is exported
  /// because it can be needed in some places.
  final Ed25519HDKeyPair signer;

  final RPCClient _rpcClient;
  final Map<String, _TokenInfo> _tokens;
}

class _TokenInfo {
  const _TokenInfo({
    required this.token,
    required this.associatedAddress,
    this.account,
  });

  bool get hasAssociatedAccount => account != null;

  final SplToken token;
  final AssociatedTokenAccount? account;
  final String associatedAddress;
}
