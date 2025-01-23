import '../../../data/db/db.dart';

extension OffRampOrderRowExt on OffRampOrderRow {
  Map<String, dynamic> get toSentry {
    final json = toJson();

    const filter = ['transaction', 'slot'];

    json.removeWhere(
      (key, value) =>
          value == null || value == '' || filter.contains(key) || value == 0.0,
    );

    return json;
  }
}

extension OnRampOrderRowExt on OnRampOrderRow {
  Map<String, dynamic> get toSentry => toJson()
    ..removeWhere(
      (key, value) => value == null || value == '' || value == 0.0,
    );
}
