import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/colors.dart';
import '../../ramp_partner/models/payment_methods.dart';
import '../../ramp_partner/models/ramp_partner.dart';
import '../models/ramp_type.dart';

class PartnerTile extends StatelessWidget {
  const PartnerTile({
    super.key,
    required this.partner,
    required this.type,
    required this.onPartnerSelected,
  });

  final RampPartner partner;
  final RampType type;
  final ValueSetter<RampPartner> onPartnerSelected;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(
          vertical: 6.h,
          horizontal: 18.w,
        ),
        child: DecoratedBox(
          decoration: ShapeDecoration(
            color: CpColors.darkBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30.r),
              ),
            ),
          ),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30.r),
              ),
            ),
            leading: Container(
              alignment: Alignment.center,
              width: 40.w,
              child: partner.logo.image(),
            ),
            minLeadingWidth: 40.w,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 28.w, vertical: 10.h),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                partner.title,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            subtitle: Row(
              children: [
                for (final method in partner.paymentMethods) ...[
                  method.logo.svg(width: 30.w),
                  SizedBox(width: 4.w),
                ],
                if (partner == RampPartner.moneygram) ...[
                  Text(
                    switch (type) {
                      RampType.onRamp =>
                        context.l10n.moneygramPaymentMethodOnRamp,
                      RampType.offRamp =>
                        context.l10n.moneygramPaymentMethodOffRamp,
                    },
                    style: _subtitleStyle,
                  ),
                ],
                const Spacer(),
                Text(
                  context.l10n.rampMinimumTransferAmount(partner.minimumAmount),
                  style: _subtitleStyle,
                ),
              ],
            ),
            onTap: () => onPartnerSelected(partner),
          ),
        ),
      );
}

final _subtitleStyle = TextStyle(
  fontSize: 14.sp,
  color: Colors.white,
  fontWeight: FontWeight.w400,
);
