abstract class TransactionVersion {
  factory TransactionVersion.fromJson(dynamic value) => value is String
      ? LegacyTransactionVersion()
      : VersionedTransactionVersion(value as num);

  abstract final num? version;

  dynamic toJson();
}

class LegacyTransactionVersion implements TransactionVersion {
  LegacyTransactionVersion();

  @override
  final num? version = null;

  @override
  String toJson() => 'legacy';
}

class VersionedTransactionVersion implements TransactionVersion {
  const VersionedTransactionVersion(this.version);

  @override
  final num? version;

  @override
  num? toJson() => version;
}
