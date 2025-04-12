import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sealed_countries/sealed_countries.dart' as country;

part 'country.freezed.dart';
part 'country.g.dart';

@freezed
class Country with _$Country {
  const factory Country({required String name, required String code, required String dialCode}) =
      _Country;

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

  static List<Country> get all =>
      country.WorldCountry.list
          .where((c) => !_excludedCountries.contains(c.codeShort))
          .map((e) => e.toCountry)
          .toList();

  static Country? findByCode(String code) {
    if (code.isEmpty) return null;

    try {
      return country.WorldCountry.maybeFromCodeShort(code)?.toCountry;
    } on Exception {
      return null;
    }
  }
}

extension on country.WorldCountry {
  Country get toCountry => Country(name: name.name, code: codeShort, dialCode: idd.phoneCode());
}

const _excludedCountries = {'IR', 'KP', 'SY', 'RU'};
