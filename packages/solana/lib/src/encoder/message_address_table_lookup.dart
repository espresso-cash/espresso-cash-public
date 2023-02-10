import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/crypto/ed25519_hd_public_key.dart';

part 'message_address_table_lookup.freezed.dart';

@freezed
class MessageAddressTableLookup with _$MessageAddressTableLookup {
  const factory MessageAddressTableLookup({
    required Ed25519HDPublicKey accountKey,
    required List<int> writableIndexes,
    required List<int> readonlyIndexes,
  }) = _MessageAddressTableLookup;
}
