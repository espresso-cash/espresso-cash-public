import 'package:solana/base58.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/encoder/byte_array.dart';
import 'package:solana/src/encoder/instruction.dart';
import 'package:solana/src/encoder/signed_tx.dart';
import 'package:test/test.dart';

import 'util.dart';

void main() {
  group('legacy', () {
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
  });

  group('v0', () {
    test('decompiles base64 tx v0', () async {
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

      final compiledMessage = message.compileToV0Message(
        recentBlockhash: blockhash,
        feePayer: fundingAccount.publicKey,
      );

      final tx = SignedTx(
        messageBytes: compiledMessage.data,
        signatures: [await fundingAccount.sign(compiledMessage.data)],
      );
      final encoded = tx.encode();

      final decoded = SignedTx.decode(encoded);

      expect(
        // decoded.message(),
        '', //TODO MESSAGE
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
    });

    test('decompiles base64 tx v0 with address look up', () async {
      final payer = await Ed25519HDKeyPair.random();

      final keys = await createTestKeys(6);

      final instructions = [
        Instruction(
          programId: keys[3],
          accounts: [
            createAccountMeta(keys[0], true, true),
            createAccountMeta(keys[1], true, false),
            createAccountMeta(keys[2], false, true),
            createAccountMeta(keys[4], false, true),
            createAccountMeta(keys[5], false, false),
          ],
          data: ByteArray.u8(1),
        ),
        Instruction(
          programId: keys[0],
          accounts: [],
          data: ByteArray.u8(2),
        ),
        Instruction(
          programId: keys[2],
          accounts: [],
          data: ByteArray.u8(3),
        ),
      ];

      final message = Message(instructions: instructions);

      final addressLookupTableAccounts = [
        await createTestAddressLookUpTable(keys)
      ];

      final blockhash = base58encode(List.filled(32, 0));

      final compiledMessage = message.compileToV0Message(
        recentBlockhash: blockhash,
        feePayer: payer.publicKey,
        addressLookupTableAccounts: addressLookupTableAccounts,
      );

      final tx = SignedTx(
        messageBytes: compiledMessage.data,
        signatures: [await payer.sign(compiledMessage.data)],
      );
      final encoded = tx.encode();

      final decoded = SignedTx.decode(encoded);

      expect(
        // decoded.message(addressLookupTableAccounts: addressLookupTableAccounts),
        '', //TODO MESSAGE
        isA<Message>()
            .having((m) => m.instructions.length, 'number of instructions', 3)
            .having(
              (m) => m.instructions.first.accounts.length,
              'number of accounts in first instruction',
              5,
            ),
      );

      expect(decoded.signatures, tx.signatures);
      expect(decoded.blockhash, blockhash);
    });
  });
}
