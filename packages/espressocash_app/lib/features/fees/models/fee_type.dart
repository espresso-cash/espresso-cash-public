import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';

import '../../ramp_partner/models/ramp_partner.dart';

part 'fee_type.freezed.dart';

@Freezed(
  when: FreezedWhenOptions.none,
  map: FreezedMapOptions.none,
  copyWith: false,
)
sealed class FeeType with _$FeeType {
  const factory FeeType.direct(Ed25519HDPublicKey address) = FeeTypeDirect;
  const factory FeeType.link() = FeeTypeLink;
  const factory FeeType.withdraw({
    required int amount,
    required RampPartner partner,
    required Ed25519HDPublicKey? address,
  }) = FeeTypeWithdraw;
}
