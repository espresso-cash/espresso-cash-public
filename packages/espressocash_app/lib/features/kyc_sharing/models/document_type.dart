import 'package:kyc_client_dart/kyc_client_dart.dart';

enum DocumentType {
  voterId('Voter ID', 'VOTER_ID'),
  ninV2('NIN Voter ID', 'NIN_V2');

  const DocumentType(this.name, this.value);

  final String name;
  final String value;
}

extension DocumentTypeExtension on DocumentType {
  IdType toIdType() => switch (this) {
        DocumentType.voterId => IdType.voterId,
        DocumentType.ninV2 => IdType.ninV2,
      };
}

extension IdTypeExtension on IdType {
  DocumentType? toDocumentType() => switch (this) {
        IdType.voterId => DocumentType.voterId,
        IdType.ninV2 => DocumentType.ninV2,
        // ignore: avoid-wildcard-cases-with-enums, check if needed
        _ => null,
      };
}
