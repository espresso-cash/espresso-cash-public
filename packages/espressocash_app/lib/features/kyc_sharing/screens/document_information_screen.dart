import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/bottom_button.dart';
import '../../../ui/colors.dart';
import '../../../ui/dob_text_field.dart';
import '../../../ui/loader.dart';
import '../../../ui/snackbar.dart';
import '../../country_picker/models/country.dart';
import '../../country_picker/widgets/country_picker.dart';
import '../models/document_type.dart';
import '../services/kyc_service.dart';
import '../utils/kyc_utils.dart';
import '../widgets/document_picker.dart';
import '../widgets/kyc_page.dart';
import '../widgets/kyc_text_field.dart';

class DocumentInformationScreen extends StatefulWidget {
  const DocumentInformationScreen({super.key});

  static Future<bool> push(BuildContext context) => Navigator.of(context)
      .push<bool>(
        MaterialPageRoute(
          builder: (context) => const DocumentInformationScreen(),
        ),
      )
      .then((result) => result ?? false);

  @override
  State<DocumentInformationScreen> createState() =>
      _DocumentInformationScreenState();
}

class _DocumentInformationScreenState extends State<DocumentInformationScreen> {
  final _idNumberController = TextEditingController();
  final _expirationDateController = TextEditingController();

  Country? _country;
  DocumentType? _idType;

  bool get _isValid {
    final DateTime? expirationDate = _parseDate(_expirationDateController.text);

    return expirationDate != null &&
        !expirationDate.isBefore(DateTime.now()) &&
        _idNumberController.text.trim().isNotEmpty &&
        _idType != null &&
        _country != null;
  }

  @override
  void initState() {
    super.initState();
    _initializeUserData();
  }

  @override
  void dispose() {
    _idNumberController.dispose();
    _expirationDateController.dispose();

    super.dispose();
  }

  void _initializeUserData() {
    final user = sl<KycSharingService>().value;
    final dob = user?.dob;
    _country = Country.findByCode(user?.countryCode ?? '');
    _expirationDateController.text =
        dob != null ? DateFormat('dd/MM/yyyy').format(dob) : '';
    _idType = user?.documentType?.toDocumentType();
    _idNumberController.text = user?.documentNumber ?? '';
  }

  Future<void> _handleSubmitted() async {
    final success = await runWithLoader<bool>(
      context,
      () async {
        try {
          final DateTime? expirationDate =
              _parseDate(_expirationDateController.text);
          final countryCode = _country?.code;
          final idTypeValue = _idType?.value;

          if (countryCode == null || idTypeValue == null) {
            throw Exception();
          }

          await sl<KycSharingService>().updateDocumentInfo(
            expirationDate: expirationDate,
            countryCode: countryCode,
            idType: _idType,
            idNumber: _idNumberController.text,
          );

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

  DateTime? _parseDate(String text) {
    if (text.isEmpty) return null;

    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    final date = dateFormat.tryParseUtc(text);

    final List<String> parts = text.split('/');

    return parts.length == 3 && parts[2].length == 4 ? date : null;
  }

  @override
  Widget build(BuildContext context) => KycPage(
        title: 'Document'.toUpperCase(),
        children: [
          CountryPicker(
            backgroundColor: CpColors.blackGreyColor,
            country: _country,
            onSubmitted: (country) => setState(() => _country = country),
          ),
          const SizedBox(height: 10),
          DocumentPicker(
            type: _idType,
            onSubmitted: (idType) => setState(() => _idType = idType),
          ),
          const SizedBox(height: 10),
          KycTextField(
            controller: _idNumberController,
            inputType: TextInputType.text,
            placeholder: context.l10n.idNumber,
          ),
          const SizedBox(height: 10),
          CpDobTextField(
            controller: _expirationDateController,
            placeholder: 'Expiration Date',
          ),
          const SizedBox(height: 28),
          const Spacer(),
          ListenableBuilder(
            listenable: Listenable.merge([
              _expirationDateController,
              _idNumberController,
            ]),
            builder: (context, child) => CpBottomButton(
              horizontalPadding: 16,
              text: context.l10n.next,
              onPressed: _isValid ? _handleSubmitted : null,
            ),
          ),
        ],
      );
}
