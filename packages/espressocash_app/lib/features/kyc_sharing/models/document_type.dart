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
}

extension DocumentTypeExtension on DocumentType {
  IdType toIdType() => switch (this) {
        DocumentType.bvn ||
        DocumentType.nin ||
        DocumentType.ninV2 ||
        DocumentType.ninSlip =>
          IdType.other,
        DocumentType.driversLicense => IdType.driverLicense,
        DocumentType.voterId => IdType.voterId,
      };
}

extension IdTypeExtension on IdType {
  DocumentType? toDocumentType() => switch (this) {
        IdType.driverLicense => DocumentType.driversLicense,
        IdType.voterId => DocumentType.voterId,
        // ignore: avoid-wildcard-cases-with-enums, check if needed
        _ => null,
      };
}
