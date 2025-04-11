import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/colors.dart';
import '../../../ui/picker_screen.dart';
import '../models/country.dart';

class CountryPicker extends StatelessWidget {
  const CountryPicker({
    super.key,
    this.country,
    this.countries,
    this.placeholder,
    this.backgroundColor = Colors.black,
    this.readOnly = false,
    required this.onSubmitted,
  });

  final Country? country;
  final List<Country>? countries;
  final String? placeholder;
  final Color backgroundColor;
  final bool readOnly;
  final ValueSetter<Country> onSubmitted;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: ShapeDecoration(color: backgroundColor, shape: const StadiumBorder()),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      onTap:
          readOnly
              ? null
              : () async {
                await CustomPickerScreen.push<Country>(
                  context: context,
                  title: context.l10n.selectCountryTitle,
                  items: countries ?? Country.all,
                  initial: country,
                  itemBuilder:
                      (context, country, {required bool selected}) => Text(
                        country.name,
                        style: TextStyle(fontSize: selected ? 19 : 17, color: Colors.white),
                      ),
                  onTap: (country, context) async => onSubmitted(country),
                );
              },
      title: Text(
        country?.name ?? placeholder ?? context.l10n.countryOfResidence,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16,
          height: 1.2,
          color: country != null ? Colors.white : CpColors.greyColor,
        ),
      ),
      trailing: const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.white, size: 28),
    ),
  );
}
