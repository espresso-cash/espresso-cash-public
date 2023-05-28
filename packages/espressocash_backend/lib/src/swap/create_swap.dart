import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:espressocash_backend/src/constants.dart';
import 'package:espressocash_backend/src/swap/jupiter_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sentry/sentry.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

part 'create_swap.freezed.dart';

@freezed
class SwapTransaction with _$SwapTransaction {
  const factory SwapTransaction({
    required String amount,
    required String inAmount,
    required String outAmount,
    required int fee,
    required SignedTx transaction,
    required BigInt slot,
  }) = _SwapTransaction;
}

class CreateSwap {
  CreateSwap({
    required SolanaClient client,
    required JupiterRepository repository,
    required Ed25519HDKeyPair platform,
  })  : _client = client,
        _repository = repository,
        _platform = platform;

  final SolanaClient _client;
  final JupiterRepository _repository;
  final Ed25519HDKeyPair _platform;

  Future<SwapTransaction> call({
    required String amount,
    required String inputToken,
    required String outputToken,
    required int slippage,
    required SwapMode mode,
    required bool asLegacyTx,
    required Ed25519HDPublicKey aSender,
    required Commitment commitment,
  }) async {
    final responses = await Future.wait([
      _repository.getJupiterRouteAndTransaction(
        amount: amount,
        inputToken: inputToken,
        outputToken: outputToken,
        slippageBps: slippage,
        swapMode: mode,
        account: aSender.toBase58(),
        asLegacyTransaction: asLegacyTx,
      ),
      _repository.getUsdcPrice(),
    ]);
    // ignore: cast_nullable_to_non_nullable, required info
    final route = responses.first as RouteInfo;
    final price = responses.last as double?;

    if (price == null) {
      throw Exception(
        'Could not fetch price.',
      );
    }

    final jupiterTx = route.jupiterTx.let(SignedTx.decode);

    final addressTableLookups = jupiterTx.compiledMessage.map(
      legacy: (_) => <MessageAddressTableLookup>[],
      v0: (v0) => v0.addressTableLookups,
    );

    final lookUpTables = await _client.rpcClient
        .getAddressLookUpTableAccounts(addressTableLookups);

    final jupiterMessage = jupiterTx.let(
      (tx) => tx.decompileMessage(addressLookupTableAccounts: lookUpTables),
    );

    final nonClosedAtaCount =
        jupiterMessage.createAtaCount() - jupiterMessage.closeAccountCount();

    if (nonClosedAtaCount < 0) {
      throw Exception(
        'Invalid transaction: more ATA accounts closed than created',
      );
    }

    final feesFromTransaction = sum([
      lamportsPerSignature * 2,
      nonClosedAtaCount * tokenProgramRent,
    ]);

    final feesFromJupiter = route.totalFees + lamportsPerSignature;

    if (feesFromJupiter != feesFromTransaction) {
      await Sentry.captureEvent(
        SentryEvent(
          level: SentryLevel.warning,
          message: const SentryMessage(
            'Fees from Jupiter and transaction do not match.',
          ),
          extra: {
            'feesFromTransaction': feesFromTransaction,
            'feesFromJupiter': feesFromJupiter,
            'inputToken': inputToken,
            'outputToken': outputToken,
          },
        ),
      );
    }

    final fee = maxBy<int, int>(
      [
        _convert(feesFromTransaction, price),
        _convert(feesFromJupiter, price),
        minimumSwapFee,
      ],
      identity,
    );

    if (fee == null) {
      throw StateError('Could not calculate fee');
    }

    final feePayer = _platform.publicKey;
    final feeIx = await _createSwapFeePayment(
      aSender: aSender,
      aReceiver: feePayer,
      amount: fee,
    );

    final wrappedSolAccount =
        await findAssociatedTokenAddress(owner: aSender, mint: wrappedSol);

    final message = jupiterMessage
        .let((m) => m.changeAtaIxsFunder(_platform.publicKey))
        .let(
          (m) => m.changeCloseAccountDestination(
            platform: _platform.publicKey,
            wrappedSolAccount: wrappedSolAccount,
            sender: aSender,
          ),
        )
        .let((m) => m.addInstruction(feeIx));

    final latestBlockhash = await _client.rpcClient.getLatestBlockhash(
      commitment: commitment,
    );
    final compiled = asLegacyTx
        ? message.compile(
            recentBlockhash: latestBlockhash.value.blockhash,
            feePayer: feePayer,
          )
        : message.compileV0(
            recentBlockhash: latestBlockhash.value.blockhash,
            feePayer: feePayer,
            addressLookupTableAccounts: lookUpTables,
          );

    final tx = SignedTx(
      compiledMessage: compiled,
      signatures: [
        await _platform.sign(compiled.toByteArray()),
        Signature(List.filled(64, 0), publicKey: aSender),
      ],
    );

    return SwapTransaction(
      amount: amount,
      inAmount: route.inAmount,
      outAmount: route.outAmount,
      fee: fee,
      transaction: tx,
      slot: latestBlockhash.context.slot,
    );
  }
}

extension on Message {
  int createAtaCount() => instructions
      .where((ix) => ix.programId == AssociatedTokenAccountProgram.id)
      .length;

  int closeAccountCount() => instructions
      .where((ix) => ix.programId == TokenProgram.id)
      .where(
        (ix) => const DeepCollectionEquality().equals(
          ix.data,
          TokenProgram.closeAccountInstructionIndex,
        ),
      )
      .length;

  Message changeAtaIxsFunder(Ed25519HDPublicKey funder) {
    final instructions = this.instructions.map((ix) {
      if (ix.programId != AssociatedTokenAccountProgram.id) return ix;

      return Instruction(
        programId: ix.programId,
        accounts: [
          AccountMeta.writeable(pubKey: funder, isSigner: true),
          ...ix.accounts.skip(1),
        ],
        data: ix.data,
      );
    }).toList();

    return Message(instructions: instructions);
  }

  Message changeCloseAccountDestination({
    required Ed25519HDPublicKey platform,
    required Ed25519HDPublicKey wrappedSolAccount,
    required Ed25519HDPublicKey sender,
  }) {
    final instructions = this.instructions.expand((ix) {
      if (ix.programId != TokenProgram.id) return [ix];
      if (!const DeepCollectionEquality().equals(
        ix.data,
        TokenProgram.closeAccountInstructionIndex,
      )) return [ix];

      return ix.accounts.first.pubKey != wrappedSolAccount
          ? [
              Instruction(
                programId: ix.programId,
                accounts: [
                  ix.accounts.first,
                  AccountMeta.writeable(pubKey: platform, isSigner: false),
                  ...ix.accounts.skip(2),
                ],
                data: ix.data,
              ),
            ]
          : [
              ix,
              SystemInstruction.transfer(
                fundingAccount: sender,
                lamports: tokenProgramRent,
                recipientAccount: platform,
              ),
            ];
    }).toList();

    return Message(instructions: instructions);
  }

  Message addInstruction(Instruction ix) =>
      Message(instructions: [...instructions, ix]);
}

Future<Instruction> _createSwapFeePayment({
  required Ed25519HDPublicKey aReceiver,
  required Ed25519HDPublicKey aSender,
  required int amount,
}) async {
  // Swap fee is always paid in mainnet USDC
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

int _convert(num amountInSol, double price) =>
    (amountInSol * price / solDecimals * 100).ceil() * usdcDecimals ~/ 100;
