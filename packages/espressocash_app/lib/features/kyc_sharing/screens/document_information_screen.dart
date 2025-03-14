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

  DocumentType? _idType;

  final Map<DocumentField, dynamic> _documentFields = {};
  Map<DocumentField, bool> _requiredFields = {};

  List<IdType> _availableIdTypes = [];
  String? _requiredCountryName;

  bool get _isValid {
    // Check document type
    if (_idType == null) {
      return false;
    }

    // Check all required fields have values
    for (final field in _requiredFields.entries) {
      if (!field.value) continue; // Skip optional fields

      final value = _documentFields[field.key];
      if (value == null || (value is String && value.isEmpty)) {
        return false;
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

    _requiredFields =
        _findDocumentFieldRequirements(widget.requirement.requirements);

    for (final field in _requiredFields.keys) {
      if (_needsTextController(field)) {
        _controllers[field] = TextEditingController();
      }
    }
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
        types.addAll(_findDocumentTypeRequirements(req.requirements));
      } else if (req is OrRequirement) {
        types.addAll(_findDocumentTypeRequirements(req.requirements));
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
        // For OR conditions, we mark fields as optional
        final orFields = _findDocumentFieldRequirements(req.requirements);
        for (final field in orFields.entries) {
          fields[field.key] = fields[field.key] ?? false;
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
          final idTypeValue = _idType?.value;

          if (countryCode == null || idTypeValue == null) {
            throw Exception();
          }

          // TODO
          // await sl<KycSharingService>().updateDocumentInfo(
          //   countryCode: countryCode,
          //   idType: _idType,
          //   documentFields: _documentFields,
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

  void _updateDocumentField(DocumentField field, dynamic value) {
    setState(() {
      _documentFields[field] = value;
    });
  }

  dynamic _pickPhoto() =>
      // TODO: Implement photo picking logic
      null;

  Widget _buildDocumentFieldWidget(DocumentField field, bool isRequired) {
    switch (field) {
      case DocumentField.idNumber:
        return KycTextField(
          controller: _controllers[field]!,
          inputType: TextInputType.text,
          placeholder: context.l10n.idNumber,
        )..controller.addListener(() {
            _updateDocumentField(field, _controllers[field]!.text);
          });
      case DocumentField.photoFront:
        return _buildPhotoUploadField(
          field: field,
          label: 'Photo Front',
          isRequired: isRequired,
        );
      case DocumentField.photoBack:
        return _buildPhotoUploadField(
          field: field,
          label: 'Photo Back',
          isRequired: isRequired,
        );
    }
  }

  Widget _buildPhotoUploadField({
    required DocumentField field,
    required String label,
    required bool isRequired,
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
                _updateDocumentField(field, photo);
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
              child: _documentFields[field] != null
                  ? Image.file(
                      File(''), //TODO
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
          DocumentPicker(
            type: _idType,
            types: _availableIdTypes
                .map((e) => e.toDocumentType())
                .nonNulls
                .toList(),
            onSubmitted: (idType) => setState(() => _idType = idType),
          ),
          const SizedBox(height: 10),
          ..._requiredFields.entries.map(
            (entry) => Column(
              children: [
                _buildDocumentFieldWidget(entry.key, entry.value),
                const SizedBox(height: 10),
              ],
            ),
          ),
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
