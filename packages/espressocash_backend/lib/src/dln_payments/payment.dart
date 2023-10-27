import 'package:convert/convert.dart';
import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:espressocash_backend/src/constants.dart';
import 'package:espressocash_backend/src/dln_payments/dln_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

part 'payment.freezed.dart';

@freezed
class QuoteTransaction with _$QuoteTransaction {
  const factory QuoteTransaction({
    required String senderDeductAmount,
    required String receiverAmount,
    required int fee,
    required SignedTx transaction,
    required BigInt slot,
  }) = _QuoteTransaction;
}

class DlnPayment {
  DlnPayment({
    required SolanaClient client,
    required DlnRepository repository,
    required Ed25519HDKeyPair platform,
  })  : _client = client,
        _repository = repository,
        _platform = platform;

  final SolanaClient _client;
  final DlnRepository _repository;
  final Ed25519HDKeyPair _platform;

  Future<QuoteTransaction> call({
    required String amount,
    required String senderAddress,
    required String receiverAddress,
    required Commitment commitment,
    required String receiverChain,
  }) async {
    final senderAccount = Ed25519HDPublicKey.fromBase58(senderAddress);

    final chain = _fromString(receiverChain);

    if (chain == null) {
      throw ArgumentError.value(
        receiverChain,
        'receiverChain',
        'Invalid chain',
      );
    }

    final quote = await _repository.getQuoteAndTransaction(
      amount: amount,
      senderAddress: _platform.address,
      receiverAddress: receiverAddress,
      receiverChain: chain,
    );

    final dlnTx = SignedTx.fromBytes(hex.decode(quote.tx.replaceAll('0x', '')));

    final addressTableLookups = dlnTx.compiledMessage.map(
      legacy: (_) => <MessageAddressTableLookup>[],
      v0: (v0) => v0.addressTableLookups,
    );

    final lookUpTables = await _client.rpcClient
        .getAddressLookUpTableAccounts(addressTableLookups);

    final dlnMessage = dlnTx.let(
      (tx) => tx.decompileMessage(addressLookupTableAccounts: lookUpTables),
    );

    final senderDeductAmount = int.parse(quote.senderDeductAmount);
    final totalTransferAmount = crossChainPaymentFee + senderDeductAmount;

    final feePayer = _platform.publicKey;
    final feeIx = await _createTransferPayment(
      aSender: senderAccount,
      aReceiver: feePayer,
      amount: totalTransferAmount,
    );

    final message = dlnMessage.let((m) => m.addToFirstInstruction(feeIx));

    final latestBlockhash = await _client.rpcClient.getLatestBlockhash(
      commitment: commitment,
    );

    final compiled = message.compileV0(
      recentBlockhash: latestBlockhash.value.blockhash,
      feePayer: feePayer,
      addressLookupTableAccounts: lookUpTables,
    );

    final tx = SignedTx(
      compiledMessage: compiled,
      signatures: [
        await _platform.sign(compiled.toByteArray()),
        Signature(List.filled(64, 0), publicKey: senderAccount),
      ],
    );

    final fees = quote.totalFees.toInt();

    return QuoteTransaction(
      senderDeductAmount: quote.senderDeductAmount,
      receiverAmount: quote.receiverAmount,
      fee: fees,
      transaction: tx,
      slot: latestBlockhash.context.slot,
    );
  }
}

extension on Message {
  Message addToFirstInstruction(Instruction ix) =>
      Message(instructions: [ix, ...instructions]);
}

Future<Instruction> _createTransferPayment({
  required Ed25519HDPublicKey aReceiver,
  required Ed25519HDPublicKey aSender,
  required int amount,
}) async {
  final mint = mainnetUsdc;

  final ataSender = await findAssociatedTokenAddress(
    owner: aSender,
    mint: mint,
  );

  final ataReceiver = await findAssociatedTokenAddress(
    owner: aReceiver,
    mint: mint,
  );

  return TokenInstruction.transfer(
    amount: amount,
    source: ataSender,
    destination: ataReceiver,
    owner: aSender,
  );
}

DlnChains? _fromString(String chain) => switch (chain) {
      'arbitrum' => DlnChains.arbitrum,
      'avalanche' => DlnChains.avalanche,
      'bnb' => DlnChains.bnb,
      'ethereum' => DlnChains.ethereum,
      'polygon' => DlnChains.polygon,
      'solana' => DlnChains.solana,
      'linea' => DlnChains.linea,
      'base' => DlnChains.base,
      'optimism' => DlnChains.optimism,
      _ => null,
    };
