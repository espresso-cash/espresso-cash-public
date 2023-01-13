import 'package:solana/encoder.dart';
import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/encoder/message/account_keys.dart';
import 'package:test/test.dart';

import 'util.dart';

Future<void> main() async {
  test('key segments', () async {
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

  test('get', () async {
    final keys = await createTestKeys(3);
    final accountKeys = MessageAccountKeys(staticAccountKeys: keys);

    // Get
    expect(accountKeys.get(0), keys.first);
    expect(accountKeys.get(1), keys[1]);
    expect(accountKeys.get(2), keys[2]);
    expect(accountKeys.get(3), null);

    // Length
    expect(accountKeys.length, 3);
  });

  test('get with loaded address', () async {
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
    expect(accountKeys.get(0), keys.first);
    expect(accountKeys.get(1), keys[1]);
    expect(accountKeys.get(2), keys[2]);
    expect(accountKeys.get(3), keys[3]);
    expect(accountKeys.get(4), keys[4]);
    expect(accountKeys.get(5), keys[5]);

    // Length
    expect(accountKeys.length, 6);
  });

  test('compile', () async {
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
        AccountMeta.writeable(pubKey: keys[2], isSigner: true)
      ],
      data: ByteArray.u8(0),
    );

    final compiled = accountKeys.compileInstructions([instruction]).first;

    final expected = MessageCompiledInstruction(
      programIdIndex: 0,
      accountKeyIndexes: [1, 2],
      data: ByteArray.u8(0),
    );

    expect(compiled.programIdIndex, expected.programIdIndex);
    expect(compiled.accountKeyIndexes, expected.accountKeyIndexes);
    expect(compiled.data, expected.data);
  });

  test('compileInstructions with unknown key', () async {
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
        accounts: [],
        data: ByteArray.u8(0),
      ),
      Instruction(
        programId: keys.first,
        accounts: [
          AccountMeta.writeable(pubKey: keys[1], isSigner: true),
          AccountMeta.writeable(pubKey: unknown.publicKey, isSigner: true)
        ],
        data: ByteArray.u8(0),
      )
    ];

    for (final instruction in instructions) {
      expect(
        () => accountKeys.compileInstructions([instruction]),
        throwsException,
      );
    }
  });

  test('overflow', () async {
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
