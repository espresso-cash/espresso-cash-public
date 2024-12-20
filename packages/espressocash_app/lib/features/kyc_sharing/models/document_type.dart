import 'package:kyc_client_dart/kyc_client_dart.dart';

enum DocumentType {
  voterId('Voter ID', 'VOTER_ID');

  const DocumentType(this.name, this.value);

  final String name;
  final String value;
}

extension DocumentTypeExtension on DocumentType {
  IdType toIdType() => switch (this) {
        DocumentType.voterId => IdType.voterId,
      };
}

extension IdTypeExtension on IdType {
  DocumentType? toDocumentType() => switch (this) {
        IdType.voterId => DocumentType.voterId,
        // ignore: avoid-wildcard-cases-with-enums, check if needed
        _ => null,
      };
}
