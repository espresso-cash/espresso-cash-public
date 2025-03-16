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
    _initializeControllers();
  }

  void _parseRequirements() {
    final requirements = widget.requirement.requirements;
    _countryCode = requirements.parseCountryCode();
    _countryName = _countryCode != null
        ? Country.findByCode(_countryCode!)?.name ?? _countryCode
        : null;
    _availableDocumentTypes = requirements.parseDocumentTypes();
    _documentFieldsRelationship =
        requirements.determineDocumentFieldsRelationship();
  }

  void _initializeControllers() {
    final requiredFields =
        widget.requirement.requirements.parseRequiredFields();
    for (final field in requiredFields) {
      if (_needsTextController(field)) {
        _controllers[field] = TextEditingController();
      }
    }
  }

  bool _needsTextController(DocumentField field) =>
      field == DocumentField.idNumber;

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
          final idNumber = _controllers[DocumentField.idNumber]?.text;
          final frontImage = _documentFields[DocumentField.photoFront] as File?;
          final backImage = _documentFields[DocumentField.photoBack] as File?;

          // Debug information
          print('IdType: $idType');
          print('Country Code: $_countryCode');
          print('Selected Document: $_selectedDocumentType');
          print('ID Number: $idNumber');
          print(
            'Front Image: ${frontImage != null ? 'Present' : 'Not present'}',
          );
          print('Back Image: ${backImage != null ? 'Present' : 'Not present'}');

          // TODO: Uncomment when service is ready
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

  Future<File?> _pickPhoto() async {
    // TODO: Implement photo picking logic
    return null;
  }

  Widget _buildDocumentFieldWidget(DocumentField field) {
    final isInRequiredList = _requiredFields.contains(field);
    final isRequired = isInRequiredList &&
        _documentFieldsRelationship == RequirementRelationship.and;

    switch (field) {
      case DocumentField.idNumber:
        return _IdNumberField(
          controller: _controllers[field]!,
          currentValue: _documentFields[field] as String? ?? '',
          onChanged: (value) => _updateDocumentField(field, value),
        );
      case DocumentField.photoFront:
        return _PhotoUploadField(
          label: 'Photo Front',
          isRequired: isRequired,
          currentValue: _documentFields[field] as File?,
          onValueChanged: (value) => _updateDocumentField(field, value),
          pickPhoto: _pickPhoto,
        );
      case DocumentField.photoBack:
        return _PhotoUploadField(
          label: 'Photo Back',
          isRequired: isRequired,
          currentValue: _documentFields[field] as File?,
          onValueChanged: (value) => _updateDocumentField(field, value),
          pickPhoto: _pickPhoto,
        );
    }
  }

  List<DocumentField> get _requiredFields {
    if (_selectedDocumentType == null) return [];
    return widget.requirement.requirements.parseRequiredFields();
  }

  bool get _isValid {
    if (_selectedDocumentType == null) return false;

    final requiredFields = _requiredFields;
    if (requiredFields.isEmpty) return true;

    switch (_documentFieldsRelationship) {
      case RequirementRelationship.and:
        return requiredFields.every(_isFieldValid);
      case RequirementRelationship.or:
        return requiredFields.any(_isFieldValid);
    }
  }

  bool _isFieldValid(DocumentField field) {
    final value = _documentFields[field];

    if (field == DocumentField.idNumber) {
      return _controllers[field]?.text.isNotEmpty ?? false;
    }

    return value != null && (value is! String || value.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) => KycPage(
        title: 'Document'.toUpperCase(),
        children: [
          if (_countryName != null) ...[
            _RequiredCountryNotice(countryName: _countryName!),
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
          if (_selectedDocumentType != null)
            ..._requiredFields.map(
              (field) => Column(
                children: [
                  _buildDocumentFieldWidget(field),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          const SizedBox(height: 28),
          const Spacer(),
          ListenableBuilder(
            listenable: Listenable.merge(_controllers.values.toList()),
            builder: (context, child) => CpBottomButton(
              horizontalPadding: 16,
              text: context.l10n.next,
              onPressed: _isValid ? _handleSubmitted : null,
            ),
          ),
        ],
      );
}

class _IdNumberField extends StatefulWidget {
  const _IdNumberField({
    required this.controller,
    required this.currentValue,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String currentValue;
  final ValueChanged<String> onChanged;

  @override
  State<_IdNumberField> createState() => _IdNumberFieldState();
}

class _IdNumberFieldState extends State<_IdNumberField> {
  @override
  void initState() {
    super.initState();
    _syncControllerWithValue();
    widget.controller.addListener(_handleTextChanged);
  }

  @override
  void didUpdateWidget(_IdNumberField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller ||
        oldWidget.currentValue != widget.currentValue) {
      _syncControllerWithValue();
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleTextChanged);
    super.dispose();
  }

  void _syncControllerWithValue() {
    if (widget.controller.text != widget.currentValue) {
      widget.controller.text = widget.currentValue;
    }
  }

  void _handleTextChanged() {
    widget.onChanged(widget.controller.text);
  }

  @override
  Widget build(BuildContext context) => KycTextField(
        controller: widget.controller,
        inputType: TextInputType.text,
        placeholder: context.l10n.idNumber,
      );
}

class _PhotoUploadField extends StatelessWidget {
  const _PhotoUploadField({
    required this.label,
    required this.isRequired,
    required this.onValueChanged,
    required this.pickPhoto,
    this.currentValue,
  });

  final String label;
  final bool isRequired;
  final File? currentValue;
  final ValueChanged<File> onValueChanged;
  final Future<File?> Function() pickPhoto;

  @override
  Widget build(BuildContext context) => Column(
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
              final photo = await pickPhoto();
              if (photo != null) {
                onValueChanged(photo);
              }
            },
            child: Container(
              height: 120,
              decoration: const BoxDecoration(
                color: CpColors.blackGreyColor,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: _buildPhotoPreview(),
            ),
          ),
        ],
      );

  Widget _buildPhotoPreview() {
    if (currentValue != null) {
      return Image.file(
        currentValue!,
        fit: BoxFit.cover,
      );
    }

    return Center(
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
    );
  }
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
