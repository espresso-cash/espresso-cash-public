// // ignore_for_file: invalid_annotation_target
// import 'package:dio/dio.dart';
// import 'package:espressocash_backend/src/constants.dart';
// import 'package:espressocash_backend/src/scalex/interceptor.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:retrofit/http.dart';
// import 'package:retrofit/retrofit.dart';

// part 'client.freezed.dart';
// part 'client.g.dart';

// @RestApi(baseUrl: scalexBaseUrl)
// abstract class ScalexApiClient {
//   factory ScalexApiClient(Dio dio) =>
//       _ScalexApiClient(dio..interceptors.add(ScalexInterceptor()));

//   @POST('/webpay/tx/initiate')
//   Future<ScalexResponseDto<GenerateIFrameDto>> generateIFrameUrl(
//     @Body() GenerateIFrameBodyDto body,
//   );

//   @GET('/business/tx/{reference_id}')
//   Future<ScalexResponseDto<TransactionDto>> getTransaction(
//     @Path('reference_id') String referenceId,
//   );
// }

// @freezed
// class GenerateIFrameBodyDto with _$GenerateIFrameBodyDto {
//   const factory GenerateIFrameBodyDto({
//     required String type,
//     required String address,
//     required String email,
//     required String token,
//     required String network,
//   }) = _GenerateIFrameBodyDto;

//   factory GenerateIFrameBodyDto.fromJson(Map<String, dynamic> json) =>
//       _$GenerateIFrameBodyDtoFromJson(json);
// }

// @Freezed(genericArgumentFactories: true, toJson: false)
// class ScalexResponseDto<T> with _$ScalexResponseDto<T> {
//   const factory ScalexResponseDto({
//     required T data,
//   }) = _ScalexResponseDto<T>;

//   factory ScalexResponseDto.fromJson(
//     Map<String, dynamic> json,
//     T Function(Object? obj) fromJsonT,
//   ) =>
//       _$ScalexResponseDtoFromJson(json, fromJsonT);
// }

// @freezed
// class GenerateIFrameDto with _$GenerateIFrameDto {
//   const factory GenerateIFrameDto({
//     required String link,
//     required String environment,
//   }) = _GenerateIFrameResponseDto;

//   factory GenerateIFrameDto.fromJson(Map<String, dynamic> json) =>
//       _$GenerateIFrameDtoFromJson(json);
// }

// @Freezed(toJson: false)
// class TransactionDto with _$TransactionDto {
//   @JsonSerializable(fieldRename: FieldRename.snake)
//   const factory TransactionDto({
//     @JsonKey(unknownEnumValue: OrderStatus.unknown) required OrderStatus status,
//     required String type,
//   }) = _TransactionDto;

//   factory TransactionDto.fromJson(Map<String, dynamic> json) =>
//       _$TransactionDtoFromJson(json);
// }

// @JsonEnum()
// enum OrderStatus {
//   pending,
//   completed,
//   unknown,
// }
