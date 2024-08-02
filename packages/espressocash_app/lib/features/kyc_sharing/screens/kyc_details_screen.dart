import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../ui/button.dart';
import '../../../ui/form_page.dart';
import '../../../ui/loader.dart';
import '../../../ui/snackbar.dart';
import '../../../ui/text_field.dart';
import '../../country_picker/models/country.dart';
import '../../country_picker/widgets/country_picker.dart';
import '../models/id_type.dart';
import '../models/kyc_model.dart';
import '../services/kyc_service.dart';
import '../widgets/id_picker.dart';
import 'kyc_camera_screen.dart';

class KycDetailsScreen extends StatefulWidget {
  const KycDetailsScreen({super.key});

  static void push(
    BuildContext context,
  ) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => const KycDetailsScreen(),
        ),
      );

  @override
  State<KycDetailsScreen> createState() => _KycDetailsScreenState();
}

class _KycDetailsScreenState extends State<KycDetailsScreen> {
  final _idController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dobController = TextEditingController();

  DateTime? _dob;

  Country? _country;
  IdType? _idType;

  bool get _isValid =>
      _firstNameController.text.isNotEmpty &&
      _middleNameController.text.isNotEmpty &&
      _lastNameController.text.isNotEmpty &&
      _dobController.text.isNotEmpty &&
      _idController.text.isNotEmpty &&
      _country != null;

  Future<void> _handleSubmitted() async {
    final photo = await _openCamera();

    if (photo == null) {
      return;
    }

    if (!mounted) return;

    await runWithLoader(
      context,
      () async {
        try {
          final service = sl<KycSharingService>();

          await service.updateInfo(
            data: KycUserInfo(
              firstName: _firstNameController.text,
              middleName: _middleNameController.text,
              lastName: _lastNameController.text,
              dob: _dob?.toIso8601String() ?? '',
              countryCode: _country!.code,
              idType: _idType!.value,
              idNumber: _idController.text,
            ),
            photo: photo,
          );

          if (!mounted) return;

          showCpSnackbar(context, message: 'Success, KYC submitted');
        } on Exception {
          if (!mounted) return;

          showCpErrorSnackbar(context, message: 'Failed to submit KYC');
        }
      },
    );
  }

  Future<File?> _openCamera() => Navigator.of(context).push<File?>(
        MaterialPageRoute(
          builder: (context) => const KycCameraScreen(),
        ),
      );

  Future<void> _selectDob() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dob ?? DateTime.now(),
      firstDate: DateTime(1900, 1),
      lastDate: DateTime.now(),
    );

    if (!mounted) return;

    if (picked != null) {
      setState(() {
        _dob = picked;
        _dobController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // Hardcode values for now
    _country = Country.findByCode('NG');
    _idType = IdType.voterId;
    _idController.text = '0000000000000000004';
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
  Widget build(BuildContext context) => FormPage(
        colorTheme: FormPageColorTheme.gold,
        title: Text('Basic Information'.toUpperCase()),
        header: FormPageHeader(
          title: const SizedBox.shrink(),
          description: const Text(
            'KYC Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          icon: Assets.images.identityGraphic,
        ),
        child: Column(
          children: [
            _ProfileTextField(
              controller: _firstNameController,
              inputType: TextInputType.text,
              placeholder: 'First Name',
            ),
            const SizedBox(height: 8),
            _ProfileTextField(
              controller: _middleNameController,
              inputType: TextInputType.text,
              placeholder: 'Middle Name',
            ),
            const SizedBox(height: 8),
            _ProfileTextField(
              controller: _lastNameController,
              inputType: TextInputType.text,
              placeholder: 'Last Name',
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _selectDob,
              child: AbsorbPointer(
                child: _ProfileTextField(
                  controller: _dobController,
                  inputType: TextInputType.text,
                  placeholder: 'Date of Birth',
                ),
              ),
            ),
            const SizedBox(height: 8),
            CountryPicker(
              country: _country,
              onSubmitted: (country) => setState(() => _country = country),
            ),
            const SizedBox(height: 8),
            IdPicker(
              type: _idType,
              enabled: false,
            ),
            const SizedBox(height: 8),
            _ProfileTextField(
              controller: _idController,
              inputType: TextInputType.text,
              placeholder: 'ID Number',
              disabled: true,
            ),
            const SizedBox(height: 28),
            const Spacer(),
            ListenableBuilder(
              listenable: Listenable.merge([
                _firstNameController,
                _lastNameController,
                _dobController,
              ]),
              builder: (context, child) => CpButton(
                width: double.infinity,
                text: 'Next',
                onPressed: _isValid ? _handleSubmitted : null,
              ),
            ),
          ],
        ),
      );
}

class _ProfileTextField extends StatelessWidget {
  const _ProfileTextField({
    required this.controller,
    required this.inputType,
    required this.placeholder,
    this.disabled = false,
  });

  final TextEditingController controller;
  final TextInputType inputType;
  final String placeholder;
  final bool disabled;

  @override
  Widget build(BuildContext context) => AbsorbPointer(
        absorbing: disabled,
        child: CpTextField(
          padding: const EdgeInsets.only(
            top: 18,
            bottom: 16,
            left: 26,
            right: 26,
          ),
          controller: controller,
          inputType: inputType,
          textInputAction: TextInputAction.next,
          backgroundColor: const Color(0xFF9D8A59),
          placeholder: placeholder,
          placeholderColor: Colors.white,
          textColor: Colors.white,
          fontSize: 16,
        ),
      );
}
