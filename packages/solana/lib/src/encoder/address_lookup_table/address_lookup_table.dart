import 'package:solana/src/crypto/ed25519_hd_public_key.dart';

class AddressLookupTableState {
  AddressLookupTableState({
    required this.deactivationSlot,
    required this.lastExtendedSlot,
    required this.lastExtendedSlotStartIndex,
    required this.authority,
    required this.addresses,
  });
  final BigInt deactivationSlot;
  final int lastExtendedSlot;
  final int lastExtendedSlotStartIndex;
  final Ed25519HDPublicKey authority;
  final List<Ed25519HDPublicKey> addresses;
}

class AddressLookupTableAccountArgs {
  AddressLookupTableAccountArgs(this.key, this.state);
  final Ed25519HDPublicKey key;
  final AddressLookupTableState state;
}

// const int _lookupTableMetaSize = 56;

class AddressLookupTableAccount {
  AddressLookupTableAccount(this.key, this.state);
  final Ed25519HDPublicKey key;
  final AddressLookupTableState state;

  bool isActive() {
    final BigInt u64Max = BigInt.parse('0xffffffffffffffff');

    return state.deactivationSlot == u64Max;
  }

  // TODO
  // static AddressLookupTableState deserialize(ByteArray accountData) {
  //   final meta = decodeData(_lookupTableMetaLayout, accountData);

  //   final int serializedAddressesLen =
  //       accountData.length - _lookupTableMetaSize;
  //   assert(serializedAddressesLen >= 0, 'lookup table is invalid');
  //   assert(serializedAddressesLen % 32 == 0, 'lookup table is invalid');

  //   final int numSerializedAddresses = serializedAddressesLen / 32;
  //   final Map<String, dynamic> addressesData =
  //       BufferLayout.struct<Map<String, dynamic>>([
  //     BufferLayout.seq(
  //       Layout.publicKey(),
  //       numSerializedAddresses,
  //       'addresses',
  //     ),
  //   ]).decode(accountData.sublist(_lookupTableMetaSize));

  //   final List<PublicKey> addresses =
  //       (addressesData['addresses'] as List<Uint8List>)
  //           .map(PublicKey.new)
  //           .toList();

  //   return AddressLookupTableState(
  //     meta['deactivationSlot'],
  //     meta['lastExtendedSlot'],
  //     meta['lastExtendedStartIndex'],
  //     meta['authority'].length != 0 ? PublicKey(meta['authority'][0]) : null,
  //     addresses,
  //   );
  // }
}
