import 'package:solana/encoder.dart';
import 'package:solana/src/base58/base58.dart';
import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/programs/system_program/program.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('decompiles message', () async {
    final fundingAccount = await Ed25519HDKeyPair.random();
    final recipientAccount = await Ed25519HDKeyPair.random();

    final message = Message.only(
      SystemInstruction.transfer(
        fundingAccount: fundingAccount.publicKey,
        recipientAccount: recipientAccount.publicKey,
        lamports: 1000,
      ),
    );

    final compiledMessage =
        message.compile(recentBlockhash: base58encode(List.filled(32, 0)));
    final decompiledMessage = Message.decompile(compiledMessage);

    expect(decompiledMessage, message);
  });
}
