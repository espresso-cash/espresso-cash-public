import 'dart:convert';

import 'package:cryptoplease/features/incoming_split_key_payments/bl/pending_iskp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PendingISKPRepository {
  Future<ISKPFirstPart?> load() async {
    final data = await SharedPreferences.getInstance()
        .then((value) => value.getString(_key));
    if (data == null) return null;

    try {
      return ISKPFirstPart.fromJson(jsonDecode(data) as Map<String, dynamic>);
    } on Object {
      return null;
    }
  }

  Future<void> save(ISKPFirstPart firstPart) async =>
      SharedPreferences.getInstance().then(
        (value) => value.setString(_key, jsonEncode(firstPart.toJson())),
      );

  Future<void> clear() async =>
      SharedPreferences.getInstance().then((value) => value.remove(_key));

  static const _key = 'pending_iskp';
}
