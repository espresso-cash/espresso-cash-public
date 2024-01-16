import 'package:json_annotation/json_annotation.dart';

part 'identity.g.dart';

/// An identity (or a public key)
@JsonSerializable()
class Identity {
  const Identity({
    required this.identity,
  });

  factory Identity.fromJson(Map<String, dynamic> json) =>
      _$IdentityFromJson(json);

  /// the identity pubkey of the current node (as a base-58
  /// encoded string)
  final String identity;

  Map<String, dynamic> toJson() => _$IdentityToJson(this);
}
