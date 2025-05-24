import 'package:brij_client/brij_client.dart';

enum DocumentType {
  voterId('Voter ID', 'VOTER_ID'),
  // ignore: avoid-duplicate-constant-values, intentional duplication
  ninV2('NIN_V2', 'NIN_V2'),
  passport('Passport', 'PASSPORT'),
  idCard('Id Card', 'ID_CARD');

  const DocumentType(this.name, this.value);

  final String name;
  final String value;
}

extension DocumentTypeExtension on DocumentType {
  IdType toIdType() => switch (this) {
    DocumentType.voterId => IdType.voterId,
    DocumentType.ninV2 => IdType.ninV2,
    DocumentType.passport => IdType.passport,
    DocumentType.idCard => IdType.idCard,
  };
}

extension IdTypeExtension on IdType {
  DocumentType? toDocumentType() => switch (this) {
    IdType.voterId => DocumentType.voterId,
    IdType.ninV2 => DocumentType.ninV2,
    IdType.passport => DocumentType.passport,
    IdType.idCard => DocumentType.idCard,
    // ignore: avoid-wildcard-cases-with-enums, check if needed
    _ => null,
  };
}
