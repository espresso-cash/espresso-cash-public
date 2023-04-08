import 'package:freezed_annotation/freezed_annotation.dart';

part 'deauthorize.freezed.dart';

@freezed
class DeauthorizeEvent with _$DeauthorizeEvent {
  const factory DeauthorizeEvent({
    required String? identityName,
    required Uri? identityUri,
    required Uri? iconUri,
  }) = _DeauthorizeEvent;
}
