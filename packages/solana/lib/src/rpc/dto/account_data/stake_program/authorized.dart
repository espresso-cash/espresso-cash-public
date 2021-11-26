import 'package:json_annotation/json_annotation.dart';

part 'authorized.g.dart';

@JsonSerializable()
class Authorized {
  const Authorized({
    required this.staker,
    required this.withdrawer,
  });

  factory Authorized.fromJson(Map<String, dynamic> json) =>
      _$AuthorizedFromJson(json);

  final String staker;
  final String withdrawer;
}
