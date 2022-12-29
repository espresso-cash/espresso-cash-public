import 'package:freezed_annotation/freezed_annotation.dart';

part 'bip.freezed.dart';

@freezed
class BipLevel with _$BipLevel {
  const factory BipLevel({
    required int index,
    required bool hardened,
  }) = _BipLevel;
}

@freezed
class Bip32Data with _$Bip32Data {
  const factory Bip32Data({
    required List<BipLevel> levels,
  }) = _Bip32Data;
}

@freezed
class Bip44Data with _$Bip44Data {
  const factory Bip44Data({
    required BipLevel account,
    BipLevel? change,
    BipLevel? addressIndex,
  }) = _Bip44Data;
}
