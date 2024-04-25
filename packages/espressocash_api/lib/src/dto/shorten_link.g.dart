// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shorten_link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShortenLinkRequestDtoImpl _$$ShortenLinkRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$ShortenLinkRequestDtoImpl(
      fullLink: json['fullLink'] as String,
    );

Map<String, dynamic> _$$ShortenLinkRequestDtoImplToJson(
        _$ShortenLinkRequestDtoImpl instance) =>
    <String, dynamic>{
      'fullLink': instance.fullLink,
    };

_$ShortenLinkResponseDtoImpl _$$ShortenLinkResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$ShortenLinkResponseDtoImpl(
      shortLink: json['shortLink'] as String,
    );

Map<String, dynamic> _$$ShortenLinkResponseDtoImplToJson(
        _$ShortenLinkResponseDtoImpl instance) =>
    <String, dynamic>{
      'shortLink': instance.shortLink,
    };

_$UnshortenLinkRequestDtoImpl _$$UnshortenLinkRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$UnshortenLinkRequestDtoImpl(
      shortLink: json['shortLink'] as String,
    );

Map<String, dynamic> _$$UnshortenLinkRequestDtoImplToJson(
        _$UnshortenLinkRequestDtoImpl instance) =>
    <String, dynamic>{
      'shortLink': instance.shortLink,
    };

_$UnshortenLinkResponseDtoImpl _$$UnshortenLinkResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$UnshortenLinkResponseDtoImpl(
      fullLink: json['fullLink'] as String,
    );

Map<String, dynamic> _$$UnshortenLinkResponseDtoImplToJson(
        _$UnshortenLinkResponseDtoImpl instance) =>
    <String, dynamic>{
      'fullLink': instance.fullLink,
    };
