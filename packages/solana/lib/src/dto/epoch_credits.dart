class EpochCredits {
  const EpochCredits({
    required this.epoch,
    required this.credits,
    required this.previousCredits,
  });

  factory EpochCredits.fromJson(dynamic json) {
    if (json is! List<dynamic>) {
      throw FormatException(
        'expected array with 3 integers and got ${json.runtimeType}',
      );
    }

    final integers = json.whereType<int>().toList(growable: false);
    if (integers.length != 3) {
      throw FormatException(
        'expected array with 3 integers but there were ${integers.length} only',
      );
    }

    return EpochCredits(
      epoch: integers[0],
      credits: integers[1],
      previousCredits: integers[2],
    );
  }

  Map<String, dynamic> toJson() {
    throw UnsupportedError('converting this to json is not useful');
  }

  final int epoch;
  final int credits;
  final int previousCredits;
}
