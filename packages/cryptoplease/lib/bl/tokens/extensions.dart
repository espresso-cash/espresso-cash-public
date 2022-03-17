import 'package:json_annotation/json_annotation.dart';

part 'extensions.g.dart';

@JsonSerializable()
class Extensions {
  const Extensions({
    this.coingeckoId,
  });

  factory Extensions.fromJson(Map<String, dynamic> data) =>
      _$ExtensionsFromJson(data);

  Map<String, dynamic> toJson() {
    throw const FormatException('cannot convert token to json');
  }

  final String? coingeckoId;
}
