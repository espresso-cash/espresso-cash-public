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
  String? _countryCode;
  String? _countryName;

  List<DocumentType> _availableDocumentTypes = [];
  DocumentType? _selectedDocumentType;

  final Map<DocumentField, dynamic> _documentFields = {};
  final Map<DocumentField, TextEditingController> _controllers = {};

  RequirementRelationship _documentFieldsRelationship =
      RequirementRelationship.or;

  @override
  void initState() {
    super.initState();
    _parseRequirements();

    final requiredFields =
        widget.requirement.requirements.parseRequiredFields();
    for (final field in requiredFields) {
      if (_needsTextController(field)) {
        _controllers[field] = TextEditingController();
      }
    }
  }

  void _parseRequirements() {
    _countryCode = widget.requirement.requirements.parseCountryCode();
    if (_countryCode case final code?) {
      _countryName = Country.findByCode(code)?.name ?? code;
    }

    _availableDocumentTypes =
        widget.requirement.requirements.parseDocumentTypes();

    _documentFieldsRelationship =
        widget.requirement.requirements.determineDocumentFieldsRelationship();
  }

  bool _needsTextController(DocumentField field) => switch (field) {
        DocumentField.idNumber => true,
        DocumentField.photoFront || DocumentField.photoBack => false,
      };

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
          if (_countryCode == null || _selectedDocumentType == null) {
            throw Exception('Missing required information');
          }

          final idType = IdType.values.firstWhere(
            (type) => type.toDocumentType() == _selectedDocumentType,
            orElse: () => throw Exception('Invalid document type'),
          );

          // Extract document field values
          String? idNumber;
          File? frontImage;
          File? backImage;

          // Get ID number if available
          if (_documentFields.containsKey(DocumentField.idNumber)) {
            idNumber = _controllers[DocumentField.idNumber]?.text;
          }

          // Get front image if available
          if (_documentFields.containsKey(DocumentField.photoFront)) {
            frontImage = _documentFields[DocumentField.photoFront] as File?;
          }

          // Get back image if available
          if (_documentFields.containsKey(DocumentField.photoBack)) {
            backImage = _documentFields[DocumentField.photoBack] as File?;
          }

          // Debug information
          print('IdType: $idType');
          print('Country Code: $_countryCode');
          print('Selected Document: $_selectedDocumentType');
          print('ID Number: $idNumber');
          print(
            'Front Image: ${frontImage != null ? 'Present' : 'Not present'}',
          );
          print('Back Image: ${backImage != null ? 'Present' : 'Not present'}');

          // Call the service with the collected data
          // await sl<KycSharingService>().updateDocumentInfo(
          //   idType: _selectedDocumentType,
          //   idNumber: idNumber,
          //   countryCode: _countryCode,
          //   frontImage: frontImage,
          //   backImage: backImage,
          // );

          return true;
        } on Exception catch (e) {
          if (!mounted) return false;

          showCpErrorSnackbar(
            context,
            message: context.l10n.failedToUpdateData,
          );

          print('Error submitting document info: $e');

          return false;
        }
      },
    );

    if (!mounted) return;
    if (success) Navigator.pop(context, true);
  }

  void _updateDocumentField(DocumentField field, dynamic value) {
    setState(() {
      _documentFields[field] = value;
    });
  }

  dynamic _pickPhoto() {
    // TODO: Implement photo picking logic
    return null;
  }

  Widget _buildDocumentFieldWidget(DocumentField field) {
    final isRequired = _requiredFields.contains(field);
    final currentValue = _documentFields[field];

    switch (field) {
      case DocumentField.idNumber:
        final controller = _controllers[field]!;

        if (controller.text != (currentValue as String? ?? '')) {
          controller.text = currentValue ?? '';
        }

        controller.removeListener(() {});
        controller.addListener(() {
          _updateDocumentField(field, controller.text);
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
          onValueChanged: (value) => _updateDocumentField(field, value),
        );

      case DocumentField.photoBack:
        return _buildPhotoUploadField(
          label: 'Photo Back',
          isRequired: isRequired,
          currentValue: currentValue,
          onValueChanged: (value) => _updateDocumentField(field, value),
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
            '$label${isRequired && _documentFieldsRelationship == RequirementRelationship.and ? ' *' : ''}',
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

  List<DocumentField> get _requiredFields {
    if (_selectedDocumentType == null) return [];

    return widget.requirement.requirements.parseRequiredFields();
  }

  bool get _isValid {
    // Must have a document type selected
    if (_selectedDocumentType == null) return false;

    final requiredFields = _requiredFields;
    if (requiredFields.isEmpty) return true;

    switch (_documentFieldsRelationship) {
      case RequirementRelationship.and:
        // AND relationship - all fields must have values
        for (final field in requiredFields) {
          final value = _documentFields[field];
          if (value == null ||
              (value is String && value.isEmpty) ||
              (field == DocumentField.idNumber &&
                  (_controllers[field]?.text.isEmpty ?? true))) {
            return false;
          }
        }

        return true;

      case RequirementRelationship.or:
        // OR relationship - at least one field must have a value
        for (final field in requiredFields) {
          final value = _documentFields[field];
          if (value != null &&
              (value is! String || value.isNotEmpty) &&
              (field != DocumentField.idNumber ||
                  (_controllers[field]?.text.isNotEmpty ?? false))) {
            return true;
          }
        }

        return false;
    }
  }

  @override
  Widget build(BuildContext context) => KycPage(
        title: 'Document'.toUpperCase(),
        children: [
          if (_countryName case final countryName?) ...[
            _RequiredCountryNotice(countryName: countryName),
            const SizedBox(height: 16),
          ],
          const Text(
            'Select Document Type',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          DocumentPicker(
            type: _selectedDocumentType,
            types: _availableDocumentTypes,
            onSubmitted: (docType) => setState(() {
              _selectedDocumentType = docType;
              _documentFields.clear();
            }),
          ),
          const SizedBox(height: 16),
          if (_selectedDocumentType != null) ...[
            ..._requiredFields.map(
              (field) => Column(
                children: [
                  _buildDocumentFieldWidget(field),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
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

enum RequirementRelationship {
  and,
  or,
}

extension on List<Requirement> {
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
