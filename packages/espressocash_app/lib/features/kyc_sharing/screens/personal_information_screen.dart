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
import '../services/kyc_service.dart';
import '../utils/kyc_utils.dart';
import '../widgets/kyc_page.dart';
import '../widgets/kyc_text_field.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key, this.showActionButton = true});

  static Future<bool> push(BuildContext context, {bool showActionButton = true}) =>
      Navigator.of(context)
          .push<bool>(
            MaterialPageRoute(
              builder: (context) => PersonalInformationScreen(showActionButton: showActionButton),
            ),
          )
          .then((result) => result ?? false);

  final bool showActionButton;

  @override
  State<PersonalInformationScreen> createState() => _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dobController = TextEditingController();

  bool _readOnly = false;

  Country? _citizenship;

  bool get _isValid {
    final DateTime? dob = _parseDate(_dobController.text);

    return _firstNameController.text.trim().isNotEmpty &&
        _lastNameController.text.trim().isNotEmpty &&
        dob != null &&
        !dob.isAfter(DateTime.now()) &&
        _citizenship != null;
  }

  @override
  void initState() {
    super.initState();
    _initializeUserData();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();

    super.dispose();
  }

  void _initializeUserData() {
    final user = sl<KycSharingService>().value;
    final dob = user?.dob;
    _citizenship = Country.findByCode(user?.citizenshipCode ?? '');
    _firstNameController.text = user?.firstName ?? '';
    _lastNameController.text = user?.lastName ?? '';
    _dobController.text = dob != null ? DateFormat('dd/MM/yyyy').format(dob) : '';

    _readOnly = user?.hasPersonalDetails() == true;
  }

  Future<void> _handleSubmitted() async {
    final success = await runWithLoader<bool>(context, () async {
      try {
        final DateTime? dob = _parseDate(_dobController.text);
        final countryCode = _citizenship?.code;

        if (countryCode == null) {
          throw Exception();
        }

        await sl<KycSharingService>().updatePersonalInfo(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          dob: dob,
          citizenshipCode: countryCode,
        );

        if (!mounted) return false;

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

  VoidCallback? _getOnPressedCallback() {
    if (_readOnly) {
      return () => Navigator.pop(context, true);
    }

    return _isValid ? _handleSubmitted : null;
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
    title: context.l10n.personalInformationTitle.toUpperCase(),
    children: [
      KycTextField(
        controller: _firstNameController,
        inputType: TextInputType.name,
        placeholder: context.l10n.firstName,
        readOnly: _readOnly,
      ),
      const SizedBox(height: 10),
      KycTextField(
        controller: _lastNameController,
        inputType: TextInputType.name,
        placeholder: context.l10n.lastName,
        readOnly: _readOnly,
      ),
      const SizedBox(height: 10),
      CpDobTextField(
        controller: _dobController,
        placeholder: context.l10n.dateOfBirth,
        readonly: _readOnly,
      ),
      const SizedBox(height: 10),
      CountryPicker(
        backgroundColor: CpColors.blackGreyColor,
        placeholder: context.l10n.countryOfCitizenship,
        country: _citizenship,
        onSubmitted: (country) => setState(() => _citizenship = country),
        readOnly: _readOnly,
      ),
      const SizedBox(height: 28),
      const Spacer(),
      if (widget.showActionButton)
        ListenableBuilder(
          listenable: Listenable.merge([_firstNameController, _lastNameController, _dobController]),
          builder:
              (context, child) => CpBottomButton(
                horizontalPadding: 16,
                text: context.l10n.next,
                onPressed: _getOnPressedCallback(),
              ),
        ),
    ],
  );
}
