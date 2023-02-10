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
