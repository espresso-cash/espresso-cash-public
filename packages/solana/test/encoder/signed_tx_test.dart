import 'package:solana/base58.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/encoder/message_header.dart';
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
      final compiledMessage = message.compile(
        recentBlockhash: blockhash,
        feePayer: fundingAccount.publicKey,
      );

      final tx = SignedTx(
        compiledMessage: compiledMessage,
        signatures: [await fundingAccount.sign(compiledMessage.toByteArray())],
      );
      final encoded = tx.encode();

      final decoded = SignedTx.decode(encoded);

      expect(
        decoded.decompileMessage(),
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
        decoded.compiledMessage.accountKeys.map((a) => a.toBase58()),
        [
          fundingAccount.address,
          recipientAccount.address,
          SystemProgram.programId,
        ],
      );
      expect(decoded.version, TransactionVersion.legacy);
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

      final compiledMessage = message.compileV0(
        recentBlockhash: blockhash,
        feePayer: fundingAccount.publicKey,
      );

      final tx = SignedTx(
        compiledMessage: compiledMessage,
        signatures: [await fundingAccount.sign(compiledMessage.toByteArray())],
      );
      final encoded = tx.encode();

      final decoded = SignedTx.decode(encoded);

      expect(
        decoded.decompileMessage(),
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
      expect(decoded.version, TransactionVersion.v0);
      expect(
        decoded.compiledMessage.accountKeys.map((a) => a.toBase58()),
        [
          fundingAccount.address,
          recipientAccount.address,
          SystemProgram.programId,
        ],
      );
    });

    test('decompiles base64 tx v0 with address look up', () async {
      final payer = await Ed25519HDKeyPair.random();

      final keys = await createTestKeys(6);

      final instructions = [
        Instruction(
          programId: keys[3],
          accounts: [
            createAccountMeta(keys.first, true, true),
            createAccountMeta(keys[1], true, false),
            createAccountMeta(keys[2], false, true),
            createAccountMeta(keys[4], false, true),
            createAccountMeta(keys[5], false, false),
          ],
          data: ByteArray.u8(1),
        ),
        Instruction(
          programId: keys.first,
          accounts: const [],
          data: ByteArray.u8(2),
        ),
        Instruction(
          programId: keys[2],
          accounts: const [],
          data: ByteArray.u8(3),
        ),
      ];

      final message = Message(instructions: instructions);

      final addressLookupTableAccounts = [
        await createTestAddressLookUpTable(keys),
      ];

      final blockhash = base58encode(List.filled(32, 0));

      final compiledMessage = message.compileV0(
        recentBlockhash: blockhash,
        feePayer: payer.publicKey,
        addressLookupTableAccounts: addressLookupTableAccounts,
      );

      final tx = SignedTx(
        compiledMessage: compiledMessage,
        signatures: [await payer.sign(compiledMessage.toByteArray())],
      );
      final encoded = tx.encode();

      final decoded = SignedTx.decode(encoded);

      expect(
        decoded.decompileMessage(
          addressLookupTableAccounts: addressLookupTableAccounts,
        ),
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
      expect(decoded.version, TransactionVersion.v0);
    });

    test('decompiles base64 tx v0 with address look up (2)', () async {
      final keys = [
        await Ed25519HDKeyPair.random(),
        await Ed25519HDKeyPair.random(),
        await Ed25519HDKeyPair.random(),
        await Ed25519HDKeyPair.random(),
        await Ed25519HDKeyPair.random(),
        await Ed25519HDKeyPair.random(),
        await Ed25519HDKeyPair.random(),
      ];

      final payer = keys.first;

      final instructions = [
        Instruction(
          programId: keys[4].publicKey,
          accounts: [
            createAccountMeta(keys[1].publicKey, true, true),
            createAccountMeta(keys[2].publicKey, false, false),
            createAccountMeta(keys[3].publicKey, false, false),
          ],
          data: ByteArray.u8(1),
        ),
        Instruction(
          programId: keys[1].publicKey,
          accounts: [
            createAccountMeta(keys[2].publicKey, true, false),
            createAccountMeta(keys[3].publicKey, false, true),
          ],
          data: ByteArray.u8(2),
        ),
        Instruction(
          programId: keys[3].publicKey,
          accounts: [
            createAccountMeta(keys[5].publicKey, false, true),
            createAccountMeta(keys[6].publicKey, false, false),
          ],
          data: ByteArray.u8(3),
        ),
      ];

      final message = Message(instructions: instructions);

      final lookUpTable = await createTestAddressLookUpTable(
        keys.map((e) => e.publicKey).toList(),
      );

      final blockhash = base58encode(List.filled(32, 0));

      final compiledMessage = message.compileV0(
        recentBlockhash: blockhash,
        feePayer: payer.publicKey,
        addressLookupTableAccounts: [lookUpTable],
      );

      final tx = SignedTx(
        compiledMessage: compiledMessage,
        signatures: [await payer.sign(compiledMessage.toByteArray())],
      );
      final encoded = tx.encode();

      final decoded = SignedTx.decode(encoded);

      expect(
        decoded.decompileMessage(
          addressLookupTableAccounts: [lookUpTable],
        ),
        isA<Message>()
            .having((m) => m.instructions.length, 'number of instructions', 3)
            .having(
              (m) => m.instructions.first.accounts.length,
              'number of accounts in first instruction',
              3,
            ),
      );

      expect(decoded.signatures, tx.signatures);
      expect(decoded.blockhash, blockhash);
      expect(decoded.version, TransactionVersion.v0);

      expect(decoded.compiledMessage.accountKeys, [
        payer.publicKey,
        keys[1].publicKey,
        keys[2].publicKey,
        keys[3].publicKey,
        keys[4].publicKey,
      ]);

      const expectedHeader = MessageHeader(
        numRequiredSignatures: 3,
        numReadonlySignedAccounts: 1,
        numReadonlyUnsignedAccounts: 1,
      );

      expect(
        decoded.compiledMessage.header.numRequiredSignatures,
        expectedHeader.numRequiredSignatures,
      );

      expect(
        decoded.compiledMessage.header.numReadonlySignedAccounts,
        expectedHeader.numReadonlySignedAccounts,
      );

      expect(
        decoded.compiledMessage.header.numReadonlyUnsignedAccounts,
        expectedHeader.numReadonlyUnsignedAccounts,
      );

      final expectedAddressTableLookUp = MessageAddressTableLookup(
        accountKey: lookUpTable.key,
        writableIndexes: [5],
        readonlyIndexes: [6],
      );

      final decodedMessage = decoded.compiledMessage as CompiledMessageV0;

      expect(
        decodedMessage.addressTableLookups.first.accountKey,
        expectedAddressTableLookUp.accountKey,
      );
      expect(
        decodedMessage.addressTableLookups.first.writableIndexes,
        expectedAddressTableLookUp.writableIndexes,
      );
      expect(
        decodedMessage.addressTableLookups.first.readonlyIndexes,
        expectedAddressTableLookUp.readonlyIndexes,
      );

      final expectedInstructions = [
        CompiledInstruction(
          programIdIndex: 4,
          accountKeyIndexes: [1, 2, 3],
          data: ByteArray.u8(1),
        ),
        CompiledInstruction(
          programIdIndex: 1,
          accountKeyIndexes: [2, 3],
          data: ByteArray.u8(2),
        ),
        CompiledInstruction(
          programIdIndex: 3,
          accountKeyIndexes: [5, 6],
          data: ByteArray.u8(3),
        ),
      ];

      expect(decodedMessage.instructions, expectedInstructions);
    });
  });
}
