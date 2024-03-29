import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/encoder/message/compiled_key_meta.dart';
import 'package:solana/src/encoder/message/compiled_keys.dart';
import 'package:test/test.dart';

import 'util.dart';

void main() {
  test('Compile', () async {
    final payer = await Ed25519HDKeyPair.random();
    final keys = await createTestKeys(6);
    final programIds = await createTestKeys(4);

    final compiledKeys = CompiledKeys.compile(
      payer: payer.publicKey,
      instructions: [
        Instruction(
          programId: programIds.first,
          accounts: [
            createAccountMeta(keys.first, false, false),
            createAccountMeta(keys[1], true, false),
            createAccountMeta(keys[2], false, true),
            createAccountMeta(keys[3], true, true),
            // duplicate the account metas
            createAccountMeta(keys.first, false, false),
            createAccountMeta(keys[1], true, false),
            createAccountMeta(keys[2], false, true),
            createAccountMeta(keys[3], true, true),
            // reference program ids
            createAccountMeta(programIds.first, false, false),
            createAccountMeta(programIds[1], true, false),
            createAccountMeta(programIds[2], false, true),
            createAccountMeta(programIds[3], true, true),
          ],
          data: ByteArray.u8(0),
        ),
        Instruction(
          programId: programIds[1],
          accounts: const [],
          data: ByteArray.u8(0),
        ),
        Instruction(
          programId: programIds[2],
          accounts: const [],
          data: ByteArray.u8(0),
        ),
        Instruction(
          programId: programIds[3],
          accounts: const [],
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

  test('Compile with duplicate payer', () async {
    final payer = await Ed25519HDKeyPair.random();
    final programId = await Ed25519HDKeyPair.random();

    final compiledKeys = CompiledKeys.compile(
      payer: payer.publicKey,
      instructions: [
        Instruction(
          programId: programId.publicKey,
          accounts: [createAccountMeta(payer.publicKey, false, false)],
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

  test('Compile with duplicate key', () async {
    final payer = await Ed25519HDKeyPair.random();
    final key = await Ed25519HDKeyPair.random();
    final programId = await Ed25519HDKeyPair.random();

    final compiledKeys = CompiledKeys.compile(
      payer: payer.publicKey,
      instructions: [
        Instruction(
          programId: programId.publicKey,
          accounts: [
            createAccountMeta(key.publicKey, false, false),
            createAccountMeta(key.publicKey, true, true),
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

  test('GetMessageComponents', () async {
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

    expect(compiledKeys.getMessageComponents, throwsException);
  });

  test('extractTableLookup', () async {
    final keys = await createTestKeys(6);
    final Map<String, CompiledKeyMeta> map = {};
    _setMapEntry(map, keys.first, true, true, false);
    _setMapEntry(map, keys[1], true, false, false);
    _setMapEntry(map, keys[2], false, true, false);
    _setMapEntry(map, keys[3], false, false, false);
    _setMapEntry(map, keys[4], true, false, true);
    _setMapEntry(map, keys[5], false, false, true);

    // ignore: avoid-duplicate-collection-elements, intended here
    final lookupTable = await createTestAddressLookUpTable([...keys, ...keys]);
    final compiledKeys = CompiledKeys(payer: keys.first, keyMetaMap: map);

    final extractResult = compiledKeys.extractTableLookup(lookupTable);

    if (extractResult == null) {
      expect(extractResult, isNotNull);

      return;
    }

    final tableLookup = extractResult.lookup;
    final extractedAddresses = extractResult.keys;

    expect(
      tableLookup,
      MessageAddressTableLookup(
        accountKey: lookupTable.key,
        writableIndexes: [2],
        readonlyIndexes: [3],
      ),
    );

    expect(
      extractedAddresses,
      LoadedAddresses(
        writable: [keys[2]],
        readonly: [keys[3]],
      ),
    );
  });

  test('extractTableLookup with no extractable keys found', () async {
    final keys = await createTestKeys(6);
    final Map<String, CompiledKeyMeta> map = {};
    _setMapEntry(map, keys.first, true, true, false);
    _setMapEntry(map, keys[1], true, false, false);
    _setMapEntry(map, keys[2], true, true, true);
    _setMapEntry(map, keys[3], true, false, true);
    _setMapEntry(map, keys[4], false, true, true);
    _setMapEntry(map, keys[5], false, false, true);

    final lookupTable = await createTestAddressLookUpTable(keys);
    final compiledKeys = CompiledKeys(payer: keys.first, keyMetaMap: map);

    final extractResult = compiledKeys.extractTableLookup(lookupTable);

    expect(extractResult, isNull);
  });

  test('extractTableLookup with empty lookup table', () async {
    final keys = await createTestKeys(2);
    final Map<String, CompiledKeyMeta> map = {};

    final lookupTable = await createTestAddressLookUpTable([]);
    final compiledKeys = CompiledKeys(payer: keys.first, keyMetaMap: map);

    final extractResult = compiledKeys.extractTableLookup(lookupTable);

    expect(extractResult, isNull);
  });

  test('extractTableLookup with invalid lookup table', () async {
    final keys = await createTestKeys(257);
    final Map<String, CompiledKeyMeta> map = {};
    _setMapEntry(map, keys.first, true, true, false);
    _setMapEntry(map, keys[256], false, false, false);

    final lookupTable = await createTestAddressLookUpTable(keys);
    final compiledKeys = CompiledKeys(payer: keys.first, keyMetaMap: map);

    expect(() => compiledKeys.extractTableLookup(lookupTable), throwsException);
  });
}

void _setMapEntry(
  Map<String, CompiledKeyMeta> map,
  Ed25519HDPublicKey pubKey,
  bool isSigner,
  bool isWriteable,
  bool isInvoked,
) =>
    map[pubKey.toString()] = CompiledKeyMeta(
      isSigner: isSigner,
      isWritable: isWriteable,
      isInvoked: isInvoked,
    );
