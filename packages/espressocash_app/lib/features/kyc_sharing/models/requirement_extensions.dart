import 'package:kyc_client_dart/kyc_client_dart.dart' hide IdTypeExtension;

import '../models/document_type.dart';

enum RequirementRelationship {
  and,
  or,
}

extension RequirementListExtension on List<Requirement> {
  String? parseCountryCode() {
    final queue = [...this];
    while (queue.isNotEmpty) {
      final req = queue.removeLast();
      if (req is CountryCodeRequirement) {
        return req.code;
      } else if (req is AndRequirement) {
        queue.addAll(req.requirements);
      } else if (req is OrRequirement) {
        queue.addAll(req.requirements);
      }
    }

    return null;
  }

  List<DocumentType> parseDocumentTypes() {
    final types = <DocumentType>[];

    final queue = [...this];
    while (queue.isNotEmpty) {
      final req = queue.removeLast();
      if (req is DocumentTypeRequirement) {
        final docType = req.type.toDocumentType();
        if (docType != null) types.add(docType);
      } else if (req is AndRequirement) {
        queue.addAll(req.requirements);
      } else if (req is OrRequirement) {
        queue.addAll(req.requirements);
      }
    }

    return types;
  }

  List<DocumentField> parseRequiredFields() {
    final fields = <DocumentField>[];

    final queue = [...this];
    while (queue.isNotEmpty) {
      final req = queue.removeLast();
      if (req is DocumentFieldRequirement) {
        fields.add(req.field);
      } else if (req is AndRequirement) {
        queue.addAll(req.requirements);
      } else if (req is OrRequirement) {
        queue.addAll(req.requirements);
      }
    }

    return fields;
  }

  RequirementRelationship determineDocumentFieldsRelationship() {
    final queue = [...this];
    while (queue.isNotEmpty) {
      final req = queue.removeLast();
      if (req is AndRequirement &&
          req.requirements.any((r) => r is DocumentFieldRequirement)) {
        return RequirementRelationship.and;
      } else if (req is AndRequirement) {
        queue.addAll(req.requirements);
      } else if (req is OrRequirement) {
        queue.addAll(req.requirements);
      }
    }

    return RequirementRelationship.or;
  }
}
