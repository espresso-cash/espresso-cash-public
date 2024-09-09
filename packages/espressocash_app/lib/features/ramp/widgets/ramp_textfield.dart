import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../gen/assets.gen.dart';
import '../../../ui/colors.dart';
import '../../../ui/text_field.dart';
import '../../currency/models/currency.dart';
import '../../tokens/token.dart';
import '../../tokens/widgets/token_icon.dart';

class RampTextField extends StatelessWidget {
  const RampTextField({
    super.key,
    required this.currency,
    required this.controller,
    required this.label,
  });

  final String label;
  final Currency currency;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final logo = switch (currency) {
      FiatCurrency(:final countryCode) => countryCode != null
          ? CountryFlag.fromCountryCode(
              countryCode,
              shape: const Circle(),
              width: 36.w,
              height: 36.h,
            )
          : CircleAvatar(
              backgroundColor: CpColors.darkBackgroundColor,
              child: Assets.icons.money.svg(),
            ),
      CryptoCurrency(:final Token token) => TokenIcon(
          token: token,
          size: 36.w,
        ),
    };

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.w, bottom: 6.h),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          CpTextField(
            padding: EdgeInsets.symmetric(
              vertical: 12.h,
              horizontal: 24.w,
            ),
            controller: controller,
            inputType: const TextInputType.numberWithOptions(decimal: true),
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.none,
            backgroundColor: CpColors.darkBackgroundColor,
            placeholder: '0',
            placeholderColor: Colors.white,
            textColor: Colors.white,
            fontSize: 34.sp,
            fontWeight: FontWeight.w700,
            prefix: logo,
            suffix: Padding(
              padding: EdgeInsets.only(right: 24.w),
              child: Text(
                currency.symbol,
                style: TextStyle(
                  fontSize: 34.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
