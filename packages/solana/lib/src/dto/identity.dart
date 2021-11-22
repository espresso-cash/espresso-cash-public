import 'package:json_annotation/json_annotation.dart';

part 'identity.g.dart';

/// An identity (or a public key)
@JsonSerializable(createFactory: true, includeIfNull: false)
class Identity {
  const Identity({
    required this.identity,
  });

  factory Identity.fromJson(Map<String, dynamic> json) =>
      _$IdentityFromJson(json);

  Map<String, dynamic> toJson() => _$IdentityToJson(this);

  /// the identity pubkey of the current node (as a base-58
  /// encoded string)
  final String identity;
}
