import 'dart:convert';

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

  test('decompiles base64 tx', () {
    const tx =
        'AVj7dxHlQ9IrvdYVIjuiRFs1jLaDMHixgrv+qtHBwz51L4/ImLZhszwiyEJDIp7xeBSpm/TX5B7mYzxa+fPOMw0BAAMFJMJVqLw+hJYheizSoYlLm53KzgT82cDVmazarqQKG2GQsLgiqktA+a+FDR4/7xnDX7rsusMwryYVUdixfz1B1Qan1RcZLwqvxvJl4/t3zHragsUp0L47E24tAFUgAAAABqfVFxjHdMkoVmOYaR1etoteuKObS21cc1VbIQAAAAAHYUgdNXR0u3xNdiTr072z2DVec9EQQ/wNo1OAAAAAAAtxOUhPBp2WSjUNJEgfvy70BbxI00fZyEPvFHNfxrtEAQQEAQIDADUCAAAAAQAAAAAAAACtAQAAAAAAAAdUE18R96XTJCe+YfRfUp6WP+YKCy/72ucOL8AoBFSpAA==';

    final txData = base64.decode(tx);
    final compiledMessage =
        CompiledMessage.fromSignedTransaction(ByteArray(txData));
    final decompiledMessage = Message.decompile(compiledMessage);

    expect(
      decompiledMessage,
      isA<Message>()
          .having((m) => m.instructions.length, 'number of instructions', 1)
          .having(
            (m) => m.instructions.first.accounts.length,
            'number of accounts in first instruction',
            4,
          ),
    );
  });
}
