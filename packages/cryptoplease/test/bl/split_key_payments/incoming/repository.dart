import 'package:cryptoplease/bl/split_key_payments/incoming/repository.dart';
import 'package:cryptoplease/bl/split_key_payments/models.dart';
import 'package:rxdart/subjects.dart';

class MemorySplitKeyIncomingRepository implements SplitKeyIncomingRepository {
  final _value = BehaviorSubject<SplitKeyIncomingFirstPart?>.seeded(null);

  @override
  Future<void> clear() async {
    _value.add(null);
  }

  @override
  @override
  Future<void> save(SplitKeyIncomingFirstPart firstPart) async {
    _value.add(firstPart);
  }

  @override
  Stream<SplitKeyIncomingFirstPart?> watch() => _value.stream;
}
