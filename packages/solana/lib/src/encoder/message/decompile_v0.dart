import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';
import 'package:solana/src/crypto/ed25519_hd_public_key.dart';
import 'package:solana/src/encoder/message/message_account_keys.dart';

@internal
Message decompileV0(
  CompiledMessageV0 message,
  List<AddressLookupTableAccount> addressLookupTableAccounts,
) {
  final numWritableSignedAccounts = message.header.numRequiredSignatures -
      message.header.numReadonlySignedAccounts;
  assert(numWritableSignedAccounts > 0, 'Message header is invalid');

  final numWritableUnsignedAccounts = message.accountKeys.length -
      message.header.numRequiredSignatures -
      message.header.numReadonlyUnsignedAccounts;
  assert(numWritableUnsignedAccounts >= 0, 'Message header is invalid');

  final accountKeys = _getAccountKeys(message, addressLookupTableAccounts);
  final payer = accountKeys[0];

  if (payer == null) {
    throw const FormatException(
      'Failed to decompile message because no account keys were found',
    );
  }

  final instructions = <Instruction>[];

  for (final compiledIx in message.instructions) {
    final keys = <AccountMeta>[];

    for (final int keyIndex in compiledIx.accountKeyIndexes) {
      final key = accountKeys[keyIndex];

      if (key == null) {
        throw FormatException(
          'Failed to find key for account key index $keyIndex',
        );
      }

      final isSigner = keyIndex < message.header.numRequiredSignatures;

      bool isWritable;
      if (isSigner) {
        isWritable = keyIndex < numWritableSignedAccounts;
      } else if (keyIndex < accountKeys.staticAccountKeys.length) {
        isWritable = keyIndex - message.header.numRequiredSignatures <
            numWritableUnsignedAccounts;
      } else {
        isWritable = keyIndex - accountKeys.staticAccountKeys.length <
            // accountKeysFromLookups cannot be undefined because we already found a pubkey for this index above
            (accountKeys.accountKeysFromLookups?.writable.length ?? 0);
      }

      keys.add(
        AccountMeta(
          pubKey: key,
          isWriteable: isWritable,
          isSigner: isSigner,
        ),
      );
    }

    final programId = accountKeys[compiledIx.programIdIndex];
    if (programId == null) {
      throw FormatException(
        'Failed to find program id for program id index ${compiledIx.programIdIndex}',
      );
    }

    instructions.add(
      Instruction(
        programId: programId,
        accounts: keys,
        data: compiledIx.data,
      ),
    );
  }

  return Message(instructions: instructions);
}

MessageAccountKeys _getAccountKeys(
  CompiledMessageV0 message,
  List<AddressLookupTableAccount>? addressLookupTableAccounts,
) {
  LoadedAddresses? loadedAddresses;

  if (addressLookupTableAccounts != null) {
    loadedAddresses = _resolveAddressTableLookups(
      message: message,
      addressLookupTableAccounts: addressLookupTableAccounts,
    );
  } else if (message.addressTableLookups.isNotEmpty) {
    throw const FormatException(
      'Failed to get account keys because address table lookups were not resolved',
    );
  }

  return MessageAccountKeys(
    staticAccountKeys: message.accountKeys,
    accountKeysFromLookups: loadedAddresses,
  );
}

LoadedAddresses _resolveAddressTableLookups({
  required CompiledMessageV0 message,
  required List<AddressLookupTableAccount> addressLookupTableAccounts,
}) {
  final writableKeys = <Ed25519HDPublicKey>[];
  final readonlyKeys = <Ed25519HDPublicKey>[];

  for (final tableLookup in message.addressTableLookups) {
    final tableAccount = addressLookupTableAccounts.firstWhereOrNull(
      (e) => e.key == tableLookup.accountKey,
    );

    if (tableAccount == null) {
      throw FormatException(
        'Failed to find address lookup table account for table key ${tableLookup.accountKey.toBase58()}',
      );
    }

    for (final index in tableLookup.writableIndexes) {
      if (index < tableAccount.state.addresses.length) {
        writableKeys.add(tableAccount.state.addresses[index]);
      } else {
        throw FormatException(
          'Failed to find address for index $index in address lookup table ${tableLookup.accountKey.toBase58()}',
        );
      }
    }

    for (final index in tableLookup.readonlyIndexes) {
      if (index < tableAccount.state.addresses.length) {
        readonlyKeys.add(tableAccount.state.addresses[index]);
      } else {
        throw FormatException(
          'Failed to find address for index $index in address lookup table ${tableLookup.accountKey.toBase58()}',
        );
      }
    }
  }

  return LoadedAddresses(writable: writableKeys, readonly: readonlyKeys);
}
