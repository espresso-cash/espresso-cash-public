import '../../../data/db/db.dart';
import '../src/models/ramp_partner.dart';

extension RampPartnerExt on RampPartner {
  RampPartnerDto toDto() => switch (this) {
        RampPartner.coinflow => RampPartnerDto.coinflow,
        RampPartner.rampNetwork => RampPartnerDto.rampNetwork,
        RampPartner.kado => RampPartnerDto.kado,
        RampPartner.guardarian => RampPartnerDto.guardarian,
      };
}

extension RampPartnerDtoExt on RampPartnerDto {
  RampPartner toModel() => switch (this) {
        RampPartnerDto.coinflow => RampPartner.coinflow,
        RampPartnerDto.rampNetwork => RampPartner.rampNetwork,
        RampPartnerDto.kado => RampPartner.kado,
        RampPartnerDto.guardarian => RampPartner.guardarian,
      };
}
