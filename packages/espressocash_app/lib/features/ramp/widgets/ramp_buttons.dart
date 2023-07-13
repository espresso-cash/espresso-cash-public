import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/l10n.dart';
import '../../../di.dart';
import '../../../routes.gr.dart';
import '../../../ui/button.dart';
import '../../profile/data/profile_repository.dart';
import '../../profile/models/country.dart';
import 'off_ramp_bottom_sheet.dart';
import 'on_ramp.dart';

class AddCashButton extends StatelessWidget {
  const AddCashButton({
    super.key,
    this.size = CpButtonSize.normal,
  });

  final CpButtonSize size;

  @override
  Widget build(BuildContext context) => Flexible(
        child: CpButton(
          size: size,
          minWidth: 250,
          text: context.l10n.ramp_btnAddCash,
          onPressed: () => context.ensureCountry(() {
            context.showRampNetworkOnRamp();
          }),
        ),
      );
}

class CashOutButton extends StatelessWidget {
  const CashOutButton({
    super.key,
    this.size = CpButtonSize.normal,
  });

  final CpButtonSize size;

  @override
  Widget build(BuildContext context) => Flexible(
        child: CpButton(
          size: size,
          minWidth: 250,
          text: context.l10n.ramp_btnCashOut,
          onPressed: () => context.ensureCountry(() {
            OffRampBottomSheet.show(context);
          }),
        ),
      );
}

extension on BuildContext {
  void ensureCountry(VoidCallback onSubmitted) {
    void onCountrySelected(Country country) {
      router.pop();
      sl<ProfileRepository>().profile =
          sl<ProfileRepository>().profile.copyWith(country: country.code);
      onSubmitted();
    }

    if (sl<ProfileRepository>().profile.country == null) {
      router.push<Country>(CountryPickerRoute(onSubmitted: onCountrySelected));
    } else {
      onSubmitted();
    }
  }
}
