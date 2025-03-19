// ignore_for_file: avoid-recursive-calls

import 'package:kyc_client_dart/kyc_client_dart.dart' hide IdTypeExtension;

import '../models/document_type.dart';

enum RequirementRelationship {
  and,
  or,
}

extension KycRequirementsExtensions on KycRequirement {
  List<BasicInfoType> get basicInfoTypes => requirements
      .whereType<BasicInfoRequirement>()
      .map((req) => req.type)
      .toList();

  String? get requiredCountry => requirements.parseCountryCode();
}

extension KycRequirementListExtensions on List<Requirement> {
  String? parseCountryCode() {
    for (final req in this) {
      if (req is CountryCodeRequirement) {
        return req.code;
      } else if (req is AndRequirement) {
        final code = req.requirements.parseCountryCode();
        if (code != null) return code;
      } else if (req is OrRequirement) {
        final code = req.requirements.parseCountryCode();
        if (code != null) return code;
      }
    }

    return null;
  }

  List<DocumentType> parseDocumentTypes() {
    final List<DocumentType> types = [];

    for (final req in this) {
      if (req is DocumentTypeRequirement) {
        final docType = req.type.toDocumentType();
        if (docType != null) types.add(docType);
      } else if (req is AndRequirement) {
        types.addAll(req.requirements.parseDocumentTypes());
      } else if (req is OrRequirement) {
        types.addAll(req.requirements.parseDocumentTypes());
      }
    }

    return types;
  }

  List<DocumentField> parseRequiredFields() {
    final List<DocumentField> fields = [];

    for (final req in this) {
      if (req is DocumentFieldRequirement) {
        fields.add(req.field);
      } else if (req is AndRequirement) {
        fields.addAll(req.requirements.parseRequiredFields());
      } else if (req is OrRequirement) {
        fields.addAll(req.requirements.parseRequiredFields());
      }
    }

    return fields;
  }

  RequirementRelationship determineDocumentFieldsRelationship() {
    for (final req in this) {
      if (req is AndRequirement &&
          req.requirements.any((r) => r is DocumentFieldRequirement)) {
        return RequirementRelationship.and;
      } else if (req is AndRequirement) {
        final relationship =
            req.requirements.determineDocumentFieldsRelationship();
        if (relationship == RequirementRelationship.and) {
          return RequirementRelationship.and;
        }
      } else if (req is OrRequirement) {
        final relationship =
            req.requirements.determineDocumentFieldsRelationship();
        if (relationship == RequirementRelationship.and) {
          return RequirementRelationship.and;
        }
      }
    }

    return RequirementRelationship.or;
  }
}
