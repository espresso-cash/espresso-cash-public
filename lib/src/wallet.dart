import 'package:solana/solana.dart';
import 'package:solana/src/encoder/encoder.dart';
import 'package:solana/src/hd_keypair.dart';
import 'package:solana/src/spl_token/associated_account.dart';
import 'package:solana/src/spl_token/spl_token.dart';
import 'package:solana/src/spl_token/token_amount.dart';
import 'package:solana/src/system_program/system_program.dart';
import 'package:solana/src/types/signature_status.dart';
import 'package:solana/src/types/tx_signature.dart';

/// Convenient object for common operations
class Wallet {
  Wallet({
    required this.signer,
    required RPCClient rpcClient,
  })  : _rpcClient = rpcClient,
        _tokens = <String, _TokenInfo>{};

  Future<TxSignature> _genericTransfer({
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
  Future<_TokenInfo> loadToken({required String mint}) async {
    late final _TokenInfo tokenInfo;
    if (_tokens.containsKey(mint)) {
      throw const FormatException('token already added to this wallet');
    }
    final token = await SplToken.readonly(mint: mint, rpcClient: _rpcClient);
    final associatedTokenAddress = await token.getAssociatedTokenAddress(
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
    return tokenInfo;
  }

  /// Creates a solana transfer message to send [lamports] SOL tokens from [source]
  /// to [destination].
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<TxSignature> transfer({
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
  Future<TxSignature> transferWithMemo({
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
  Future<TxSignature> requestAirdrop(
    int amount, {
    Commitment? commitment,
  }) async {
    final signature = await _rpcClient.requestAirdrop(
      address,
      amount,
      commitment: commitment,
    );
    await _rpcClient.waitForSignatureStatus(
      signature,
      commitment ?? TxStatus.finalized,
    );

    return signature;
  }

  Future<TxSignature>? transferToken({
    required String mint,
    required String destination,
    required int amount,
    Commitment? commitment,
  }) async {
    if (!hasAssociatedTokenAccount(mint: mint)) {
      throw const FormatException(
          'this wallet has no associated token account');
    }
    final tokenInfo = getTokenInfoOrThrow(mint);
    final token = tokenInfo.token;

    return token.transfer(
      source: address,
      amount: amount,
      destination: destination,
      owner: signer,
    );
  }

  Future<AssociatedTokenAccount> createAssociatedTokenAccount({
    required String mint,
  }) async {
    final tokenInfo = getTokenInfoOrThrow(mint);
    final token = tokenInfo.token;
    final associatedTokenAccount = await token.createAssociatedAccount(
      funder: signer,
    );
    _tokens[mint] = _TokenInfo(
      token: token,
      associatedAddress: associatedTokenAccount.address,
      account: associatedTokenAccount,
    );
    return associatedTokenAccount;
  }

  bool hasAssociatedTokenAccount({
    required String mint,
  }) {
    final tokenInfo = _tokens[mint];
    if (tokenInfo == null) {
      return false;
    }
    return tokenInfo.hasAssociatedAccount;
  }

  String getAssociatedTokenAccountAddress({
    required String mint,
  }) {
    final tokenInfo = getTokenInfoOrThrow(mint);
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
    final tokenInfo = getTokenInfoOrThrow(mint);
    final token = tokenInfo.token;
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

  _TokenInfo getTokenInfoOrThrow(String mint) {
    final tokenInfo = _tokens[mint];
    if (tokenInfo == null) {
      throw StateError('invalid state, token info must exist at this point');
    }
    return tokenInfo;
  }

  String get address => signer.address;

  final HDKeyPair signer;
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
