// ignore_for_file: avoid-recursive-calls

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart' hide IdTypeExtension;

import '../../../l10n/l10n.dart';
import '../../../ui/bottom_button.dart';
import '../../../ui/colors.dart';
import '../../../ui/loader.dart';
import '../../../ui/snackbar.dart';
import '../../country_picker/models/country.dart';
import '../models/document_type.dart';
import '../widgets/document_picker.dart';
import '../widgets/kyc_page.dart';
import '../widgets/kyc_text_field.dart';

class DocumentInformationScreen extends StatefulWidget {
  const DocumentInformationScreen({super.key, required this.requirement});

  final KycRequirement requirement;

  static Future<bool> push(
    BuildContext context, {
    required KycRequirement requirement,
  }) =>
      Navigator.of(context)
          .push<bool>(
            MaterialPageRoute(
              builder: (context) =>
                  DocumentInformationScreen(requirement: requirement),
            ),
          )
          .then((result) => result ?? false);

  @override
  State<DocumentInformationScreen> createState() =>
      _DocumentInformationScreenState();
}

class _DocumentInformationScreenState extends State<DocumentInformationScreen> {
  final Map<DocumentField, TextEditingController> _controllers = {};

  final Map<IdType, DocumentType?> _selectedDocuments = {};

  // Track document fields per document type
  final Map<IdType, Map<DocumentField, dynamic>> _documentFieldsByType = {};
  Map<DocumentField, bool> _requiredFields = {};

  List<IdType> _availableIdTypes = [];
  String? _requiredCountryName;

  final List<List<IdType>> _orDocumentTypeGroups = [];
  final Map<int, DocumentType?> _selectedOrDocuments = {};
  // Track document fields for OR document types
  final Map<int, Map<DocumentField, dynamic>> _orDocumentFields = {};

  // Track document fields required for each document type
  final Map<IdType, List<DocumentField>> _requiredFieldsByDocType = {};

  bool get _isValid {
    // Check if all required document types have been selected
    if (_availableIdTypes.any((type) => _selectedDocuments[type] == null)) {
      return false;
    }

    // Check if all OR groups have a selection
    if (_orDocumentTypeGroups.isNotEmpty &&
        _orDocumentTypeGroups.length != _selectedOrDocuments.length) {
      return false;
    }

    // Check all required fields for AND document types
    for (final idType in _availableIdTypes) {
      final docType = _selectedDocuments[idType];
      if (docType == null) continue;

      // Get required fields for this document type
      final fields = _getRequiredFieldsForDocumentType(docType);
      for (final field in fields) {
        final value = _documentFieldsByType[idType]?[field];
        if (value == null || (value is String && value.isEmpty)) {
          return false;
        }
      }
    }

    // Check all required fields for OR document types
    for (int i = 0; i < _orDocumentTypeGroups.length; i++) {
      final docType = _selectedOrDocuments[i];
      if (docType == null) continue;

      // Get required fields for this document type
      final fields = _getRequiredFieldsForDocumentType(docType);
      for (final field in fields) {
        final value = _orDocumentFields[i]?[field];
        if (value == null || (value is String && value.isEmpty)) {
          return false;
        }
      }
    }

    return true;
  }

  @override
  void initState() {
    super.initState();
    _parseRequirements();
  }

  void _parseRequirements() {
    print(widget.requirement.requirements);

    final requiredCountryCode =
        _findCountryCodeRequirement(widget.requirement.requirements);

    if (requiredCountryCode != null) {
      _requiredCountryName =
          Country.findByCode(requiredCountryCode)?.name ?? requiredCountryCode;
    }

    _availableIdTypes =
        _findDocumentTypeRequirements(widget.requirement.requirements);

    // Initialize the map with null values for each required document type
    for (final idType in _availableIdTypes) {
      _selectedDocuments[idType] = null;
      _documentFieldsByType[idType] = {};
    }

    // Extract required fields from the requirements
    _requiredFields =
        _findDocumentFieldRequirements(widget.requirement.requirements);

    // Map required fields to document types
    _mapRequiredFieldsToDocumentTypes(widget.requirement.requirements);

    // Initialize controllers for all possible document fields
    for (final field in DocumentField.values) {
      if (_needsTextController(field)) {
        _controllers[field] = TextEditingController();
      }
    }
  }

  // New method to map required fields to document types
  void _mapRequiredFieldsToDocumentTypes(List<Requirement> requirements) {
    // First, find all document type requirements
    for (final req in requirements) {
      if (req is DocumentTypeRequirement) {
        // For each document type, find the associated field requirements
        final fields = _findAssociatedDocumentFields(requirements, req.type);
        _requiredFieldsByDocType[req.type] = fields;
      } else if (req is AndRequirement) {
        _mapRequiredFieldsToDocumentTypes(req.requirements);
      } else if (req is OrRequirement) {
        _mapRequiredFieldsToDocumentTypes(req.requirements);
      }
    }
  }

  // Helper to find document fields associated with a document type
  List<DocumentField> _findAssociatedDocumentFields(
    List<Requirement> requirements,
    IdType documentType,
  ) {
    final List<DocumentField> fields = [];

    for (final req in requirements) {
      if (req is DocumentFieldRequirement) {
        // Add all document field requirements - for now, associate all fields with all document types
        fields.add(req.field);
      } else if (req is AndRequirement) {
        fields.addAll(
          _findAssociatedDocumentFields(req.requirements, documentType),
        );
      } else if (req is OrRequirement) {
        fields.addAll(
          _findAssociatedDocumentFields(req.requirements, documentType),
        );
      }
    }

    return fields;
  }

  // Replace the hardcoded method with one that uses the parsed requirements
  List<DocumentField> _getRequiredFieldsForDocumentType(DocumentType docType) {
    // Find the IdType that corresponds to this DocumentType
    for (final entry in _requiredFieldsByDocType.entries) {
      if (entry.key.toDocumentType() == docType) {
        return entry.value;
      }
    }

    // If we don't have specific requirements for this document type,
    // return a default set of fields or an empty list
    return [DocumentField.idNumber]; // Default fallback
  }

  bool _needsTextController(DocumentField field) => switch (field) {
        DocumentField.idNumber => true,
        DocumentField.photoFront || DocumentField.photoBack => false,
      };

  String? _findCountryCodeRequirement(List<Requirement> requirements) {
    for (final req in requirements) {
      if (req is CountryCodeRequirement) {
        return req.code;
      } else if (req is AndRequirement) {
        final code = _findCountryCodeRequirement(req.requirements);
        if (code != null) return code;
      } else if (req is OrRequirement) {
        final code = _findCountryCodeRequirement(req.requirements);
        if (code != null) return code;
      }
    }

    return null;
  }

  List<IdType> _findDocumentTypeRequirements(List<Requirement> requirements) {
    final List<IdType> types = [];

    for (final req in requirements) {
      if (req is DocumentTypeRequirement) {
        types.add(req.type);
      } else if (req is AndRequirement) {
        // For AND requirements, add all document types
        types.addAll(_findDocumentTypeRequirements(req.requirements));
      } else if (req is OrRequirement) {
        // For OR requirements between document types
        final orTypes = _findDocumentTypeRequirements(req.requirements);
        if (orTypes.isNotEmpty) {
          // If this is an OR between document types, add the first one to available types
          // and store the group for UI selection
          _orDocumentTypeGroups.add(orTypes);

          // We don't add these to the main types list since they'll be handled separately
          // But we need to initialize the OR document fields
          for (int i = 0; i < _orDocumentTypeGroups.length; i++) {
            _orDocumentFields[i] = {};
          }
        }
      }
    }

    return types;
  }

  Map<DocumentField, bool> _findDocumentFieldRequirements(
    List<Requirement> requirements,
  ) {
    final Map<DocumentField, bool> fields = {};

    for (final req in requirements) {
      if (req is DocumentFieldRequirement) {
        fields[req.field] = true;
      } else if (req is AndRequirement) {
        fields.addAll(_findDocumentFieldRequirements(req.requirements));
      } else if (req is OrRequirement) {
        final orFields = _findDocumentFieldRequirements(req.requirements);
        for (final field in orFields.entries) {
          fields[field.key] = true;
        }
      }
    }

    return fields;
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _handleSubmitted() async {
    final success = await runWithLoader<bool>(
      context,
      () async {
        try {
          final countryCode = _requiredCountryName;

          // Check if all document types are selected
          if (countryCode == null ||
              _availableIdTypes
                  .any((type) => _selectedDocuments[type] == null) ||
              (_orDocumentTypeGroups.isNotEmpty &&
                  _orDocumentTypeGroups.length !=
                      _selectedOrDocuments.length)) {
            throw Exception();
          }

          // Combine all selected documents and their fields for the service call
          final allSelectedDocuments =
              Map<IdType, DocumentType?>.from(_selectedDocuments);
          final allDocumentFields = <DocumentField, dynamic>{};

          // Collect all document fields from AND document types
          for (final entry in _documentFieldsByType.entries) {
            allDocumentFields.addAll(entry.value);
          }

          // Add OR selections to the map
          for (int i = 0; i < _orDocumentTypeGroups.length; i++) {
            if (_selectedOrDocuments[i] != null) {
              // Find the corresponding IdType for this document type
              final docType = _selectedOrDocuments[i]!;
              final idType = _orDocumentTypeGroups[i].firstWhere(
                (type) => type.toDocumentType() == docType,
                orElse: () => _orDocumentTypeGroups[i].first,
              );
              allSelectedDocuments[idType] = docType;

              // Add document fields for this OR selection
              if (_orDocumentFields.containsKey(i)) {
                allDocumentFields.addAll(_orDocumentFields[i]!);
              }
            }
          }

          // TODO
          // await sl<KycSharingService>().updateDocumentInfo(
          //   countryCode: countryCode,
          //   selectedDocuments: allSelectedDocuments,
          //   documentFields: allDocumentFields,
          // );

          if (!mounted) return false;

          return true;
        } on Exception {
          if (!mounted) return false;

          showCpErrorSnackbar(
            context,
            message: context.l10n.failedToUpdateData,
          );

          return false;
        }
      },
    );
    if (!mounted) return;
    if (success) Navigator.pop(context, true);
  }

  void _updateDocumentField(IdType idType, DocumentField field, dynamic value) {
    setState(() {
      if (!_documentFieldsByType.containsKey(idType)) {
        _documentFieldsByType[idType] = {};
      }
      _documentFieldsByType[idType]![field] = value;
    });
  }

  void _updateOrDocumentField(int orIndex, DocumentField field, dynamic value) {
    setState(() {
      if (!_orDocumentFields.containsKey(orIndex)) {
        _orDocumentFields[orIndex] = {};
      }
      _orDocumentFields[orIndex]![field] = value;
    });
  }

  dynamic _pickPhoto() =>
      // TODO: Implement photo picking logic
      null;

  Widget _buildDocumentFieldWidget({
    required DocumentField field,
    required bool isRequired,
    required Function(dynamic) onValueChanged,
    dynamic currentValue,
  }) {
    switch (field) {
      case DocumentField.idNumber:
        final controller = TextEditingController(text: currentValue as String?);
        controller.addListener(() {
          onValueChanged(controller.text);
        });

        return KycTextField(
          controller: controller,
          inputType: TextInputType.text,
          placeholder: context.l10n.idNumber,
        );

      case DocumentField.photoFront:
        return _buildPhotoUploadField(
          label: 'Photo Front',
          isRequired: isRequired,
          currentValue: currentValue,
          onValueChanged: onValueChanged,
        );

      case DocumentField.photoBack:
        return _buildPhotoUploadField(
          label: 'Photo Back',
          isRequired: isRequired,
          currentValue: currentValue,
          onValueChanged: onValueChanged,
        );
    }
  }

  Widget _buildPhotoUploadField({
    required String label,
    required bool isRequired,
    required void Function(dynamic) onValueChanged,
    dynamic currentValue,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label${isRequired ? ' *' : ''}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () async {
              final photo = await _pickPhoto();
              if (photo != null) {
                onValueChanged(photo);
              }
            },
            child: Container(
              height: 120,
              decoration: const BoxDecoration(
                color: CpColors.blackGreyColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: currentValue != null
                  ? Image.file(
                      File(''), //TODO: Use actual file
                      fit: BoxFit.cover,
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_a_photo,
                            color: Colors.white.withOpacity(0.5),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tap to upload',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) => KycPage(
        title: 'Document'.toUpperCase(),
        children: [
          if (_requiredCountryName case final countryName?) ...[
            _RequiredCountryNotice(countryName: countryName),
            const SizedBox(height: 12),
          ],
          // Show pickers and fields for AND document types
          ..._availableIdTypes.map((idType) {
            final documentTypes =
                [idType.toDocumentType()].whereType<DocumentType>().toList();
            if (documentTypes.isEmpty) return const SizedBox.shrink();

            final selectedDocType = _selectedDocuments[idType];

            // Get required fields for this document type - use all required fields from API
            final List<DocumentField> documentFields;
            if (selectedDocType != null) {
              documentFields = _requiredFields.entries
                  .where((e) => e.value)
                  .map((e) => e.key)
                  .toList();
            } else {
              documentFields = <DocumentField>[];
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select ${idType.name}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                DocumentPicker(
                  type: _selectedDocuments[idType],
                  types: documentTypes,
                  onSubmitted: (docType) => setState(() {
                    _selectedDocuments[idType] = docType;
                    // Clear previous fields when document type changes
                    _documentFieldsByType[idType] = {};
                  }),
                ),
                const SizedBox(height: 16),
                // Show document fields for this document type
                if (selectedDocType != null)
                  ...documentFields.map(
                    (field) => Column(
                      children: [
                        _buildDocumentFieldWidget(
                          field: field,
                          isRequired: true,
                          currentValue: _documentFieldsByType[idType]?[field],
                          onValueChanged: (value) =>
                              _updateDocumentField(idType, field, value),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
              ],
            );
          }),

          // Show pickers and fields for OR document type groups
          ..._orDocumentTypeGroups.asMap().entries.map((entry) {
            final index = entry.key;
            final orTypes = entry.value;

            final documentTypes = orTypes
                .map((t) => t.toDocumentType())
                .whereType<DocumentType>()
                .toList();

            if (documentTypes.isEmpty) return const SizedBox.shrink();

            final selectedDocType = _selectedOrDocuments[index];

            // Get required fields for this document type - use all fields from API
            final List<DocumentField> documentFields;
            if (selectedDocType != null) {
              // Include all fields, not just those marked as required
              documentFields = _requiredFields.keys.toList();
            } else {
              documentFields = <DocumentField>[];
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select one document type',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                DocumentPicker(
                  type: _selectedOrDocuments[index],
                  types: documentTypes,
                  onSubmitted: (docType) => setState(() {
                    _selectedOrDocuments[index] = docType;
                    // Clear previous fields when document type changes
                    _orDocumentFields[index] = {};
                  }),
                ),
                const SizedBox(height: 16),
                // Show document fields for this document type
                if (selectedDocType != null)
                  ...documentFields.map(
                    (field) => Column(
                      children: [
                        _buildDocumentFieldWidget(
                          field: field,
                          isRequired: true,
                          currentValue: _orDocumentFields[index]?[field],
                          onValueChanged: (value) =>
                              _updateOrDocumentField(index, field, value),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
              ],
            );
          }),

          const SizedBox(height: 28),
          const Spacer(),
          ListenableBuilder(
            listenable: Listenable.merge(
              _controllers.values.toList(),
            ),
            builder: (context, child) => CpBottomButton(
              horizontalPadding: 16,
              text: context.l10n.next,
              onPressed: _isValid ? _handleSubmitted : null,
            ),
          ),
        ],
      );
}

class _RequiredCountryNotice extends StatelessWidget {
  const _RequiredCountryNotice({required this.countryName});

  final String countryName;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: CpColors.blackGreyColor,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.white.withOpacity(0.7),
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Please provide a document from $countryName',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      );
}
