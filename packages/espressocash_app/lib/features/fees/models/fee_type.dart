import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';

part 'fee_type.freezed.dart';

@Freezed(
  when: FreezedWhenOptions.none,
  map: FreezedMapOptions.none,
  copyWith: false,
)
sealed class FeeType with _$FeeType {
  const factory FeeType.direct(Ed25519HDPublicKey address) = FeeTypeDirect;
  const factory FeeType.splitKey() = FeeTypeSplitKey;
  const factory FeeType.withdraw({
    required int amount,
  }) = FeeTypeWithdraw;
}
