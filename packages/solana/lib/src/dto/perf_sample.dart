import 'package:json_annotation/json_annotation.dart';

part 'perf_sample.g.dart';

/// A performance sample
@JsonSerializable(createFactory: true, includeIfNull: false)
class PerfSample {
  const PerfSample({
    required this.slot,
    required this.numTransactions,
    required this.numSlots,
    required this.samplePeriodSec,
  });

  factory PerfSample.fromJson(Map<String, dynamic> json) =>
      _$PerfSampleFromJson(json);

  Map<String, dynamic> toJson() => _$PerfSampleToJson(this);

  /// Slot in which sample was taken at.
  final int slot;

  /// Number of transactions in sample.
  final int numTransactions;

  /// Number of slots in sample.
  final int numSlots;

  /// Number of seconds in a sample window.
  final int samplePeriodSec;
}
