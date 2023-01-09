import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/encoder/message/compiled_keys.dart';
import 'package:test/test.dart';

import 'util.dart';

Future<void> main() async {
  test('compile', () async {
    final keys = await createTestKeys(6);
    final programIds = await createTestKeys(4);
    final payer = await Ed25519HDKeyPair.random();

    final compiledKeys = CompiledKeys.compile(
      payer: payer.publicKey,
      instructions: [
        Instruction(
          programId: programIds.first,
          accounts: [
            _createAccountMeta(keys.first, false, false),
            _createAccountMeta(keys[1], true, false),
            _createAccountMeta(keys[2], false, true),
            _createAccountMeta(keys[3], true, true),
            // duplicate the account metas
            _createAccountMeta(keys.first, false, false),
            _createAccountMeta(keys[1], true, false),
            _createAccountMeta(keys[2], false, true),
            _createAccountMeta(keys[3], true, true),
            // reference program ids
            _createAccountMeta(programIds.first, false, false),
            _createAccountMeta(programIds[1], true, false),
            _createAccountMeta(programIds[2], false, true),
            _createAccountMeta(programIds[3], true, true),
          ],
          data: ByteArray.u8(0),
        ),
        Instruction(
          programId: programIds[1],
          accounts: [],
          data: ByteArray.u8(0),
        ),
        Instruction(
          programId: programIds[2],
          accounts: [],
          data: ByteArray.u8(0),
        ),
        Instruction(
          programId: programIds[3],
          accounts: [],
          data: ByteArray.u8(0),
        ),
      ],
    );

    final Map<String, CompiledKeyMeta> map = {};

    _setMapEntry(map, payer.publicKey, true, true, false);
    _setMapEntry(map, keys.first, false, false, false);
    _setMapEntry(map, keys[1], true, false, false);
    _setMapEntry(map, keys[2], false, true, false);
    _setMapEntry(map, keys[3], true, true, false);
    _setMapEntry(map, programIds.first, false, false, true);
    _setMapEntry(map, programIds[1], true, false, true);
    _setMapEntry(map, programIds[2], false, true, true);
    _setMapEntry(map, programIds[3], true, true, true);

    expect(compiledKeys.keyMetaMap, map);
    expect(compiledKeys.payer, payer.publicKey);
  });

  test('compile with dup payer', () async {
    final payer = await Ed25519HDKeyPair.random();
    final programId = await Ed25519HDKeyPair.random();

    final compiledKeys = CompiledKeys.compile(
      payer: payer.publicKey,
      instructions: [
        Instruction(
          programId: programId.publicKey,
          accounts: [_createAccountMeta(payer.publicKey, false, false)],
          data: ByteArray.u8(0),
        ),
      ],
    );

    final Map<String, CompiledKeyMeta> map = {};

    _setMapEntry(map, payer.publicKey, true, true, false);
    _setMapEntry(map, programId.publicKey, false, false, true);

    expect(compiledKeys.keyMetaMap, map);
    expect(compiledKeys.payer, payer.publicKey);
  });

  test('compile with dup key', () async {
    final payer = await Ed25519HDKeyPair.random();
    final key = await Ed25519HDKeyPair.random();
    final programId = await Ed25519HDKeyPair.random();

    final compiledKeys = CompiledKeys.compile(
      payer: payer.publicKey,
      instructions: [
        Instruction(
          programId: programId.publicKey,
          accounts: [
            _createAccountMeta(key.publicKey, false, false),
            _createAccountMeta(key.publicKey, true, true),
          ],
          data: ByteArray.u8(0),
        ),
      ],
    );

    final Map<String, CompiledKeyMeta> map = {};

    _setMapEntry(map, payer.publicKey, true, true, false);
    _setMapEntry(map, key.publicKey, true, true, false);
    _setMapEntry(map, programId.publicKey, false, false, true);

    expect(compiledKeys.keyMetaMap, map);
    expect(compiledKeys.payer, payer.publicKey);
  });

  test('getMessageComponents', () async {
    final keys = await createTestKeys(4);
    final payer = keys.first;

    final Map<String, CompiledKeyMeta> map = {};
    _setMapEntry(map, payer, true, true, false);
    _setMapEntry(map, keys[1], true, false, false);
    _setMapEntry(map, keys[2], false, true, false);
    _setMapEntry(map, keys[3], false, false, false);

    final compiledKeys = CompiledKeys(payer: payer, keyMetaMap: map);
    final components = compiledKeys.getMessageComponents();

    expect(components.publicKeys, keys);
    expect(components.header.numRequiredSignatures, 2);
    expect(components.header.numReadonlySignedAccounts, 1);
    expect(components.header.numReadonlyUnsignedAccounts, 1);
  });

  test('getMessageComponents with overflow', () async {
    final keys = await createTestKeys(257);

    final Map<String, CompiledKeyMeta> map = {};
    for (final key in keys) {
      _setMapEntry(map, key, true, true, false);
    }

    final compiledKeys = CompiledKeys(payer: keys.first, keyMetaMap: map);
    try {
      compiledKeys.getMessageComponents();
      expect(true, false);
    } on Exception catch (e) {
      expect(e, isA<Exception>());
    }
  });

  test('extractTableLookup', () async {
    final keys = await createTestKeys(6);
    final Map<String, CompiledKeyMeta> map = {};
    _setMapEntry(map, keys[0], true, true, false);
    _setMapEntry(map, keys[1], true, false, false);
    _setMapEntry(map, keys[2], false, true, false);
    _setMapEntry(map, keys[3], false, false, false);
    _setMapEntry(map, keys[4], true, false, true);
    _setMapEntry(map, keys[5], false, false, true);

    final lookupTable = await createTestAddressLookUpTable([...keys, ...keys]);
    final compiledKeys = CompiledKeys(payer: keys.first, keyMetaMap: map);

    final extractResult = compiledKeys.extractTableLookup(lookupTable);
  });
}

AccountMeta _createAccountMeta(
  Ed25519HDPublicKey pubKey,
  bool isWriteable,
  bool isSigner,
) =>
    AccountMeta(pubKey: pubKey, isWriteable: isWriteable, isSigner: isSigner);

void _setMapEntry(
  Map<String, CompiledKeyMeta> map,
  Ed25519HDPublicKey pubKey,
  bool isWriteable,
  bool isSigner,
  bool isInvoked,
) =>
    map[pubKey.toString()] = CompiledKeyMeta(
      isWritable: isWriteable,
      isSigner: isSigner,
      isInvoked: isInvoked,
    );
