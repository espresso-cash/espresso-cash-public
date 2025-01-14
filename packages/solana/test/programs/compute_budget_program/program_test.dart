// ignore_for_file: avoid-non-null-assertion

import 'dart:convert' hide Encoding;

import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:test/test.dart';

import '../../config.dart';

void main() {
  final client = createTestSolanaClient();

  test('SetComputeUnitPrice', () async {
    const commitment = Commitment.confirmed;
    final sender = await Ed25519HDKeyPair.random();
    final receiver = await Ed25519HDKeyPair.random();
    await client.requestAirdrop(
      address: sender.publicKey,
      lamports: 10 * lamportsPerSol,
      commitment: commitment,
    );

    final sendInstruction = SystemInstruction.transfer(
      fundingAccount: sender.publicKey,
      recipientAccount: receiver.publicKey,
      lamports: lamportsPerSol,
    );
    final bh = await client.rpcClient
        .getLatestBlockhash(commitment: commitment)
        .then((value) => value.value.blockhash);
    Message message = Message(instructions: [sendInstruction]);
    CompiledMessage compiledMessage = message.compile(
      recentBlockhash: bh,
      feePayer: sender.publicKey,
    );

    final feeWithoutComputeUnitPrice = await client.rpcClient.getFeeForMessage(
      base64Encode(compiledMessage.toByteArray().toList()),
      commitment: commitment,
    );

    const unitPriceMicroLamports = 1000;
    const computeUnitLimit = 200000;

    message = message.copyWith(
      instructions: [
        ...message.instructions,
        ComputeBudgetInstruction.setComputeUnitLimit(units: computeUnitLimit),
        ComputeBudgetInstruction.setComputeUnitPrice(
          microLamports: unitPriceMicroLamports,
        ),
      ],
    );
    compiledMessage = message.compile(
      recentBlockhash: bh,
      feePayer: sender.publicKey,
    );

    final feeWithComputeUnitPrice = await client.rpcClient.getFeeForMessage(
      base64Encode(compiledMessage.toByteArray().toList()),
      commitment: commitment,
    );

    const micro = 1000000;
    expect(
      feeWithComputeUnitPrice! - feeWithoutComputeUnitPrice!,
      (computeUnitLimit * unitPriceMicroLamports) ~/ micro,
    );
  });
}
