import 'package:json_annotation/json_annotation.dart';

part 'large_account.g.dart';

/// A large account
@JsonSerializable(createToJson: false)
class LargeAccount {
  const LargeAccount({
    required this.address,
    required this.lamports,
  });

  factory LargeAccount.fromJson(Map<String, dynamic> json) =>
      _$LargeAccountFromJson(json);

  /// base-58 encoded address of the account
  final String address;

  /// Number of lamports in the account, as a u64
  final int lamports;
}
