// ignore_for_file: prefer-typedefs-for-callbacks

part of 'client.dart';

extension RpcClientExt on RpcClient {
  Future<TransactionId> signAndSendTransaction(
    Message message,
    List<Ed25519HDKeyPair> signers, {
    FutureOr<void> Function(Signature signature)? onSigned,
    Commitment commitment = Commitment.finalized,
  }) async {
    final bh = await getLatestBlockhash(commitment: commitment).value;

    final signedTx = await signTransaction(bh, message, signers);

    if (onSigned != null) {
      await onSigned(signedTx.signatures.first);
    }

    return sendTransaction(
      signedTx.encode(),
      preflightCommitment: commitment,
    );
  }

  Future<SignedTx> signMessage(
    Message message,
    List<Ed25519HDKeyPair> signers, {
    LatestBlockhash? blockhash,
    Commitment commitment = Commitment.finalized,
  }) async {
    final latestBlockhash =
        blockhash ?? await getLatestBlockhash(commitment: commitment).value;

    return signTransaction(latestBlockhash, message, signers);
  }

  /// Get the [limit] most recent transactions for the [address] account
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<Iterable<TransactionDetails>> getTransactionsList(
    Ed25519HDPublicKey address, {
    int limit = 10,
    String? before,
    String? until,
    Commitment? commitment,
    Encoding? encoding,
    // ignore: avoid-nullable-parameters-with-default-values, null has a meaning here
    num? maxSupportedTransactionVersion = 0,
    num? minContextSlot,
  }) async {
    final signatures = await getSignaturesForAddress(
      address.toBase58(),
      limit: limit,
      before: before,
      until: until,
      commitment: commitment,
      minContextSlot: minContextSlot,
    );

    if (signatures.isEmpty) return [];

    return getMultipleTransactions(
      signatures,
      commitment: commitment,
      encoding: encoding ?? Encoding.jsonParsed,
      maxSupportedTransactionVersion: maxSupportedTransactionVersion,
    );
  }

  /// Get multiple transactions for multiple addresses in 1 call.
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<List<TransactionDetails>> getTransactionListForAddresses(
    List<Ed25519HDPublicKey> addresses, {
    int limit = 10,
    String? before,
    String? until,
    Commitment? commitment,
    Encoding? encoding,
    // ignore: avoid-nullable-parameters-with-default-values, null has a meaning here
    num? maxSupportedTransactionVersion = 0,
    num? minContextSlot,
  }) async {
    final signatures = await getMultipleSignaturesForAddresses(
      addresses,
      limit: limit,
      before: before,
      until: until,
      commitment: commitment,
      minContextSlot: minContextSlot,
    );

    final allSignatures = signatures.expand((s) => s).toList();
    if (allSignatures.isEmpty) return [];

    return getMultipleTransactions(
      allSignatures,
      commitment: commitment,
      encoding: encoding ?? Encoding.jsonParsed,
      maxSupportedTransactionVersion: maxSupportedTransactionVersion,
    );
  }

  /// Get multiple signatures for multiple addresses in 1 call.
  /// The parameters are "passed as is"
  /// to the internal call to [RpcClient.getSignaturesForAddress()]
  Future<List<List<TransactionSignatureInformation>>>
      getMultipleSignaturesForAddresses(
    List<Ed25519HDPublicKey> addresses, {
    int limit = 10,
    String? before,
    String? until,
    Commitment? commitment,
    num? minContextSlot,
  }) async {
    final response = await _jsonRpcClient.bulkRequest(
      'getSignaturesForAddress',
      addresses
          .map(
            (address) => [
              address.toBase58(),
              GetSignaturesForAddressConfig(
                limit: limit,
                before: before,
                until: until,
                commitment: commitment,
                minContextSlot: minContextSlot,
              ).toJson(),
            ],
          )
          .toList(),
    );

    return response
        .map<List<TransactionSignatureInformation>>((dynamic result) {
      if (result == null) return [];
      final data = getResult(result);
      if (data == null) return [];
      if (data is! List) return [];

      return data
          .map(
            (dynamic s) => TransactionSignatureInformation.fromJson(
              s as Map<String, dynamic>,
            ),
          )
          .toList();
    }).toList();
  }

  /// Get multiple transactions in 1 call.
  ///
  /// Gets one transaction for each signature in the [signatures] list.
  ///
  /// The [encoding] and [commitment] parameters are "passed as is"
  /// to the internal call to [RpcClient.getTransaction()]
  Future<List<TransactionDetails>> getMultipleTransactions(
    List<TransactionSignatureInformation> signatures, {
    Commitment? commitment,
    Encoding? encoding,
    // ignore: avoid-nullable-parameters-with-default-values, null has a meaning here
    num? maxSupportedTransactionVersion = 0,
  }) async {
    final response = await _jsonRpcClient.bulkRequest(
      'getTransaction',
      signatures
          .map(
            (s) => <dynamic>[
              s.signature,
              GetTransactionConfig(
                encoding: encoding,
                commitment: commitment,
                maxSupportedTransactionVersion: maxSupportedTransactionVersion,
              ).toJson(),
            ],
          )
          .toList(growable: false),
    );
    final Iterable<dynamic> transactions = response.map<dynamic>(getResult);

    return transactions
        .where((t) => t != null)
        .map(
          (dynamic t) => TransactionDetails.fromJson(t as Map<String, dynamic>),
        )
        .toList(growable: false);
  }

  Future<AddressLookupTableAccount> getAddressLookupTable(
    Ed25519HDPublicKey account,
  ) async {
    final accountInfo = await getAccountInfo(
      account.toBase58(),
      encoding: Encoding.base64,
    ).value;

    if (accountInfo == null) {
      throw const FormatException('Account not found');
    }

    final data = accountInfo.data;
    if (data == null) {
      throw const FormatException('Account data is null');
    }

    final input = ByteArray((data as BinaryAccountData).data);
    final decode = AddressLookupTableAccount.deserialize(input);

    return AddressLookupTableAccount(key: account, state: decode);
  }

  Future<List<AddressLookupTableAccount>> getAddressLookUpTableAccounts(
    List<MessageAddressTableLookup> addressTableLookups,
  ) =>
      Future.wait(
        addressTableLookups
            .map((lookup) async => getAddressLookupTable(lookup.accountKey))
            .toList(),
      );

  Future<Message> getMessageFromEncodedTx(String encodedTx) {
    final tx = SignedTx.decode(encodedTx);

    return tx.compiledMessage.map(
      legacy: (_) async => tx.decompileMessage(),
      v0: (compiledMessage) async {
        final addressTableLookups = compiledMessage.addressTableLookups;

        final lookUpTables =
            await getAddressLookUpTableAccounts(addressTableLookups);

        return tx.decompileMessage(addressLookupTableAccounts: lookUpTables);
      },
    );
  }
}
