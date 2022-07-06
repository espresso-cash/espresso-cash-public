import 'dart:convert';

import 'package:cryptoplease/features/incoming_split_key_payment/bl/models.dart';
import 'package:cryptoplease/features/incoming_split_key_payment/bl/repository.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsSplitKeyIncomingRepository
    implements SplitKeyIncomingRepository {
  SharedPrefsSplitKeyIncomingRepository(this._prefs) {
    final data = _prefs.getString(_key);
    if (data == null) return;
    final value = SplitKeyIncomingFirstPart.fromJson(
      jsonDecode(data) as Map<String, dynamic>,
    );
    _value.add(value);
  }

  final _value = BehaviorSubject<SplitKeyIncomingFirstPart?>.seeded(null);
  final SharedPreferences _prefs;

  static const _key = 'split_key_incoming';

  @override
  Future<void> clear() async {
    _value.add(null);
    await _prefs.remove(_key);
  }

  @override
  Future<void> save(SplitKeyIncomingFirstPart firstPart) async {
    _value.add(firstPart);
    await _prefs.setString(_key, jsonEncode(firstPart.toJson()));
  }

  @override
  Stream<SplitKeyIncomingFirstPart?> watch() => _value.stream;
}
