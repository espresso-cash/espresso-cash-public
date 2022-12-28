import 'package:freezed_annotation/freezed_annotation.dart';

part 'change.freezed.dart';

@freezed
class ChangeNotified with _$ChangeNotified {
  const factory ChangeNotified({
    required List<Uri> uris,
    required int flags,
  }) = _ChangeNotified;
}
