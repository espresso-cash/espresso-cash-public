import 'package:kyc_client_dart/kyc_client_dart.dart';

enum DocumentType {
  bvn('BVN', 'BVN'),
  nin('NIN', 'NIN'),
  ninV2('NIN V2', 'NIN_V2'),
  ninSlip('NIN SLIP', 'NIN_SLIP'),
  driversLicense('Driver\'s License', 'DRIVERS_LICENSE'),
  voterId('Voter ID', 'VOTER_ID');

  const DocumentType(this.name, this.value);

  final String name;
  final String value;

  IdType toIdType() {
    switch (this) {
      case DocumentType.bvn:
      case DocumentType.nin:
      case DocumentType.ninV2:
      case DocumentType.ninSlip:
        return IdType.other;
      case DocumentType.driversLicense:
        return IdType.driverLicense;
      case DocumentType.voterId:
        return IdType.voterId;
    }
  }
}
