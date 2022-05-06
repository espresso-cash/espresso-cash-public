import 'package:solana/base58.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:test/test.dart';

Future<void> main() async {
  final fundingAccount = await Ed25519HDKeyPair.random();
  final recipientAccount = await Ed25519HDKeyPair.random();

  final message = Message.only(
    SystemInstruction.transfer(
      fundingAccount: fundingAccount.publicKey,
      recipientAccount: recipientAccount.publicKey,
      lamports: 1000,
    ),
  );

  test('Returns correct required signature count', () {
    final compiledMessage = message.compile(
      recentBlockhash: base58encode([0, 0, 0]),
    );

    expect(compiledMessage.requiredSignatureCount, 1);
  });

  test('Creates compiled message from signed tx', () async {
    final compiledMessage = message.compile(
      recentBlockhash: base58encode([0, 0, 0]),
    );
    final signedTx = SignedTx(
      messageBytes: compiledMessage.data,
      signatures: [await fundingAccount.sign(compiledMessage.data)],
    );

    final fromSigned =
        CompiledMessage.fromSignedTransaction(signedTx.toByteArray());

    expect(compiledMessage, fromSigned);
  });
}
