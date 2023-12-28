import 'package:solana/encoder.dart';
import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/encoder/message/message_account_keys.dart';
import 'package:test/test.dart';

import '../util.dart';

void main() {
  test('Key segments', () async {
    final keys = await createTestKeys(6);
    final staticAccountKeys = keys.getRange(0, 3).toList();
    final accountKeysFromLookups = LoadedAddresses(
      writable: [keys[3], keys[4]],
      readonly: [keys[5]],
    );

    final accountKeys = MessageAccountKeys(
      staticAccountKeys: staticAccountKeys,
      accountKeysFromLookups: accountKeysFromLookups,
    );

    final expectedSegments = [
      staticAccountKeys,
      accountKeysFromLookups.writable,
      accountKeysFromLookups.readonly,
    ];

    expect(accountKeys.keySegments(), expectedSegments);
  });

  test('Get Account Keys', () async {
    final keys = await createTestKeys(3);
    final accountKeys = MessageAccountKeys(staticAccountKeys: keys);

    // Get
    expect(accountKeys[0], keys.first);
    expect(accountKeys[1], keys[1]);
    expect(accountKeys[2], keys[2]);
    expect(accountKeys[3], null);

    // Length
    expect(accountKeys.length, 3);
  });

  test('Get with loaded address', () async {
    final keys = await createTestKeys(6);
    final staticAccountKeys = keys.getRange(0, 3).toList();
    final accountKeysFromLookups = LoadedAddresses(
      writable: [keys[3], keys[4]],
      readonly: [keys[5]],
    );

    final accountKeys = MessageAccountKeys(
      staticAccountKeys: staticAccountKeys,
      accountKeysFromLookups: accountKeysFromLookups,
    );

    // Get
    expect(accountKeys[0], keys.first);
    expect(accountKeys[1], keys[1]);
    expect(accountKeys[2], keys[2]);
    expect(accountKeys[3], keys[3]);
    expect(accountKeys[4], keys[4]);
    expect(accountKeys[5], keys[5]);

    // Length
    expect(accountKeys.length, 6);
  });

  test('Compile Instructions', () async {
    final keys = await createTestKeys(3);
    final staticAccountKeys = [keys.first];
    final accountKeysFromLookups = LoadedAddresses(
      writable: [keys[1]],
      readonly: [keys[2]],
    );

    final accountKeys = MessageAccountKeys(
      staticAccountKeys: staticAccountKeys,
      accountKeysFromLookups: accountKeysFromLookups,
    );

    final instruction = Instruction(
      programId: keys.first,
      accounts: [
        AccountMeta.writeable(pubKey: keys[1], isSigner: true),
        AccountMeta.writeable(pubKey: keys[2], isSigner: true),
      ],
      data: ByteArray.u8(0),
    );

    final compiled = accountKeys.compileInstructions([instruction]).first;

    final expected = CompiledInstruction(
      programIdIndex: 0,
      accountKeyIndexes: [1, 2],
      data: ByteArray.u8(0),
    );

    expect(compiled.programIdIndex, expected.programIdIndex);
    expect(compiled.accountKeyIndexes, expected.accountKeyIndexes);
    expect(compiled.data, expected.data);
  });

  test('Compile instructions with unknown key', () async {
    final keys = await createTestKeys(3);
    final staticAccountKeys = [keys.first];
    final accountKeysFromLookups = LoadedAddresses(
      writable: [keys[1]],
      readonly: [keys[2]],
    );

    final accountKeys = MessageAccountKeys(
      staticAccountKeys: staticAccountKeys,
      accountKeysFromLookups: accountKeysFromLookups,
    );

    final unknown = await Ed25519HDKeyPair.random();

    final instructions = [
      Instruction(
        programId: unknown.publicKey,
        accounts: const [],
        data: ByteArray.u8(0),
      ),
      Instruction(
        programId: keys.first,
        accounts: [
          AccountMeta.writeable(pubKey: keys[1], isSigner: true),
          AccountMeta.writeable(pubKey: unknown.publicKey, isSigner: true),
        ],
        data: ByteArray.u8(0),
      ),
    ];

    for (final instruction in instructions) {
      expect(
        () => accountKeys.compileInstructions([instruction]),
        throwsException,
      );
    }
  });

  test('Expect overflow', () async {
    final keys = await createTestKeys(257);
    final staticAccountKeys = keys.getRange(0, 256).toList();
    final accountKeysFromLookups = LoadedAddresses(
      writable: [keys[256]],
      readonly: [],
    );

    final accountKeys = MessageAccountKeys(
      staticAccountKeys: staticAccountKeys,
      accountKeysFromLookups: accountKeysFromLookups,
    );

    expect(
      () => accountKeys.compileInstructions([]),
      throwsException,
    );
  });
}
