import 'package:cryptoplease/features/incoming_split_key_payment/bl/models.dart';

abstract class SplitKeyIncomingRepository {
  Stream<SplitKeyIncomingFirstPart?> watch();
  Future<void> save(SplitKeyIncomingFirstPart firstPart);
  Future<void> clear();
}
