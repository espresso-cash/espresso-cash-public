import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/colors.dart';
import '../../../ui/picker_screen.dart';
import '../models/country.dart';

class CountryPicker extends StatelessWidget {
  const CountryPicker({
    super.key,
    this.country,
    this.backgroundColor = Colors.black,
    required this.onSubmitted,
  });

  final Country? country;
  final Color backgroundColor;
  final ValueSetter<Country> onSubmitted;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: const StadiumBorder(),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          onTap: () async {
            await CustomPickerScreen.push<Country>(
              context: context,
              title: context.l10n.selectCountryTitle,
              items: Country.all,
              initial: country,
              itemBuilder: (context, country, {required bool selected}) => Text(
                country.name,
                style: TextStyle(
                  fontSize: selected ? 19 : 17,
                  color: Colors.white,
                ),
              ),
              onTap: (country, context) async {
                await Future.microtask(() => onSubmitted(country));
              },
            );
          },
          title: Text(
            country?.name ?? context.l10n.countryOfResidence,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16,
              height: 1.2,
              color: country != null ? Colors.white : CpColors.greyColor,
            ),
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_down_outlined,
            color: Colors.white,
            size: 28,
          ),
        ),
      );
}
