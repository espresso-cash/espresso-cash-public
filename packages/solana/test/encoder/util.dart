// ignore_for_file: avoid_positional_boolean_parameters

import 'package:solana/solana.dart';
import 'package:solana/src/encoder/account_meta.dart';
import 'package:solana/src/encoder/address_lookup_table/address_lookup_table.dart';

Future<AddressLookupTableAccount> createTestAddressLookUpTable(
  List<Ed25519HDPublicKey> keys,
) async {
  final lookUpAccount = await Ed25519HDKeyPair.random();
  final lookUpAccountAuthority = await Ed25519HDKeyPair.random();

  return AddressLookupTableAccount(
    key: lookUpAccount.publicKey,
    state: AddressLookupTableState(
      lastExtendedSlot: 0,
      lastExtendedSlotStartIndex: 0,
      deactivationSlot: BigInt.parse('0xffffffffffffffff'),
      authority: lookUpAccountAuthority.publicKey,
      addresses: keys,
    ),
  );
}

Future<List<Ed25519HDPublicKey>> createTestKeys(int count) async {
  final List<Ed25519HDPublicKey> keys = [];

  for (var i = 0; i < count; i++) {
    final key = await Ed25519HDKeyPair.random();
    keys.add(key.publicKey);
  }

  return keys;
}

AccountMeta createAccountMeta(
  Ed25519HDPublicKey pubKey,
  bool isSigner,
  bool isWriteable,
) =>
    AccountMeta(pubKey: pubKey, isWriteable: isWriteable, isSigner: isSigner);
