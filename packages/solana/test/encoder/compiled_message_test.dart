import 'package:solana/base58.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:test/test.dart';

import 'util.dart';

Future<void> main() async {
  final fundingAccount = await Ed25519HDKeyPair.random();
  final recipientAccount = await Ed25519HDKeyPair.random();

  group('legacy', () {
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

    test('Returns correct transaction version', () {
      final compiledMessage = message.compile(
        recentBlockhash: base58encode([0, 0, 0]),
      );

      expect(compiledMessage.version, TransactionVersion.legacy);
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
  });

  group('v0', () {
    final message = Message.only(
      SystemInstruction.transfer(
        fundingAccount: fundingAccount.publicKey,
        recipientAccount: recipientAccount.publicKey,
        lamports: 1000,
      ),
    );

    test('Returns correct required signature count', () {
      final compiledMessage = message.compileToV0Message(
        recentBlockhash: base58encode([0, 0, 0]),
        feePayer: fundingAccount.publicKey,
      );

      expect(compiledMessage.requiredSignatureCount, 1);
    });

    test('Returns correct transaction version', () {
      final compiledMessage = message.compileToV0Message(
        recentBlockhash: base58encode([0, 0, 0]),
        feePayer: fundingAccount.publicKey,
      );

      expect(compiledMessage.version, TransactionVersion.v0);
    });

    test('Creates compiled message from signed tx', () async {
      final compiledMessage = message.compileToV0Message(
        recentBlockhash: base58encode([0, 0, 0]),
        feePayer: fundingAccount.publicKey,
      );
      final signedTx = SignedTx(
        messageBytes: compiledMessage.data,
        signatures: [await fundingAccount.sign(compiledMessage.data)],
      );

      final fromSigned =
          CompiledMessage.fromSignedTransaction(signedTx.toByteArray());

      expect(compiledMessage, fromSigned);
    });

    test('Compile with look up table', () async {
      final keys = await createTestKeys(7);
      final payer = keys.first;

      final instructions = [
        Instruction(
          programId: keys[4],
          accounts: [
            createAccountMeta(keys[1], true, true),
            createAccountMeta(keys[2], true, false),
            createAccountMeta(keys[3], false, true),
            createAccountMeta(keys[5], false, true),
            createAccountMeta(keys[6], false, false),
          ],
          data: ByteArray.u8(1),
        ),
      ];

      final message = Message(instructions: instructions);

      final addressLookupTableAccounts = [
        await createTestAddressLookUpTable(keys)
      ];

      final compiledMessage = message.compileToV0Message(
        recentBlockhash: base58encode(List.filled(32, 0)),
        feePayer: payer,
        addressLookupTableAccounts: addressLookupTableAccounts,
      );

      expect(compiledMessage.requiredSignatureCount, 3);
      expect(compiledMessage.version, TransactionVersion.v0);
    });
  });
}
