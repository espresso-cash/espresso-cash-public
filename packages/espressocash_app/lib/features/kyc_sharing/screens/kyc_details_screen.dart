import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../di.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/back_button.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/loader.dart';
import '../../../ui/pick_image_container.dart';
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
  File? _photo;

  bool _isLoading = true;

  bool get _isValid =>
      _firstNameController.text.isNotEmpty &&
      _middleNameController.text.isNotEmpty &&
      _lastNameController.text.isNotEmpty &&
      _dobController.text.isNotEmpty &&
      _idController.text.isNotEmpty &&
      _photo != null &&
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

      await _fetchKycInfo();

      if (!mounted) return;

      showCpSnackbar(context, message: 'Success, Data updated');
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
    _idType = IdType.voterId;
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
        child: Scaffold(
          appBar: CpAppBar(
            scrolledUnderColor: CpColors.goldBackgroundColor,
            leading: const CpBackButton(),
            title: Text('Basic Information'.toUpperCase()),
          ),
          backgroundColor: CpColors.goldBackgroundColor,
          extendBodyBehindAppBar: true,
          body: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: SafeArea(
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          const SizedBox(height: 24),
                          PickImageContainer(
                            image: _photo,
                            pickImageClicked: () async {
                              final photo = await _openCamera();

                              if (photo != null && mounted) {
                                setState(() => _photo = photo);
                              }
                            },
                          ),
                          const SizedBox(height: 42),
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
                            onSubmitted: (country) =>
                                setState(() => _country = country),
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
                              text: 'Update',
                              onPressed: _isValid ? _handleSubmitted : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
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
