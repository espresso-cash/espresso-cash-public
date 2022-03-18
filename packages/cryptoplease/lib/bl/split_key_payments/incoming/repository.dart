import 'package:cryptoplease/bl/split_key_payments/models.dart';

abstract class SplitKeyIncomingRepository {
  Stream<SplitKeyIncomingFirstPart?> watch();
  Future<void> save(SplitKeyIncomingFirstPart firstPart);
  Future<void> clear();
}
