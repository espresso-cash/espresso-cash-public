import 'package:brij_client/brij_client.dart' hide IdTypeExtension;

import '../models/document_type.dart';

enum RequirementRelationship { and, or }

extension KycRequirementsExtensions on KycRequirement {
  List<BasicInfoType> get basicInfoTypes =>
      requirements.whereType<BasicInfoRequirement>().map((req) => req.type).toList();

  List<String> get requiredCountryCodes => requirements.parseCountryCodes();
}

extension RequirementListExtension on List<Requirement> {
  List<String> parseCountryCodes() {
    final codes = <String>[];
    final queue = [...this];

    while (queue.isNotEmpty) {
      final req = queue.removeLast();
      if (req is CountryCodeRequirement) {
        codes.add(req.code);
      } else if (req is AndRequirement) {
        queue.addAll(req.requirements);
      } else if (req is OrRequirement) {
        queue.addAll(req.requirements);
      }
    }

    return codes;
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

  List<DocumentField> parseRequiredFields(DocumentType selectedDocType) {
    final fields = <DocumentField>[];
    final queue = [...this];

    while (queue.isNotEmpty) {
      final req = queue.removeLast();
      if (req is OrRequirement) {
        for (final andReq in req.requirements.whereType<AndRequirement>()) {
          final hasMatchingDocType = andReq.requirements.whereType<DocumentTypeRequirement>().any(
            (r) => r.type.toDocumentType() == selectedDocType,
          );

          if (hasMatchingDocType) {
            fields.addAll(
              andReq.requirements.whereType<DocumentFieldRequirement>().map((r) => r.field),
            );
            break;
          }
        }
      } else if (req is AndRequirement) {
        queue.addAll(req.requirements);
      }
    }

    return fields;
  }

  RequirementRelationship determineDocumentFieldsRelationship() {
    final queue = [...this];
    while (queue.isNotEmpty) {
      final req = queue.removeLast();
      if (req is AndRequirement && req.requirements.any((r) => r is DocumentFieldRequirement)) {
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
