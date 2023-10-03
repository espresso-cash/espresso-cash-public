import 'package:solana/base58.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/base58/base58.dart';
import 'package:solana/src/encoder/byte_array.dart';
import 'package:solana/src/encoder/instruction.dart';
import 'package:test/test.dart';

import 'util.dart';

void main() {
  group('legacy', () {
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

      final compiledMessage = message.compile(
        recentBlockhash: base58encode(List.filled(32, 0)),
        feePayer: fundingAccount.publicKey,
      );
      final decompiledMessage = Message.decompile(compiledMessage);

      expect(decompiledMessage.instructions.length, 1);
    });
  });

  group('v0', () {
    test('decompiles message v0', () async {
      final fundingAccount = await Ed25519HDKeyPair.random();
      final recipientAccount = await Ed25519HDKeyPair.random();
      final payer = await Ed25519HDKeyPair.random();

      final instruction = SystemInstruction.transfer(
        fundingAccount: fundingAccount.publicKey,
        recipientAccount: recipientAccount.publicKey,
        lamports: 1000,
      );

      final message = Message.only(instruction);

      final compiledMessage = message.compileV0(
        recentBlockhash: base58encode(List.filled(32, 0)),
        feePayer: payer.publicKey,
      );

      final decompiledMessage = Message.decompile(compiledMessage);

      expect(decompiledMessage.instructions.length, 1);
    });

    test('decompiles messagev0 with address look up', () async {
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
        Instruction(
          programId: keys[1],
          accounts: const [],
          data: ByteArray.u8(2),
        ),
        Instruction(
          programId: keys[3],
          accounts: const [],
          data: ByteArray.u8(3),
        ),
      ];

      final message = Message(instructions: instructions);

      final addressLookupTableAccounts = [
        await createTestAddressLookUpTable(keys),
      ];

      final compiledMessage = message.compileV0(
        recentBlockhash: base58encode(List.filled(32, 0)),
        feePayer: payer,
        addressLookupTableAccounts: addressLookupTableAccounts,
      );

      expect(
        () => Message.decompile(compiledMessage),
        throwsException,
      );

      final decompiledMessage = Message.decompile(
        compiledMessage,
        addressLookupTableAccounts: addressLookupTableAccounts,
      );

      expect(decompiledMessage.instructions, instructions);
    });
  });
}
