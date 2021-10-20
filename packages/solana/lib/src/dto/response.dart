import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class Response<T> {
  const Response({required this.result});

  factory Response.fromJson(
    Map<String, dynamic> data,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ResponseFromJson(data, fromJsonT);

  final T result;
}
