import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../di.dart';
import '../../../ui/button.dart';
import '../../../ui/loader.dart';
import '../../../ui/radio_button.dart';
import '../../../ui/snackbar.dart';
import '../../country_picker/models/country.dart';
import '../../country_picker/widgets/country_picker.dart';
import '../data/kyc_repository.dart';
import '../models/id_type.dart';
import '../models/kyc_model.dart';
import '../services/kyc_service.dart';
import '../widgets/id_picker.dart';
import '../widgets/kyc_text_field.dart';
import 'identity_verification_screen.dart';
import 'kyc_camera_screen.dart';
import 'kyc_screen.dart';

class BasicInformationScreen extends StatefulWidget {
  const BasicInformationScreen({super.key});

  static void push(BuildContext context) => Navigator.of(context).push<void>(
        MaterialPageRoute(builder: (context) => const BasicInformationScreen()),
      );

  static void pushReplacement(BuildContext context) =>
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (context) => const BasicInformationScreen(),
        ),
      );

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

  DateTime? _dob;

  Country? _country;
  IdType? _idType;
  File? _photo;

  bool _isLoading = true;

  bool get _isValid =>
      _firstNameController.text.isNotEmpty &&
      _lastNameController.text.isNotEmpty &&
      _dobController.text.isNotEmpty &&
      _idController.text.isNotEmpty &&
      //    _photo != null &&
      _isShareData &&
      _country != null;

  Future<void> _handleSubmitted() async {
    setState(() => _isLoading = true);

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
        photo: _photo!,
      );

      if (!mounted) return;

      showCpSnackbar(context, message: 'Success, Data updated');
      sl<KycRepository>().hasPassedKyc = true;
      IdentityVerificationScreen.pushReplacement(context);
    } on Exception {
      showCpErrorSnackbar(context, message: 'Failed to update data');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
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

  Future<void> _fetchKycInfo() async {
    setState(() => _isLoading = true);

    try {
      final service = sl<KycSharingService>();
      final kycInfo = await service.fetchUser();

      if (!mounted) return;
      if (kycInfo == null) return;

      setState(() {
        _firstNameController.text = kycInfo.firstName;
        _middleNameController.text = kycInfo.middleName;
        _lastNameController.text = kycInfo.lastName;
        if (kycInfo.dob.isNotEmpty) {
          _dob = DateTime.parse(kycInfo.dob);
          _dobController.text = DateFormat('dd/MM/yyyy').format(_dob!);
        }
        _country = Country.findByCode(kycInfo.countryCode);
        _idController.text = kycInfo.idNumber;

        _photo = kycInfo.photo;
      });
    } on Exception {
      if (!mounted) return;

      showCpErrorSnackbar(context, message: 'Failed to fetch KYC information');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    // Hardcode values for now
    _country = Country.findByCode('NG');
    _idController.text = '0000000000000000004';

    _fetchKycInfo();
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
  Widget build(BuildContext context) => CpLoader(
        isLoading: _isLoading,
        child: KycScreen(
          title: 'Basic Information',
          children: [
            const SizedBox(height: 30),
            CountryPicker(
              country: _country,
              onSubmitted: (country) => setState(() => _country = country),
            ),
            const SizedBox(height: 16),
            KycTextField(
              controller: _firstNameController,
              inputType: TextInputType.name,
              placeholder: 'First Name',
            ),
            const SizedBox(height: 18),
            KycTextField(
              controller: _lastNameController,
              inputType: TextInputType.name,
              placeholder: 'Last Name',
            ),
            const SizedBox(height: 18),
            GestureDetector(
              onTap: _selectDob,
              child: AbsorbPointer(
                child: KycTextField(
                  controller: _dobController,
                  inputType: TextInputType.text,
                  placeholder: 'Date of Birth',
                ),
              ),
            ),
            const SizedBox(height: 18),
            IdPicker(
              type: _idType,
              onSubmitted: (idType) => setState(() => _idType = idType),
            ),
            const SizedBox(height: 18),
            KycTextField(
              controller: _idController,
              inputType: TextInputType.text,
              placeholder: 'ID Number',
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                CpRadioButton(
                  value: _isShareData,
                  onChanged: (value) => setState(() => _isShareData = value),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Allow Espresso Cash partners to share this data for the purposes of deposits and withdrawals.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      letterSpacing: 0.19,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ListenableBuilder(
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
            ),
          ],
        ),
      );
}
