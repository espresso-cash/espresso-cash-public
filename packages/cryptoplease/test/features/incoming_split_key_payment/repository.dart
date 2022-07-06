import 'package:cryptoplease/features/incoming_split_key_payment/bl/models.dart';
import 'package:cryptoplease/features/incoming_split_key_payment/bl/repository.dart';
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
