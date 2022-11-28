import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:cryptoplease_link/src/constants.dart';
import 'package:cryptoplease_link/src/swap/jupiter_repository.dart';
import 'package:dfunc/dfunc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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
      ),
      _repository.getUsdcPrice(),
    ]);
    final route = responses.first as RouteInfo;
    final price = responses.last as double;

    final fee = _convert(route.totalFees, price);

    final feePayer = _platform.publicKey;
    final feeIx = await _createSwapFeePayment(
      aSender: aSender,
      aReceiver: feePayer,
      amount: fee,
    );

    final message = route.jupiterTx
        .let(SignedTx.decode)
        .let((tx) => tx.message)
        .let((message) => message.changeAtaIxsFunder(_platform.publicKey))
        .let((message) => message.addInstruction(feeIx));

    final recentBlockhash = await _client.rpcClient.getRecentBlockhash(
      commitment: commitment,
    );
    final compiled = message.compile(
      recentBlockhash: recentBlockhash.blockhash,
      feePayer: feePayer,
    );

    final tx = SignedTx(
      messageBytes: compiled.data,
      signatures: [
        await _platform.sign(compiled.data),
        Signature(List.filled(64, 0), publicKey: aSender),
      ],
    );

    return SwapTransaction(
      amount: amount,
      inAmount: route.inAmount,
      outAmount: route.outAmount,
      fee: fee,
      transaction: tx,
    );
  }
}

extension on Message {
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
    (amountInSol * price / solDecimals * usdcDecimals).round();
