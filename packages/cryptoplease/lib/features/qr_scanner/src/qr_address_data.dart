import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';

part 'qr_address_data.freezed.dart';
part 'qr_address_data.g.dart';

@freezed
class QrAddressData with _$QrAddressData {
  const factory QrAddressData({
    @Ed25519HDPublicKeyConverter() required Ed25519HDPublicKey address,
    required String? name,
  }) = _QrAddressData;

  factory QrAddressData.fromJson(Map<String, dynamic> json) =>
      _$QrAddressDataFromJson(json);

  static QrAddressData? tryParse(String data) {
    if (isValidAddress(data)) {
      return QrAddressData(
        address: Ed25519HDPublicKey.fromBase58(data),
        name: null,
      );
    }
    try {
      final jsonData = jsonDecode(data) as Map<String, dynamic>;

      return QrAddressData.fromJson(jsonData);
    } on Object {
      return null;
    }
  }
}

class Ed25519HDPublicKeyConverter
    extends JsonConverter<Ed25519HDPublicKey, String> {
  const Ed25519HDPublicKeyConverter();

  @override
  Ed25519HDPublicKey fromJson(String json) =>
      Ed25519HDPublicKey.fromBase58(json);

  @override
  String toJson(Ed25519HDPublicKey object) => object.toBase58();
}
