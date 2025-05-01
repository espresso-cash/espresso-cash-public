//
//  Generated code. Do not modify.
//  source: api/moneygram/v1/service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'service.pbenum.dart';

export 'service.pbenum.dart';

class MoneygramChallengeSignRequest extends $pb.GeneratedMessage {
  factory MoneygramChallengeSignRequest({
    $core.String? signedTx,
  }) {
    final $result = create();
    if (signedTx != null) {
      $result.signedTx = signedTx;
    }
    return $result;
  }
  MoneygramChallengeSignRequest._() : super();
  factory MoneygramChallengeSignRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory MoneygramChallengeSignRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MoneygramChallengeSignRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.moneygram.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'signedTx')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  MoneygramChallengeSignRequest clone() => MoneygramChallengeSignRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  MoneygramChallengeSignRequest copyWith(void Function(MoneygramChallengeSignRequest) updates) =>
      super.copyWith((message) => updates(message as MoneygramChallengeSignRequest))
          as MoneygramChallengeSignRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MoneygramChallengeSignRequest create() => MoneygramChallengeSignRequest._();
  MoneygramChallengeSignRequest createEmptyInstance() => create();
  static $pb.PbList<MoneygramChallengeSignRequest> createRepeated() =>
      $pb.PbList<MoneygramChallengeSignRequest>();
  @$core.pragma('dart2js:noInline')
  static MoneygramChallengeSignRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MoneygramChallengeSignRequest>(create);
  static MoneygramChallengeSignRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get signedTx => $_getSZ(0);
  @$pb.TagNumber(1)
  set signedTx($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSignedTx() => $_has(0);
  @$pb.TagNumber(1)
  void clearSignedTx() => clearField(1);
}

class MoneygramChallengeSignResponse extends $pb.GeneratedMessage {
  factory MoneygramChallengeSignResponse({
    $core.String? signedTx,
  }) {
    final $result = create();
    if (signedTx != null) {
      $result.signedTx = signedTx;
    }
    return $result;
  }
  MoneygramChallengeSignResponse._() : super();
  factory MoneygramChallengeSignResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory MoneygramChallengeSignResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MoneygramChallengeSignResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.moneygram.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'signedTx')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  MoneygramChallengeSignResponse clone() =>
      MoneygramChallengeSignResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  MoneygramChallengeSignResponse copyWith(void Function(MoneygramChallengeSignResponse) updates) =>
      super.copyWith((message) => updates(message as MoneygramChallengeSignResponse))
          as MoneygramChallengeSignResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MoneygramChallengeSignResponse create() => MoneygramChallengeSignResponse._();
  MoneygramChallengeSignResponse createEmptyInstance() => create();
  static $pb.PbList<MoneygramChallengeSignResponse> createRepeated() =>
      $pb.PbList<MoneygramChallengeSignResponse>();
  @$core.pragma('dart2js:noInline')
  static MoneygramChallengeSignResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MoneygramChallengeSignResponse>(create);
  static MoneygramChallengeSignResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get signedTx => $_getSZ(0);
  @$pb.TagNumber(1)
  set signedTx($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSignedTx() => $_has(0);
  @$pb.TagNumber(1)
  void clearSignedTx() => clearField(1);
}

class SwapToSolanaRequest extends $pb.GeneratedMessage {
  factory SwapToSolanaRequest({
    $core.String? stellarSenderAddress,
    $core.String? solanaReceiverAddress,
    $core.String? amount,
  }) {
    final $result = create();
    if (stellarSenderAddress != null) {
      $result.stellarSenderAddress = stellarSenderAddress;
    }
    if (solanaReceiverAddress != null) {
      $result.solanaReceiverAddress = solanaReceiverAddress;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    return $result;
  }
  SwapToSolanaRequest._() : super();
  factory SwapToSolanaRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SwapToSolanaRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SwapToSolanaRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.moneygram.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'stellarSenderAddress')
    ..aOS(2, _omitFieldNames ? '' : 'solanaReceiverAddress')
    ..aOS(3, _omitFieldNames ? '' : 'amount')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SwapToSolanaRequest clone() => SwapToSolanaRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SwapToSolanaRequest copyWith(void Function(SwapToSolanaRequest) updates) =>
      super.copyWith((message) => updates(message as SwapToSolanaRequest)) as SwapToSolanaRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SwapToSolanaRequest create() => SwapToSolanaRequest._();
  SwapToSolanaRequest createEmptyInstance() => create();
  static $pb.PbList<SwapToSolanaRequest> createRepeated() => $pb.PbList<SwapToSolanaRequest>();
  @$core.pragma('dart2js:noInline')
  static SwapToSolanaRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SwapToSolanaRequest>(create);
  static SwapToSolanaRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get stellarSenderAddress => $_getSZ(0);
  @$pb.TagNumber(1)
  set stellarSenderAddress($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasStellarSenderAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearStellarSenderAddress() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get solanaReceiverAddress => $_getSZ(1);
  @$pb.TagNumber(2)
  set solanaReceiverAddress($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSolanaReceiverAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearSolanaReceiverAddress() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get amount => $_getSZ(2);
  @$pb.TagNumber(3)
  set amount($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);
}

class SwapToStellarRequest extends $pb.GeneratedMessage {
  factory SwapToStellarRequest({
    $core.String? solanaSenderAddress,
    $core.String? stellarReceiverAddress,
    $core.String? amount,
    $core.int? priorityFee,
  }) {
    final $result = create();
    if (solanaSenderAddress != null) {
      $result.solanaSenderAddress = solanaSenderAddress;
    }
    if (stellarReceiverAddress != null) {
      $result.stellarReceiverAddress = stellarReceiverAddress;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (priorityFee != null) {
      $result.priorityFee = priorityFee;
    }
    return $result;
  }
  SwapToStellarRequest._() : super();
  factory SwapToStellarRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SwapToStellarRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SwapToStellarRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.moneygram.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'solanaSenderAddress')
    ..aOS(2, _omitFieldNames ? '' : 'stellarReceiverAddress')
    ..aOS(3, _omitFieldNames ? '' : 'amount')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'priorityFee', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SwapToStellarRequest clone() => SwapToStellarRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SwapToStellarRequest copyWith(void Function(SwapToStellarRequest) updates) =>
      super.copyWith((message) => updates(message as SwapToStellarRequest)) as SwapToStellarRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SwapToStellarRequest create() => SwapToStellarRequest._();
  SwapToStellarRequest createEmptyInstance() => create();
  static $pb.PbList<SwapToStellarRequest> createRepeated() => $pb.PbList<SwapToStellarRequest>();
  @$core.pragma('dart2js:noInline')
  static SwapToStellarRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SwapToStellarRequest>(create);
  static SwapToStellarRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get solanaSenderAddress => $_getSZ(0);
  @$pb.TagNumber(1)
  set solanaSenderAddress($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSolanaSenderAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearSolanaSenderAddress() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get stellarReceiverAddress => $_getSZ(1);
  @$pb.TagNumber(2)
  set stellarReceiverAddress($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasStellarReceiverAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearStellarReceiverAddress() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get amount => $_getSZ(2);
  @$pb.TagNumber(3)
  set amount($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get priorityFee => $_getIZ(3);
  @$pb.TagNumber(4)
  set priorityFee($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasPriorityFee() => $_has(3);
  @$pb.TagNumber(4)
  void clearPriorityFee() => clearField(4);
}

class MoneygramSwapResponse extends $pb.GeneratedMessage {
  factory MoneygramSwapResponse({
    $core.String? encodedTx,
  }) {
    final $result = create();
    if (encodedTx != null) {
      $result.encodedTx = encodedTx;
    }
    return $result;
  }
  MoneygramSwapResponse._() : super();
  factory MoneygramSwapResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory MoneygramSwapResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MoneygramSwapResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.moneygram.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'encodedTx')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  MoneygramSwapResponse clone() => MoneygramSwapResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  MoneygramSwapResponse copyWith(void Function(MoneygramSwapResponse) updates) =>
      super.copyWith((message) => updates(message as MoneygramSwapResponse))
          as MoneygramSwapResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MoneygramSwapResponse create() => MoneygramSwapResponse._();
  MoneygramSwapResponse createEmptyInstance() => create();
  static $pb.PbList<MoneygramSwapResponse> createRepeated() => $pb.PbList<MoneygramSwapResponse>();
  @$core.pragma('dart2js:noInline')
  static MoneygramSwapResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MoneygramSwapResponse>(create);
  static MoneygramSwapResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get encodedTx => $_getSZ(0);
  @$pb.TagNumber(1)
  set encodedTx($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasEncodedTx() => $_has(0);
  @$pb.TagNumber(1)
  void clearEncodedTx() => clearField(1);
}

class MoneygramFeeRequest extends $pb.GeneratedMessage {
  factory MoneygramFeeRequest({
    $core.String? amount,
    RampType? type,
  }) {
    final $result = create();
    if (amount != null) {
      $result.amount = amount;
    }
    if (type != null) {
      $result.type = type;
    }
    return $result;
  }
  MoneygramFeeRequest._() : super();
  factory MoneygramFeeRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory MoneygramFeeRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MoneygramFeeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.moneygram.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'amount')
    ..e<RampType>(2, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE,
        defaultOrMaker: RampType.RAMP_TYPE_UNSPECIFIED,
        valueOf: RampType.valueOf,
        enumValues: RampType.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  MoneygramFeeRequest clone() => MoneygramFeeRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  MoneygramFeeRequest copyWith(void Function(MoneygramFeeRequest) updates) =>
      super.copyWith((message) => updates(message as MoneygramFeeRequest)) as MoneygramFeeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MoneygramFeeRequest create() => MoneygramFeeRequest._();
  MoneygramFeeRequest createEmptyInstance() => create();
  static $pb.PbList<MoneygramFeeRequest> createRepeated() => $pb.PbList<MoneygramFeeRequest>();
  @$core.pragma('dart2js:noInline')
  static MoneygramFeeRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MoneygramFeeRequest>(create);
  static MoneygramFeeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get amount => $_getSZ(0);
  @$pb.TagNumber(1)
  set amount($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmount() => clearField(1);

  @$pb.TagNumber(2)
  RampType get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(RampType v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);
}

class MoneygramFeeResponse extends $pb.GeneratedMessage {
  factory MoneygramFeeResponse({
    $core.String? bridgeFee,
    $core.String? moneygramFee,
    $core.String? gasFeeInUsdc,
    $core.int? priorityFee,
  }) {
    final $result = create();
    if (bridgeFee != null) {
      $result.bridgeFee = bridgeFee;
    }
    if (moneygramFee != null) {
      $result.moneygramFee = moneygramFee;
    }
    if (gasFeeInUsdc != null) {
      $result.gasFeeInUsdc = gasFeeInUsdc;
    }
    if (priorityFee != null) {
      $result.priorityFee = priorityFee;
    }
    return $result;
  }
  MoneygramFeeResponse._() : super();
  factory MoneygramFeeResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory MoneygramFeeResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MoneygramFeeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.moneygram.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'bridgeFee')
    ..aOS(2, _omitFieldNames ? '' : 'moneygramFee')
    ..aOS(3, _omitFieldNames ? '' : 'gasFeeInUsdc')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'priorityFee', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  MoneygramFeeResponse clone() => MoneygramFeeResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  MoneygramFeeResponse copyWith(void Function(MoneygramFeeResponse) updates) =>
      super.copyWith((message) => updates(message as MoneygramFeeResponse)) as MoneygramFeeResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MoneygramFeeResponse create() => MoneygramFeeResponse._();
  MoneygramFeeResponse createEmptyInstance() => create();
  static $pb.PbList<MoneygramFeeResponse> createRepeated() => $pb.PbList<MoneygramFeeResponse>();
  @$core.pragma('dart2js:noInline')
  static MoneygramFeeResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MoneygramFeeResponse>(create);
  static MoneygramFeeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get bridgeFee => $_getSZ(0);
  @$pb.TagNumber(1)
  set bridgeFee($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasBridgeFee() => $_has(0);
  @$pb.TagNumber(1)
  void clearBridgeFee() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get moneygramFee => $_getSZ(1);
  @$pb.TagNumber(2)
  set moneygramFee($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasMoneygramFee() => $_has(1);
  @$pb.TagNumber(2)
  void clearMoneygramFee() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get gasFeeInUsdc => $_getSZ(2);
  @$pb.TagNumber(3)
  set gasFeeInUsdc($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasGasFeeInUsdc() => $_has(2);
  @$pb.TagNumber(3)
  void clearGasFeeInUsdc() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get priorityFee => $_getIZ(3);
  @$pb.TagNumber(4)
  set priorityFee($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasPriorityFee() => $_has(3);
  @$pb.TagNumber(4)
  void clearPriorityFee() => clearField(4);
}

class FundXlmRequest extends $pb.GeneratedMessage {
  factory FundXlmRequest({
    $core.String? accountId,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    return $result;
  }
  FundXlmRequest._() : super();
  factory FundXlmRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FundXlmRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FundXlmRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.moneygram.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FundXlmRequest clone() => FundXlmRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FundXlmRequest copyWith(void Function(FundXlmRequest) updates) =>
      super.copyWith((message) => updates(message as FundXlmRequest)) as FundXlmRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FundXlmRequest create() => FundXlmRequest._();
  FundXlmRequest createEmptyInstance() => create();
  static $pb.PbList<FundXlmRequest> createRepeated() => $pb.PbList<FundXlmRequest>();
  @$core.pragma('dart2js:noInline')
  static FundXlmRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FundXlmRequest>(create);
  static FundXlmRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);
}

class FundXlmResponse extends $pb.GeneratedMessage {
  factory FundXlmResponse() => create();
  FundXlmResponse._() : super();
  factory FundXlmResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FundXlmResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FundXlmResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.moneygram.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FundXlmResponse clone() => FundXlmResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FundXlmResponse copyWith(void Function(FundXlmResponse) updates) =>
      super.copyWith((message) => updates(message as FundXlmResponse)) as FundXlmResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FundXlmResponse create() => FundXlmResponse._();
  FundXlmResponse createEmptyInstance() => create();
  static $pb.PbList<FundXlmResponse> createRepeated() => $pb.PbList<FundXlmResponse>();
  @$core.pragma('dart2js:noInline')
  static FundXlmResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FundXlmResponse>(create);
  static FundXlmResponse? _defaultInstance;
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
