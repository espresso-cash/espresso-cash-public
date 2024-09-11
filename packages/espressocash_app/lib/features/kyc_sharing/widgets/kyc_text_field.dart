import 'package:flutter/material.dart';

import '../../../ui/colors.dart';
import '../../../ui/text_field.dart';

class KycTextField extends StatelessWidget {
  const KycTextField({
    super.key,
    required this.controller,
    required this.inputType,
    required this.placeholder,
  });

  final TextEditingController controller;
  final TextInputType inputType;
  final String placeholder;

  @override
  Widget build(BuildContext context) => CpTextField(
        padding: const EdgeInsets.only(
          top: 18,
          bottom: 16,
          left: 26,
          right: 26,
        ),
        fontWeight: FontWeight.w500,
        fontSize: 16,
        controller: controller,
        inputType: inputType,
        textInputAction: TextInputAction.next,
        backgroundColor: CpColors.grey,
        placeholder: placeholder,
        placeholderColor: Colors.white,
        textColor: Colors.white,
      );
}
