import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/bottom_button.dart';
import '../../../ui/colors.dart';
import '../../../ui/dob_text_field.dart';
import '../../../ui/loader.dart';
import '../../../ui/radio_button.dart';
import '../../../ui/snackbar.dart';
import '../../country_picker/models/country.dart';
import '../../country_picker/widgets/country_picker.dart';
import '../models/document_type.dart';
import '../services/kyc_service.dart';
import '../widgets/document_picker.dart';
import '../widgets/kyc_page.dart';
import '../widgets/kyc_text_field.dart';

class BasicInformationScreen extends StatefulWidget {
  const BasicInformationScreen({super.key});

  static Future<bool> push(BuildContext context) => Navigator.of(context)
      .push<bool>(
        MaterialPageRoute(
          builder: (context) => const BasicInformationScreen(),
        ),
      )
      .then((result) => result ?? false);

  @override
  State<BasicInformationScreen> createState() => _BasicInformationScreenState();
}

class _BasicInformationScreenState extends State<BasicInformationScreen> {
  final _idController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dobController = TextEditingController();

  bool _isShareData = false;

  Country? _country;
  DocumentType? _idType;

  bool get _isValid {
    final DateTime? dob = _parseDate(_dobController.text);

    return _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        dob != null &&
        !dob.isAfter(DateTime.now()) &&
        _idController.text.isNotEmpty &&
        _isShareData &&
        _idType != null &&
        _country != null;
  }

  Future<void> _handleSubmitted() async {
    final success = await runWithLoader<bool>(
      context,
      () async {
        try {
          final DateTime? dob = _parseDate(_dobController.text);
          final countryCode = _country?.code;
          final idTypeValue = _idType?.value;

          if (countryCode == null || idTypeValue == null) {
            throw Exception();
          }

          await sl<KycSharingService>().updateBasicInfo(
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            dob: dob,
            countryCode: countryCode,
            idType: _idType,
            idNumber: _idController.text,
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
    final date = dateFormat.tryParse(text);

    final List<String> parts = text.split('/');

    return parts.length == 3 && parts[2].length == 4 ? date : null;
  }

  @override
  void dispose() {
    _idController.dispose();
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => KycPage(
        title: context.l10n.basicInformation,
        children: [
          const SizedBox(height: 30),
          CountryPicker(
            backgroundColor: CpColors.blackGreyColor,
            country: _country,
            onSubmitted: (country) => setState(() => _country = country),
          ),
          const SizedBox(height: 16),
          KycTextField(
            controller: _firstNameController,
            inputType: TextInputType.name,
            placeholder: context.l10n.firstName,
          ),
          const SizedBox(height: 16),
          KycTextField(
            controller: _lastNameController,
            inputType: TextInputType.name,
            placeholder: context.l10n.lastName,
          ),
          const SizedBox(height: 16),
          CpDobTextField(
            controller: _dobController,
            placeholder: context.l10n.dateOfBirth,
          ),
          const SizedBox(height: 16),
          DocumentPicker(
            type: _idType,
            onSubmitted: (idType) => setState(() => _idType = idType),
          ),
          const SizedBox(height: 16),
          KycTextField(
            controller: _idController,
            inputType: TextInputType.text,
            placeholder: context.l10n.idNumber,
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => setState(() => _isShareData = !_isShareData),
            child: Row(
              children: [
                CpRadioButton(
                  value: _isShareData,
                  onChanged: (value) => setState(() => _isShareData = value),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    context.l10n.allowShareDataText,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      letterSpacing: 0.19,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          const Spacer(),
          ListenableBuilder(
            listenable: Listenable.merge([
              _firstNameController,
              _lastNameController,
              _dobController,
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
