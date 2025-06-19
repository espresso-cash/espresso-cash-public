import 'dart:io';

import 'package:brij_client/brij_client.dart' hide IdTypeExtension;
import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/bottom_button.dart';
import '../../../ui/colors.dart';
import '../../../ui/loader.dart';
import '../../../ui/snackbar.dart';
import '../../country_picker/models/country.dart';
import '../../country_picker/widgets/country_picker.dart';
import '../models/document_type.dart';
import '../models/requirement_extensions.dart';
import '../screens/document_camera_screen.dart';
import '../screens/document_info_screen.dart';
import '../services/kyc_service.dart';
import '../widgets/document_picker.dart';
import '../widgets/kyc_page.dart';
import '../widgets/kyc_text_field.dart';

class DocumentInputScreen extends StatefulWidget {
  const DocumentInputScreen({super.key, required this.requirement});

  final KycRequirement requirement;

  static Future<bool> push(BuildContext context, {required KycRequirement requirement}) =>
      Navigator.of(context)
          .push<bool>(
            MaterialPageRoute(builder: (context) => DocumentInputScreen(requirement: requirement)),
          )
          .then((result) => result ?? false);

  @override
  State<DocumentInputScreen> createState() => _DocumentInputScreenState();
}

class _DocumentInputScreenState extends State<DocumentInputScreen> {
  List<Country> _availableCountries = [];
  Country? _selectedCountry;

  List<DocumentType> _availableDocumentTypes = [];
  DocumentType? _selectedDocumentType;

  final Map<DocumentField, dynamic> _documentFields = {};
  final Map<DocumentField, TextEditingController> _controllers = {};

  RequirementRelationship _documentFieldsRelationship = RequirementRelationship.or;

  @override
  void initState() {
    super.initState();
    _parseRequirements();
    _initializeControllers();
  }

  void _parseRequirements() {
    final requirements = widget.requirement.requirements;
    _availableCountries =
        requirements.parseCountryCodes().map(Country.findByCode).nonNulls.toList();

    _availableDocumentTypes = requirements.parseDocumentTypes();
    _documentFieldsRelationship = requirements.determineDocumentFieldsRelationship();
  }

  void _initializeControllers() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    _controllers.clear();

    final selectedDocType = _selectedDocumentType;

    if (selectedDocType != null) {
      final requiredFields = widget.requirement.requirements.parseRequiredFields(selectedDocType);

      for (final field in requiredFields) {
        if (_needsTextController(field)) {
          _controllers[field] = TextEditingController();
        }
      }
    }
  }

  bool _needsTextController(DocumentField field) => field == DocumentField.idNumber;

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _handleSubmitted() async {
    final success = await runWithLoader<bool>(context, () async {
      try {
        if (_selectedCountry == null || _selectedDocumentType == null) {
          throw Exception('Missing required information');
        }

        final idNumber = _controllers[DocumentField.idNumber]?.text;
        // ignore: avoid-type-casts, controlled type
        final frontImage = _documentFields[DocumentField.photoFront] as File?;
        // ignore: avoid-type-casts, controlled type
        final backImage = _documentFields[DocumentField.photoBack] as File?;

        await sl<KycSharingService>().updateDocumentInfo(
          idType: _selectedDocumentType,
          idNumber: idNumber,
          countryCode: _selectedCountry?.code,
          frontImage: frontImage,
          backImage: backImage,
        );

        return true;
      } on Exception {
        if (!mounted) return false;

        showCpErrorSnackbar(context, message: context.l10n.failedToUpdateData);

        return false;
      }
    });

    if (!mounted) return;
    if (success) Navigator.pop(context, true);
  }

  void _updateDocumentField(DocumentField field, dynamic value) {
    setState(() {
      _documentFields[field] = value;
    });
  }

  Future<File?> _pickPhoto() async {
    final shouldProceed = await Navigator.of(
      context,
    ).push<bool>(MaterialPageRoute(builder: (context) => const DocumentInfoScreen()));

    if (!mounted) return null;

    return shouldProceed == true
        ? Navigator.of(
          context,
        ).push<File?>(MaterialPageRoute(builder: (context) => const DocumentCameraScreen()))
        : null;
  }

  Widget _buildDocumentFieldWidget(DocumentField field) {
    final isInRequiredList = _requiredFields.contains(field);
    final isRequired =
        isInRequiredList && _documentFieldsRelationship == RequirementRelationship.and;

    return switch (field) {
      DocumentField.idNumber => _IdNumberField(
        controller: _controllers[field]!,
        // ignore: avoid-type-casts, controlled type
        currentValue: _documentFields[field] as String? ?? '',
        onChanged: (value) => _updateDocumentField(field, value),
      ),
      DocumentField.photoFront => _PhotoUploadField(
        label: context.l10n.photoFront,
        isRequired: isRequired,
        onTap: () async {
          final photo = await _pickPhoto();
          if (photo != null) {
            _updateDocumentField(field, photo);
          }
        },
        // ignore: avoid-type-casts, controlled type
        currentValue: _documentFields[field] as File?,
      ),
      DocumentField.photoBack => _PhotoUploadField(
        label: context.l10n.photoBack,
        isRequired: isRequired,
        onTap: () async {
          final photo = await _pickPhoto();
          if (photo != null) {
            _updateDocumentField(field, photo);
          }
        },
        // ignore: avoid-type-casts, controlled type
        currentValue: _documentFields[field] as File?,
      ),
    };
  }

  List<DocumentField> get _requiredFields {
    final selectedDocType = _selectedDocumentType;
    if (selectedDocType == null) return [];

    return widget.requirement.requirements.parseRequiredFields(selectedDocType);
  }

  bool get _isValid {
    if (_selectedDocumentType == null) return false;

    if (_selectedCountry == null) return false;

    final requiredFields = _requiredFields;
    if (requiredFields.isEmpty) return true;

    return switch (_documentFieldsRelationship) {
      RequirementRelationship.and => requiredFields.every(_isFieldValid),
      RequirementRelationship.or => requiredFields.any(_isFieldValid),
    };
  }

  bool _isFieldValid(DocumentField field) {
    final value = _documentFields[field];

    return field == DocumentField.idNumber
        ? (_controllers[field]?.text.isNotEmpty ?? false)
        : value != null && (value is! String || value.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) => KycPage(
    title: context.l10n.documentTitle.toUpperCase(),
    children: [
      const _RequiredCountryNotice(),
      const SizedBox(height: 24),
      CountryPicker(
        backgroundColor: CpColors.blackGreyColor,
        placeholder: 'Country of Document',
        country: _selectedCountry,
        countries: _availableCountries,
        onSubmitted: (country) => setState(() => _selectedCountry = country),
      ),
      const SizedBox(height: 24),
      Text(
        context.l10n.selectDocumentType,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
      const SizedBox(height: 8),
      DocumentPicker(
        type: _selectedDocumentType,
        types: _availableDocumentTypes,
        onSubmitted:
            (docType) => setState(() {
              _selectedDocumentType = docType;
              _documentFields.clear();
              _initializeControllers();
            }),
      ),
      const SizedBox(height: 16),
      if (_selectedDocumentType != null)
        ..._requiredFields.map(
          (field) =>
              Column(children: [_buildDocumentFieldWidget(field), const SizedBox(height: 16)]),
        ),
      const SizedBox(height: 28),
      const Spacer(),
      ListenableBuilder(
        listenable: Listenable.merge(_controllers.values.toList()),
        builder:
            (context, child) => CpBottomButton(
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
    required this.onTap,
    this.currentValue,
  });

  final String label;
  final bool isRequired;
  final File? currentValue;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$label${isRequired ? ' *' : ''}',
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
      const SizedBox(height: 8),
      GestureDetector(
        onTap: onTap,
        child: Container(
          height: 120,
          decoration: const BoxDecoration(
            color: CpColors.blackGreyColor,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: _buildPhotoPreview(context),
        ),
      ),
    ],
  );

  Widget _buildPhotoPreview(BuildContext context) => switch (currentValue) {
    final file? => Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: LayoutBuilder(
            builder:
                (context, constraints) => Image.file(
                  file,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                ),
          ),
        ),
        Positioned(
          right: 8,
          bottom: 8,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.edit, color: Colors.white, size: 16),
                const SizedBox(width: 4),
                Text(
                  context.l10n.changeDocumentPhoto,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
    _ => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_a_photo, color: Colors.white.withOpacity(0.5)),
          const SizedBox(height: 8),
          Text(context.l10n.tapToUpload, style: TextStyle(color: Colors.white.withOpacity(0.5))),
        ],
      ),
    ),
  };
}

class _RequiredCountryNotice extends StatelessWidget {
  const _RequiredCountryNotice();

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: const BoxDecoration(
      color: CpColors.blackGreyColor,
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    child: Row(
      children: [
        Icon(Icons.info_outline, color: Colors.white.withOpacity(0.7), size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            context.l10n.documentFromCountry,
            style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14),
          ),
        ),
      ],
    ),
  );
}
