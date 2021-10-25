import 'package:solana/src/rpc_client/rpc_types.dart';

extension CommitmentValue on Commitment {
  String toJson() => _describeEnum(this);
}

extension EncodingValue on Encoding {
  String toJson() => _describeEnum(this);
}

extension RewardTypeValue on RewardType {
  String toJson() => _describeEnum(this);
}

extension CirculationStatusValue on CirculationStatus {
  String toJson() => _describeEnum(this);
}

extension StakeActivationStateValue on StakeActivationState {
  String toJson() => _describeEnum(this);
}

// Copied almost verbatim from
// https://api.flutter.dev/flutter/foundation/describeEnum.html
String _describeEnum(Object enumEntry) {
  final String description = enumEntry.toString();
  final int indexOfDot = description.indexOf('.');
  assert(
    indexOfDot != -1 && indexOfDot < description.length - 1,
    'The provided object "$enumEntry" is not an enum.',
  );
  return description.substring(indexOfDot + 1);
}
