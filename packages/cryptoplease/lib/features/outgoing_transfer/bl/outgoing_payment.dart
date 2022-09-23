import 'package:collection/collection.dart';
import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/payments/direct_payments/direct_payment_fee_method.dart';
import 'package:cryptoplease/core/payments/split_key_payments/split_key_api_version.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/core/tokens/token_list.dart';
import 'package:cryptoplease/core/wallet.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

part 'outgoing_payment.freezed.dart';
part 'outgoing_payment.g.dart';

typedef OutgoingTransferId = String;

enum OutgoingTransferType { splitKey, direct }

enum OutgoingTransferTokenType { fungibleToken, nonFungibleToken }

@freezed
class OutgoingTransfer with _$OutgoingTransfer {
  const factory OutgoingTransfer.splitKey({
    required OutgoingTransferId id,
    required DateTime created,
    required int amount,
    required String tokenAddress,
    required OutgoingTransferState state,
    required IList<int> privateKey,
    @Default(OutgoingTransferTokenType.fungibleToken)
        OutgoingTransferTokenType tokenType,
    @Default(SplitKeyApiVersion.v1) SplitKeyApiVersion apiVersion,
    String? signature,
    Uri? firstLink,
  }) = OutgoingTransferSplitKey;

  const factory OutgoingTransfer.direct({
    required OutgoingTransferId id,
    required DateTime created,
    required String recipient,
    required int amount,
    required String tokenAddress,
    required OutgoingTransferState state,
    @Default(OutgoingTransferTokenType.fungibleToken)
        OutgoingTransferTokenType tokenType,
    @Default(DirectPaymentFeeMethod.v1) DirectPaymentFeeMethod feeMethod,
    String? reference,
    @Default(IListConst<String>([])) IList<String> references,
    String? memo,
    String? signature,
  }) = OutgoingTransferDirect;

  const OutgoingTransfer._();

  factory OutgoingTransfer.fromJson(Map<String, dynamic> json) =>
      _$OutgoingTransferFromJson(json);

  static Future<OutgoingTransferSplitKey> createSplitKeyTransfer({
    required int amount,
    required String tokenAddress,
    required OutgoingTransferTokenType tokenType,
    required SplitKeyApiVersion apiVersion,
  }) async {
    final recipient = await createRandomKeyPair();

    return OutgoingTransferSplitKey(
      id: const Uuid().v4().toString(),
      created: DateTime.now(),
      privateKey: (await recipient.extract()).bytes.lock,
      amount: amount,
      tokenAddress: tokenAddress,
      state: const OutgoingTransferState.draft(),
      tokenType: tokenType,
      apiVersion: apiVersion,
    );
  }

  static OutgoingTransferDirect createDirectTransfer({
    required String recipientAddress,
    required int amount,
    required String tokenAddress,
    required OutgoingTransferTokenType tokenType,
    DirectPaymentFeeMethod feeMethod = DirectPaymentFeeMethod.v1,
    String? memo,
    Iterable<Ed25519HDPublicKey>? reference,
    OutgoingTransferState state = const OutgoingTransferState.draft(),
  }) =>
      OutgoingTransferDirect(
        id: const Uuid().v4().toString(),
        created: DateTime.now(),
        recipient: recipientAddress,
        amount: amount,
        tokenAddress: tokenAddress,
        state: state,
        memo: memo,
        references: IList(reference?.map((e) => e.toBase58()) ?? []),
        tokenType: tokenType,
        feeMethod: feeMethod,
      );

  IList<String> get allReferences => this.map(
        splitKey: (_) => const IListConst([]),
        direct: (p) =>
            {p.reference, ...p.references}.whereNotNull().toList().lock,
      );

  String? get reference => this.map(
        splitKey: (_) => null,
        direct: (p) => p.reference,
      );

  String? get memo => this.map(splitKey: (_) => null, direct: (p) => p.memo);

  Future<Ed25519HDPublicKey> getRecipient() async => this.map(
        splitKey: (p) async {
          final recipient = await createKeyPairFromPrivateKey(
            p.privateKey.unlock,
          );

          return recipient.publicKey;
        },
        direct: (p) => Ed25519HDPublicKey.fromBase58(p.recipient),
      );
}

@freezed
class OutgoingTransferState with _$OutgoingTransferState {
  const factory OutgoingTransferState.draft({
    String? signature,
    String? encodedTx,
  }) = OutgoingTransferStateDraft;

  const factory OutgoingTransferState.ready() = OutgoingTransferStateReady;

  factory OutgoingTransferState.fromJson(Map<String, dynamic> json) =>
      _$OutgoingTransferStateFromJson(json);
}

extension OutgoingTransferExt on OutgoingTransfer {
  Amount get fee => calculateFee(
        this.map(
          splitKey: (p) => p.apiVersion,
          direct: (_) => SplitKeyApiVersion.v1,
        ),
        this.map(
          splitKey: always(OutgoingTransferType.splitKey),
          direct: always(OutgoingTransferType.direct),
        ),
        tokenAddress,
      );

  CryptoAmount toAmount() => CryptoAmount(
        value: amount,
        currency: CryptoCurrency(
          token: TokenList().findTokenByMint(tokenAddress) ??
              UnknownToken(address: tokenAddress),
        ),
      );
}

CryptoAmount calculateFee(
  SplitKeyApiVersion apiVersion,
  OutgoingTransferType paymentType,
  String tokenAddress,
) {
  if (apiVersion == SplitKeyApiVersion.v2) {
    return const CryptoAmount(value: 100000, currency: Currency.usdc);
  }

  // Base fee for the transaction;
  int fee = lamportsPerSignature;

  switch (paymentType) {
    case OutgoingTransferType.splitKey:
      // With Split Key payment, user will have to make additional
      // transaction to send the money from temporary account to their
      // account.
      fee += lamportsPerSignature;
      break;
    case OutgoingTransferType.direct:
      break;
  }

  if (tokenAddress != Token.sol.address) {
    // SPL Token accounts must remain rent-exempt for the duration of their
    // existence and therefore require a small amount of native SOL tokens
    // be deposited at account creation.
    fee += tokenProgramRent;

    switch (paymentType) {
      case OutgoingTransferType.splitKey:
        // With Split Key payment, user will probably have to create
        // associated account.
        fee += tokenProgramRent;
        break;
      case OutgoingTransferType.direct:
        break;
    }
  }

  return CryptoAmount(value: fee, currency: Currency.sol);
}
