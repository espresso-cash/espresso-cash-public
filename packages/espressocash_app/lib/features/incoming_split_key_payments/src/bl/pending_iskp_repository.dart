import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/split_key_payments.dart';

@injectable
class PendingISKPRepository {
  const PendingISKPRepository();

  Future<SplitKeyFirstLink?> load() async {
    final data = await SharedPreferences.getInstance()
        .then((value) => value.getString(_key));
    if (data == null) return null;

    try {
      return SplitKeyFirstLink.fromJson(
        jsonDecode(data) as Map<String, dynamic>,
      );
    } on Object {
      return null;
    }
  }

  Future<void> save(SplitKeyFirstLink firstPart) async =>
      SharedPreferences.getInstance().then(
        (value) => value.setString(_key, jsonEncode(firstPart.toJson())),
      );

  Future<void> clear() async =>
      SharedPreferences.getInstance().then((value) => value.remove(_key));

  static const _key = 'pending_iskp';
}
