import 'package:ethereum_addresses/ethereum_addresses.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';

part 'qr_address_data.freezed.dart';
part 'qr_address_data.g.dart';

@freezed
sealed class QrAddressData with _$QrAddressData {
  const factory QrAddressData.solana({
    @Ed25519HDPublicKeyConverter() required Ed25519HDPublicKey address,
  }) = QrAddressDataSolana;

  const factory QrAddressData.evm({required String address}) = QrAddressDataEvm;

  factory QrAddressData.fromJson(Map<String, dynamic> json) =>
      _$QrAddressDataFromJson(json);

  static QrAddressData? tryParse(String data) {
    if (isValidAddress(data)) {
      return QrAddressData.solana(
        address: Ed25519HDPublicKey.fromBase58(data),
      );
    }

    if (isValidEthereumAddress(data)) {
      return QrAddressData.evm(address: data);
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
