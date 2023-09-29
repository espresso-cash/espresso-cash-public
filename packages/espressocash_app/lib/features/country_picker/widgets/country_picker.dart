import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../models/country.dart';
import '../screens/country_picker_screen.dart';

class CountryPicker extends StatelessWidget {
  const CountryPicker({
    super.key,
    this.country,
    required this.onSubmitted,
  });

  final Country? country;
  final ValueSetter<Country> onSubmitted;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: const ShapeDecoration(
          color: Colors.black,
          shape: StadiumBorder(),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          onTap: () => context.router.push<Country>(
            CountryPickerScreen.route(
              initial: country,
              onSubmitted: (country) {
                context.router.pop();
                onSubmitted(country);
              },
            ),
          ),
          title: Text(
            country?.name ?? context.l10n.countryOfResidence,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 20,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_down_outlined,
            color: Colors.white,
            size: 34,
          ),
        ),
      );
}
