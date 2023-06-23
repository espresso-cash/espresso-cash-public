import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';

@freezed
class Profile with _$Profile {
  const factory Profile({
    required String firstName,
    String? photoPath,
    String? country,
  }) = _Profile;
}
