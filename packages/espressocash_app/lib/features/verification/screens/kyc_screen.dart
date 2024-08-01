import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../ui/app_bar.dart';
import '../../../ui/button.dart';
import '../../../ui/text_field.dart';
import '../../../ui/theme.dart';
import '../../country_picker/models/country.dart';
import '../../country_picker/widgets/country_picker.dart';
import '../widgets/id_picker.dart';

class KycScreen extends StatefulWidget {
  const KycScreen({super.key});

  static void push(BuildContext context) => Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => const KycScreen(),
        ),
      );

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
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
    // final photo = await _openCamera();

    // if (photo == null) {
    //   return;
    // }

    // if (!mounted) return;

    // await runWithLoader(
    //   context,
    //   () async {
    //     try {
    //       final state = context.read<WalletAppState>();

    //       await state.updateInfo(
    //         data: KycUserInfo(
    //           firstName: _firstNameController.text,
    //           middleName: _middleNameController.text,
    //           lastName: _lastNameController.text,
    //           dob: _dob?.toIso8601String() ?? '',
    //           countryCode: _country!.code,
    //           idType: _idType!.value,
    //           idNumber: _idController.text,
    //         ),
    //         photo: photo,
    //       );

    //       await state.generatePartnerToken(partnerAuthPk);

    //       await kycClient.requestKyc(
    //         KycRequest(
    //           secretKey: state.rawSecretKey,
    //           partnerToken: state.partnerToken,
    //           userPk: state.authPublicKey,
    //         ),
    //       );

    //       if (!mounted) return;

    //       showCpSnackbar(context, message: 'Success, KYC submitted');
    //     } on Exception catch (ex) {
    //       print('failed: $ex');

    //       if (!mounted) return;

    //       showCpErrorSnackbar(context, message: 'Failed to submit KYC');
    //     }
    //   },
    // );
  }

  // Future<File?> _openCamera() async {
  //   final result = await Navigator.of(context).push<File?>(
  //     MaterialPageRoute(
  //       builder: (context) => const CameraPage(),
  //     ),
  //   );

  //   return result;
  // }

  Future<void> _selectDob() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dob ?? DateTime.now(),
      firstDate: DateTime(1900, 1),
      lastDate: DateTime.now(),
    );
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
    _lastNameController.dispose();
    _middleNameController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          appBar: CpAppBar(
            title: Text('Basic Information'.toUpperCase()),
          ),
          backgroundColor: const Color(0xFFC8B57D),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
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

Future<String> fileToBase64(File file) async {
  final List<int> fileBytes = await file.readAsBytes();

  return base64Encode(fileBytes);
}
