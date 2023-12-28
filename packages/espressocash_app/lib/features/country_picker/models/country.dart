// ignore_for_file: invalid_annotation_target

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'country.freezed.dart';
part 'country.g.dart';

@JsonLiteral('country_list.json', asConst: true)
const List<Map<String, dynamic>> _countryList = _$_countryListJsonLiteral;

@freezed
class Country with _$Country {
  const factory Country({
    @JsonKey(name: 'Name') required String name,
    @JsonKey(name: 'Code') required String code,
  }) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  static List<Country> get all => _countryList.map(Country.fromJson).toList();

  static Country? findByCode(String code) =>
      all.firstWhereOrNull((c) => c.code == code);
}
