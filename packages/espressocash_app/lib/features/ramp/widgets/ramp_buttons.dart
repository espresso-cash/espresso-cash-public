import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../l10n/l10n.dart';
import '../../../di.dart';
import '../../../ui/button.dart';
import '../../accounts/models/account.dart';
import '../../profile/data/profile_repository.dart';
import '../../profile/models/country.dart';
import '../../profile/screens/country_picker_screen.dart';
import '../data/coinflow_repository.dart';
import '../screens/coinflow/offramp_webview_screen.dart';
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
          onPressed: () async {
            final country = await context.ensureCountry();
            if (context.mounted) {
              context.showRampNetworkOnRamp(country.code);
            }
          },
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
          onPressed: () async {
            // final state = context.read<MyAccount>();
            // final address = state.publicKey;

            // final repo = sl<CoinflowRepository>();
            // const txId =
            //     'g2JBpjbwvCJ3iEc5soDSq78DYoxwNG3cRjhwRQhQPue4na8fhQ7WofbM3xC2gHZbKXULxTP8bqw4tkbTqLAffdk';
            // final walletId = address.toBase58();
            // final walletId2 = '8ECxbfaZokFmyB8yKrL9kpFM5NYKbYhz199E9ysLAK3V';

            // final test =
            //     await repo.getWithdrawalStatus(txId: txId, walletId: walletId2);
            // print(test?.updatedAt);

            final country = await context.ensureCountry();
            if (context.mounted) {
              if (country == Country.findByCode('US')) {
                unawaited(context.router.push(CoinflowOffRampScreen.route()));
              } else {
                unawaited(OffRampBottomSheet.show(context));
              }
            }
          },
        ),
      );
}

extension on BuildContext {
  Future<Country> ensureCountry() {
    final completer = Completer<Country>();

    void onCountrySelected(Country country) {
      router.pop();
      sl<ProfileRepository>().profile =
          sl<ProfileRepository>().profile.copyWith(country: country.code);
      completer.complete(country);
    }

    final country =
        sl<ProfileRepository>().profile.country?.let(Country.findByCode);
    if (country == null) {
      router.push(CountryPickerScreen.route(onSubmitted: onCountrySelected));
    } else {
      completer.complete(country);
    }

    return completer.future;
  }
}
