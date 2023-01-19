part of 'address_lookup_table.dart';

@freezed
class AddressLookupTableState with _$AddressLookupTableState {
  const factory AddressLookupTableState({
    required BigInt deactivationSlot,
    required int lastExtendedSlot,
    required int lastExtendedSlotStartIndex,
    required Ed25519HDPublicKey? authority,
    required List<Ed25519HDPublicKey> addresses,
  }) = _AddressLookupTableState;
}

// class AddressLookupTableState {
//   AddressLookupTableState({
//     required this.deactivationSlot,
//     required this.lastExtendedSlot,
//     required this.lastExtendedSlotStartIndex,
//     required this.authority,
//     required this.addresses,
//   });

//   final BigInt deactivationSlot;
//   final int lastExtendedSlot;
//   final int lastExtendedSlotStartIndex;
//   final Ed25519HDPublicKey? authority;
//   final List<Ed25519HDPublicKey> addresses;
// }
