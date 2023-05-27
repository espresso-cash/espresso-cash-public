import 'package:json_annotation/json_annotation.dart';

part 'header.g.dart';

@JsonSerializable(createToJson: false)
class Header {
  const Header({
    required this.numRequiredSignatures,
    required this.numReadonlySignedAccounts,
    required this.numReadonlyUnsignedAccounts,
  });

  factory Header.fromJson(dynamic json) {
    if (json is List) {
      return Header(
        numRequiredSignatures: json.first as int,
        numReadonlyUnsignedAccounts: json[1] as int,
        numReadonlySignedAccounts: json[2] as int,
      );
    }

    return _$HeaderFromJson(json as Map<String, dynamic>);
  }

  final int numRequiredSignatures;
  final int numReadonlySignedAccounts;
  final int numReadonlyUnsignedAccounts;
}
