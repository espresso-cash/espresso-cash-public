import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/colors.dart';
import '../../../ui/picker_screen.dart';
import '../../../ui/text_field.dart';
import '../../country_picker/models/country.dart';

class PhoneNumberTextField extends StatefulWidget {
  const PhoneNumberTextField({
    super.key,
    required this.controller,
    required this.placeholder,
    this.initialCountry,
    this.onPhoneChanged,
  });

  final TextEditingController controller;
  final String placeholder;
  final Country? initialCountry;
  final ValueSetter<String>? onPhoneChanged;

  @override
  State<PhoneNumberTextField> createState() => _PhoneNumberTextFieldState();
}

class _PhoneNumberTextFieldState extends State<PhoneNumberTextField> {
  Country? _selectedCountry;

  String get _fullPhoneNumber {
    final dialCode = _selectedCountry?.dialCode ?? '';
    final number = widget.controller.text.trim();

    return '$dialCode$number';
  }

  void _notifyPhoneChanged() {
    widget.onPhoneChanged?.call(_fullPhoneNumber);
  }

  @override
  void initState() {
    super.initState();
    _selectedCountry = widget.initialCountry;
    widget.controller.addListener(_notifyPhoneChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_notifyPhoneChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CpTextField(
    padding: const EdgeInsets.only(top: 18, bottom: 16, left: 8, right: 26),
    autocorrect: false,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    controller: widget.controller,
    inputType: TextInputType.phone,
    textInputAction: TextInputAction.next,
    backgroundColor: CpColors.lightGreyColor,
    placeholder: widget.placeholder,
    placeholderColor: CpColors.greyColor,
    textColor: Colors.white,
    prefix: Padding(
      padding: const EdgeInsets.only(left: 26),
      child: GestureDetector(
        onTap: () async {
          await CustomPickerScreen.push<Country>(
            context: context,
            title: context.l10n.selectCountryTitle,
            items: Country.all,
            initial: _selectedCountry,
            itemBuilder:
                (context, country, {required bool selected}) => Row(
                  children: [
                    SizedBox(
                      width: 70,
                      child: Text(
                        country.dialCode,
                        style: TextStyle(fontSize: selected ? 19 : 17, color: CpColors.yellowColor),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        country.name,
                        style: TextStyle(fontSize: selected ? 19 : 17, color: Colors.white),
                      ),
                    ),
                  ],
                ),
            onTap: (country, _) async {
              setState(() => _selectedCountry = country);
              _notifyPhoneChanged();
            },
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _selectedCountry?.dialCode ?? '',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: CpColors.yellowColor,
                height: 1.2,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down_outlined, color: CpColors.yellowColor, size: 20),
          ],
        ),
      ),
    ),
  );
}
