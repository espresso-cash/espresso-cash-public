import 'package:json_annotation/json_annotation.dart';

part 'transaction_version.g.dart';

@JsonSerializable(createFactory: false)
abstract class TransactionVersion {
  factory TransactionVersion.fromJson(dynamic value) {
    if (value is String) {
      return LegacyTransactionVersion();
    } else {
      return VersionedTransactionVersion(value as num);
    }
  }

  abstract final num? version;
}

class LegacyTransactionVersion implements TransactionVersion {
  LegacyTransactionVersion();

  @override
  final num? version = null;
}

class VersionedTransactionVersion implements TransactionVersion {
  const VersionedTransactionVersion(this.version);

  @override
  final num? version;
}
