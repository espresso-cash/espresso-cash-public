import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';

part 'qr_address_data.freezed.dart';
part 'qr_address_data.g.dart';

@freezed
class QrAddressData with _$QrAddressData {
  const factory QrAddressData({
    required String address,
    required String? name,
  }) = _QrAddressData;

  factory QrAddressData.fromJson(Map<String, dynamic> json) =>
      _$QrAddressDataFromJson(json);

  static QrAddressData? tryParse(String data) {
    if (isValidAddress(data)) {
      return QrAddressData(address: data, name: null);
    }
    try {
      final jsonData = jsonDecode(data) as Map<String, dynamic>;
      final qrAddress = QrAddressData.fromJson(jsonData);
      if (isValidAddress(qrAddress.address)) {
        return qrAddress;
      }
    } on Exception {
      return null;
    }
  }
}
