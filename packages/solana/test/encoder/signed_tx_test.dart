import 'package:solana/base58.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/encoder/signed_tx.dart';
import 'package:test/test.dart';

void main() {
  test('decompiles base64 tx', () async {
    final fundingAccount = await Ed25519HDKeyPair.random();
    final recipientAccount = await Ed25519HDKeyPair.random();

    final message = Message.only(
      SystemInstruction.transfer(
        fundingAccount: fundingAccount.publicKey,
        recipientAccount: recipientAccount.publicKey,
        lamports: 1000,
      ),
    );

    final blockhash = base58encode(List.filled(32, 0));
    final compiledMessage = message.compile(recentBlockhash: blockhash);

    final tx = SignedTx(
      messageBytes: compiledMessage.data,
      signatures: [await fundingAccount.sign(compiledMessage.data)],
    );
    final encoded = tx.encode();

    final decoded = SignedTx.decode(encoded);

    expect(
      decoded.message,
      isA<Message>()
          .having((m) => m.instructions.length, 'number of instructions', 1)
          .having(
            (m) => m.instructions.first.accounts.length,
            'number of accounts in first instruction',
            2,
          ),
    );

    expect(decoded.signatures, tx.signatures);
    expect(decoded.blockhash, blockhash);
    expect(
      decoded.accounts.map((a) => a.pubKey.toBase58()),
      [
        fundingAccount.address,
        recipientAccount.address,
        SystemProgram.programId,
      ],
    );
  });
}
