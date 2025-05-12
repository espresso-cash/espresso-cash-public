abstract class TransactionVersion {
  factory TransactionVersion.fromJson(dynamic value) =>
      // ignore: avoid-type-casts, controlled type
      value is String ? LegacyTransactionVersion() : VersionedTransactionVersion(value as num);

  abstract final num? version;

  dynamic toJson();
}

class LegacyTransactionVersion implements TransactionVersion {
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
