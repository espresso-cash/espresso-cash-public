import 'package:solana/base58.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/base58/base58.dart';
import 'package:solana/src/encoder/message/message_v0.dart';
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

      final compiledMessage =
          message.compile(recentBlockhash: base58encode(List.filled(32, 0)));
      final decompiledMessage = Message.decompile(compiledMessage);

      expect(decompiledMessage, message);
    });
  });

  group('v0', () {
    // test('numAccountKeysFromLookups', () {
    //   final message = Messagev0(instructions: instructions);
    // });

    test('decompiles messagev0', () async {
      // final fundingAccount = await Ed25519HDKeyPair.random();
      // final recipientAccount = await Ed25519HDKeyPair.random();
      final keys = await createTestKeys(7);

      final addressLookupTableAccounts = [
        await createTestAddressLookUpTable(keys)
      ];

      final payer = keys[0];

      final message = Messagev0(
        instructions: [
          Instruction(
            programId: keys[4],
            accounts: [
              AccountMeta(
                pubKey: keys[1],
                isWriteable: true,
                isSigner: true,
              ),
              AccountMeta(
                pubKey: keys[2],
                isWriteable: true,
                isSigner: false,
              ),
              AccountMeta(
                pubKey: keys[3],
                isWriteable: false,
                isSigner: true,
              ),
              AccountMeta(
                pubKey: keys[5],
                isWriteable: false,
                isSigner: true,
              ),
              AccountMeta(
                pubKey: keys[6],
                isWriteable: false,
                isSigner: false,
              ),
            ],
            data: const ByteArray.empty(),
          ),
          Instruction(
            programId: keys[1],
            accounts: [],
            data: const ByteArray.empty(),
          ),
          Instruction(
            programId: keys[3],
            accounts: [],
            data: const ByteArray.empty(),
          ),
        ],
      );

      final compiledMessage = message.compile(
        recentBlockhash: base58encode(List.filled(32, 0)),
        feePayer: keys[2],
        addressLookupTableAccounts: addressLookupTableAccounts,
      );
      final decompiledMessage = Messagev0.decompile(compiledMessage);

      expect(decompiledMessage, message);
    });
  });
}
