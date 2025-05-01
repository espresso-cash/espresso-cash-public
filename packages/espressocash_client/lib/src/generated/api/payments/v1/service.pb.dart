//
//  Generated code. Do not modify.
//  source: api/payments/v1/service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class CreateDirectPaymentRequest extends $pb.GeneratedMessage {
  factory CreateDirectPaymentRequest({
    $core.String? senderAccount,
    $core.String? receiverAccount,
    $core.String? referenceAccount,
    $fixnum.Int64? amount,
  }) {
    final $result = create();
    if (senderAccount != null) {
      $result.senderAccount = senderAccount;
    }
    if (receiverAccount != null) {
      $result.receiverAccount = receiverAccount;
    }
    if (referenceAccount != null) {
      $result.referenceAccount = referenceAccount;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    return $result;
  }
  CreateDirectPaymentRequest._() : super();
  factory CreateDirectPaymentRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateDirectPaymentRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateDirectPaymentRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.payments.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'senderAccount')
    ..aOS(2, _omitFieldNames ? '' : 'receiverAccount')
    ..aOS(3, _omitFieldNames ? '' : 'referenceAccount')
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateDirectPaymentRequest clone() =>
      CreateDirectPaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateDirectPaymentRequest copyWith(
          void Function(CreateDirectPaymentRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateDirectPaymentRequest))
          as CreateDirectPaymentRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateDirectPaymentRequest create() => CreateDirectPaymentRequest._();
  CreateDirectPaymentRequest createEmptyInstance() => create();
  static $pb.PbList<CreateDirectPaymentRequest> createRepeated() =>
      $pb.PbList<CreateDirectPaymentRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateDirectPaymentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateDirectPaymentRequest>(create);
  static CreateDirectPaymentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get senderAccount => $_getSZ(0);
  @$pb.TagNumber(1)
  set senderAccount($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSenderAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearSenderAccount() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get receiverAccount => $_getSZ(1);
  @$pb.TagNumber(2)
  set receiverAccount($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasReceiverAccount() => $_has(1);
  @$pb.TagNumber(2)
  void clearReceiverAccount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get referenceAccount => $_getSZ(2);
  @$pb.TagNumber(3)
  set referenceAccount($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasReferenceAccount() => $_has(2);
  @$pb.TagNumber(3)
  void clearReferenceAccount() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get amount => $_getI64(3);
  @$pb.TagNumber(4)
  set amount($fixnum.Int64 v) {
    $_setInt64(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);
}

class CreateDirectPaymentResponse extends $pb.GeneratedMessage {
  factory CreateDirectPaymentResponse({
    $fixnum.Int64? fee,
    $core.String? transaction,
    $fixnum.Int64? slot,
  }) {
    final $result = create();
    if (fee != null) {
      $result.fee = fee;
    }
    if (transaction != null) {
      $result.transaction = transaction;
    }
    if (slot != null) {
      $result.slot = slot;
    }
    return $result;
  }
  CreateDirectPaymentResponse._() : super();
  factory CreateDirectPaymentResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateDirectPaymentResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateDirectPaymentResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.payments.v1'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'fee', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'transaction')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'slot', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateDirectPaymentResponse clone() =>
      CreateDirectPaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateDirectPaymentResponse copyWith(
          void Function(CreateDirectPaymentResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CreateDirectPaymentResponse))
          as CreateDirectPaymentResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateDirectPaymentResponse create() =>
      CreateDirectPaymentResponse._();
  CreateDirectPaymentResponse createEmptyInstance() => create();
  static $pb.PbList<CreateDirectPaymentResponse> createRepeated() =>
      $pb.PbList<CreateDirectPaymentResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateDirectPaymentResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateDirectPaymentResponse>(create);
  static CreateDirectPaymentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get fee => $_getI64(0);
  @$pb.TagNumber(1)
  set fee($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasFee() => $_has(0);
  @$pb.TagNumber(1)
  void clearFee() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get transaction => $_getSZ(1);
  @$pb.TagNumber(2)
  set transaction($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasTransaction() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransaction() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get slot => $_getI64(2);
  @$pb.TagNumber(3)
  set slot($fixnum.Int64 v) {
    $_setInt64(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasSlot() => $_has(2);
  @$pb.TagNumber(3)
  void clearSlot() => clearField(3);
}

class GetDirectPaymentQuoteRequest extends $pb.GeneratedMessage {
  factory GetDirectPaymentQuoteRequest({
    $core.String? receiverAccount,
    $fixnum.Int64? amount,
  }) {
    final $result = create();
    if (receiverAccount != null) {
      $result.receiverAccount = receiverAccount;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    return $result;
  }
  GetDirectPaymentQuoteRequest._() : super();
  factory GetDirectPaymentQuoteRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetDirectPaymentQuoteRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDirectPaymentQuoteRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.payments.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'receiverAccount')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetDirectPaymentQuoteRequest clone() =>
      GetDirectPaymentQuoteRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetDirectPaymentQuoteRequest copyWith(
          void Function(GetDirectPaymentQuoteRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetDirectPaymentQuoteRequest))
          as GetDirectPaymentQuoteRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDirectPaymentQuoteRequest create() =>
      GetDirectPaymentQuoteRequest._();
  GetDirectPaymentQuoteRequest createEmptyInstance() => create();
  static $pb.PbList<GetDirectPaymentQuoteRequest> createRepeated() =>
      $pb.PbList<GetDirectPaymentQuoteRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDirectPaymentQuoteRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDirectPaymentQuoteRequest>(create);
  static GetDirectPaymentQuoteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get receiverAccount => $_getSZ(0);
  @$pb.TagNumber(1)
  set receiverAccount($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasReceiverAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearReceiverAccount() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amount => $_getI64(1);
  @$pb.TagNumber(2)
  set amount($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);
}

class GetDirectPaymentQuoteResponse extends $pb.GeneratedMessage {
  factory GetDirectPaymentQuoteResponse({
    $fixnum.Int64? fee,
    $fixnum.Int64? totalAmount,
  }) {
    final $result = create();
    if (fee != null) {
      $result.fee = fee;
    }
    if (totalAmount != null) {
      $result.totalAmount = totalAmount;
    }
    return $result;
  }
  GetDirectPaymentQuoteResponse._() : super();
  factory GetDirectPaymentQuoteResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetDirectPaymentQuoteResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDirectPaymentQuoteResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.payments.v1'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'fee', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'totalAmount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetDirectPaymentQuoteResponse clone() =>
      GetDirectPaymentQuoteResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetDirectPaymentQuoteResponse copyWith(
          void Function(GetDirectPaymentQuoteResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetDirectPaymentQuoteResponse))
          as GetDirectPaymentQuoteResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDirectPaymentQuoteResponse create() =>
      GetDirectPaymentQuoteResponse._();
  GetDirectPaymentQuoteResponse createEmptyInstance() => create();
  static $pb.PbList<GetDirectPaymentQuoteResponse> createRepeated() =>
      $pb.PbList<GetDirectPaymentQuoteResponse>();
  @$core.pragma('dart2js:noInline')
  static GetDirectPaymentQuoteResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDirectPaymentQuoteResponse>(create);
  static GetDirectPaymentQuoteResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get fee => $_getI64(0);
  @$pb.TagNumber(1)
  set fee($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasFee() => $_has(0);
  @$pb.TagNumber(1)
  void clearFee() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get totalAmount => $_getI64(1);
  @$pb.TagNumber(2)
  set totalAmount($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasTotalAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalAmount() => clearField(2);
}

class CreateEscrowPaymentRequest extends $pb.GeneratedMessage {
  factory CreateEscrowPaymentRequest({
    $core.String? senderAccount,
    $core.String? escrowAccount,
    $fixnum.Int64? amount,
  }) {
    final $result = create();
    if (senderAccount != null) {
      $result.senderAccount = senderAccount;
    }
    if (escrowAccount != null) {
      $result.escrowAccount = escrowAccount;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    return $result;
  }
  CreateEscrowPaymentRequest._() : super();
  factory CreateEscrowPaymentRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateEscrowPaymentRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateEscrowPaymentRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.payments.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'senderAccount')
    ..aOS(2, _omitFieldNames ? '' : 'escrowAccount')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateEscrowPaymentRequest clone() =>
      CreateEscrowPaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateEscrowPaymentRequest copyWith(
          void Function(CreateEscrowPaymentRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateEscrowPaymentRequest))
          as CreateEscrowPaymentRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateEscrowPaymentRequest create() => CreateEscrowPaymentRequest._();
  CreateEscrowPaymentRequest createEmptyInstance() => create();
  static $pb.PbList<CreateEscrowPaymentRequest> createRepeated() =>
      $pb.PbList<CreateEscrowPaymentRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateEscrowPaymentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateEscrowPaymentRequest>(create);
  static CreateEscrowPaymentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get senderAccount => $_getSZ(0);
  @$pb.TagNumber(1)
  set senderAccount($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSenderAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearSenderAccount() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get escrowAccount => $_getSZ(1);
  @$pb.TagNumber(2)
  set escrowAccount($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasEscrowAccount() => $_has(1);
  @$pb.TagNumber(2)
  void clearEscrowAccount() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get amount => $_getI64(2);
  @$pb.TagNumber(3)
  set amount($fixnum.Int64 v) {
    $_setInt64(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);
}

class CreateEscrowPaymentResponse extends $pb.GeneratedMessage {
  factory CreateEscrowPaymentResponse({
    $core.String? transaction,
    $fixnum.Int64? slot,
  }) {
    final $result = create();
    if (transaction != null) {
      $result.transaction = transaction;
    }
    if (slot != null) {
      $result.slot = slot;
    }
    return $result;
  }
  CreateEscrowPaymentResponse._() : super();
  factory CreateEscrowPaymentResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateEscrowPaymentResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateEscrowPaymentResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.payments.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transaction')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'slot', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateEscrowPaymentResponse clone() =>
      CreateEscrowPaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateEscrowPaymentResponse copyWith(
          void Function(CreateEscrowPaymentResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CreateEscrowPaymentResponse))
          as CreateEscrowPaymentResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateEscrowPaymentResponse create() =>
      CreateEscrowPaymentResponse._();
  CreateEscrowPaymentResponse createEmptyInstance() => create();
  static $pb.PbList<CreateEscrowPaymentResponse> createRepeated() =>
      $pb.PbList<CreateEscrowPaymentResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateEscrowPaymentResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateEscrowPaymentResponse>(create);
  static CreateEscrowPaymentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transaction => $_getSZ(0);
  @$pb.TagNumber(1)
  set transaction($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get slot => $_getI64(1);
  @$pb.TagNumber(2)
  set slot($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSlot() => $_has(1);
  @$pb.TagNumber(2)
  void clearSlot() => clearField(2);
}

class ReceiveEscrowPaymentRequest extends $pb.GeneratedMessage {
  factory ReceiveEscrowPaymentRequest({
    $core.String? receiverAccount,
    $core.String? escrowAccount,
  }) {
    final $result = create();
    if (receiverAccount != null) {
      $result.receiverAccount = receiverAccount;
    }
    if (escrowAccount != null) {
      $result.escrowAccount = escrowAccount;
    }
    return $result;
  }
  ReceiveEscrowPaymentRequest._() : super();
  factory ReceiveEscrowPaymentRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ReceiveEscrowPaymentRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReceiveEscrowPaymentRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.payments.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'receiverAccount')
    ..aOS(2, _omitFieldNames ? '' : 'escrowAccount')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ReceiveEscrowPaymentRequest clone() =>
      ReceiveEscrowPaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ReceiveEscrowPaymentRequest copyWith(
          void Function(ReceiveEscrowPaymentRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ReceiveEscrowPaymentRequest))
          as ReceiveEscrowPaymentRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReceiveEscrowPaymentRequest create() =>
      ReceiveEscrowPaymentRequest._();
  ReceiveEscrowPaymentRequest createEmptyInstance() => create();
  static $pb.PbList<ReceiveEscrowPaymentRequest> createRepeated() =>
      $pb.PbList<ReceiveEscrowPaymentRequest>();
  @$core.pragma('dart2js:noInline')
  static ReceiveEscrowPaymentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReceiveEscrowPaymentRequest>(create);
  static ReceiveEscrowPaymentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get receiverAccount => $_getSZ(0);
  @$pb.TagNumber(1)
  set receiverAccount($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasReceiverAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearReceiverAccount() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get escrowAccount => $_getSZ(1);
  @$pb.TagNumber(2)
  set escrowAccount($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasEscrowAccount() => $_has(1);
  @$pb.TagNumber(2)
  void clearEscrowAccount() => clearField(2);
}

class ReceiveEscrowPaymentResponse extends $pb.GeneratedMessage {
  factory ReceiveEscrowPaymentResponse({
    $core.String? transaction,
    $fixnum.Int64? slot,
  }) {
    final $result = create();
    if (transaction != null) {
      $result.transaction = transaction;
    }
    if (slot != null) {
      $result.slot = slot;
    }
    return $result;
  }
  ReceiveEscrowPaymentResponse._() : super();
  factory ReceiveEscrowPaymentResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ReceiveEscrowPaymentResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReceiveEscrowPaymentResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.payments.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transaction')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'slot', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ReceiveEscrowPaymentResponse clone() =>
      ReceiveEscrowPaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ReceiveEscrowPaymentResponse copyWith(
          void Function(ReceiveEscrowPaymentResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ReceiveEscrowPaymentResponse))
          as ReceiveEscrowPaymentResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReceiveEscrowPaymentResponse create() =>
      ReceiveEscrowPaymentResponse._();
  ReceiveEscrowPaymentResponse createEmptyInstance() => create();
  static $pb.PbList<ReceiveEscrowPaymentResponse> createRepeated() =>
      $pb.PbList<ReceiveEscrowPaymentResponse>();
  @$core.pragma('dart2js:noInline')
  static ReceiveEscrowPaymentResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReceiveEscrowPaymentResponse>(create);
  static ReceiveEscrowPaymentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transaction => $_getSZ(0);
  @$pb.TagNumber(1)
  set transaction($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get slot => $_getI64(1);
  @$pb.TagNumber(2)
  set slot($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSlot() => $_has(1);
  @$pb.TagNumber(2)
  void clearSlot() => clearField(2);
}

class CancelEscrowPaymentRequest extends $pb.GeneratedMessage {
  factory CancelEscrowPaymentRequest({
    $core.String? senderAccount,
    $core.String? escrowAccount,
  }) {
    final $result = create();
    if (senderAccount != null) {
      $result.senderAccount = senderAccount;
    }
    if (escrowAccount != null) {
      $result.escrowAccount = escrowAccount;
    }
    return $result;
  }
  CancelEscrowPaymentRequest._() : super();
  factory CancelEscrowPaymentRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CancelEscrowPaymentRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelEscrowPaymentRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.payments.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'senderAccount')
    ..aOS(2, _omitFieldNames ? '' : 'escrowAccount')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CancelEscrowPaymentRequest clone() =>
      CancelEscrowPaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CancelEscrowPaymentRequest copyWith(
          void Function(CancelEscrowPaymentRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CancelEscrowPaymentRequest))
          as CancelEscrowPaymentRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelEscrowPaymentRequest create() => CancelEscrowPaymentRequest._();
  CancelEscrowPaymentRequest createEmptyInstance() => create();
  static $pb.PbList<CancelEscrowPaymentRequest> createRepeated() =>
      $pb.PbList<CancelEscrowPaymentRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelEscrowPaymentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelEscrowPaymentRequest>(create);
  static CancelEscrowPaymentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get senderAccount => $_getSZ(0);
  @$pb.TagNumber(1)
  set senderAccount($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSenderAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearSenderAccount() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get escrowAccount => $_getSZ(1);
  @$pb.TagNumber(2)
  set escrowAccount($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasEscrowAccount() => $_has(1);
  @$pb.TagNumber(2)
  void clearEscrowAccount() => clearField(2);
}

class CancelEscrowPaymentResponse extends $pb.GeneratedMessage {
  factory CancelEscrowPaymentResponse({
    $core.String? transaction,
    $fixnum.Int64? slot,
  }) {
    final $result = create();
    if (transaction != null) {
      $result.transaction = transaction;
    }
    if (slot != null) {
      $result.slot = slot;
    }
    return $result;
  }
  CancelEscrowPaymentResponse._() : super();
  factory CancelEscrowPaymentResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CancelEscrowPaymentResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelEscrowPaymentResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.payments.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transaction')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'slot', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CancelEscrowPaymentResponse clone() =>
      CancelEscrowPaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CancelEscrowPaymentResponse copyWith(
          void Function(CancelEscrowPaymentResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CancelEscrowPaymentResponse))
          as CancelEscrowPaymentResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelEscrowPaymentResponse create() =>
      CancelEscrowPaymentResponse._();
  CancelEscrowPaymentResponse createEmptyInstance() => create();
  static $pb.PbList<CancelEscrowPaymentResponse> createRepeated() =>
      $pb.PbList<CancelEscrowPaymentResponse>();
  @$core.pragma('dart2js:noInline')
  static CancelEscrowPaymentResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelEscrowPaymentResponse>(create);
  static CancelEscrowPaymentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transaction => $_getSZ(0);
  @$pb.TagNumber(1)
  set transaction($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get slot => $_getI64(1);
  @$pb.TagNumber(2)
  set slot($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSlot() => $_has(1);
  @$pb.TagNumber(2)
  void clearSlot() => clearField(2);
}

class GetIncomingEscrowPaymentQuoteRequest extends $pb.GeneratedMessage {
  factory GetIncomingEscrowPaymentQuoteRequest() => create();
  GetIncomingEscrowPaymentQuoteRequest._() : super();
  factory GetIncomingEscrowPaymentQuoteRequest.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetIncomingEscrowPaymentQuoteRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetIncomingEscrowPaymentQuoteRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.payments.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetIncomingEscrowPaymentQuoteRequest clone() =>
      GetIncomingEscrowPaymentQuoteRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetIncomingEscrowPaymentQuoteRequest copyWith(
          void Function(GetIncomingEscrowPaymentQuoteRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetIncomingEscrowPaymentQuoteRequest))
          as GetIncomingEscrowPaymentQuoteRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetIncomingEscrowPaymentQuoteRequest create() =>
      GetIncomingEscrowPaymentQuoteRequest._();
  GetIncomingEscrowPaymentQuoteRequest createEmptyInstance() => create();
  static $pb.PbList<GetIncomingEscrowPaymentQuoteRequest> createRepeated() =>
      $pb.PbList<GetIncomingEscrowPaymentQuoteRequest>();
  @$core.pragma('dart2js:noInline')
  static GetIncomingEscrowPaymentQuoteRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetIncomingEscrowPaymentQuoteRequest>(create);
  static GetIncomingEscrowPaymentQuoteRequest? _defaultInstance;
}

class GetIncomingEscrowPaymentQuoteResponse extends $pb.GeneratedMessage {
  factory GetIncomingEscrowPaymentQuoteResponse({
    $fixnum.Int64? fee,
  }) {
    final $result = create();
    if (fee != null) {
      $result.fee = fee;
    }
    return $result;
  }
  GetIncomingEscrowPaymentQuoteResponse._() : super();
  factory GetIncomingEscrowPaymentQuoteResponse.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetIncomingEscrowPaymentQuoteResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetIncomingEscrowPaymentQuoteResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.payments.v1'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'fee', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetIncomingEscrowPaymentQuoteResponse clone() =>
      GetIncomingEscrowPaymentQuoteResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetIncomingEscrowPaymentQuoteResponse copyWith(
          void Function(GetIncomingEscrowPaymentQuoteResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetIncomingEscrowPaymentQuoteResponse))
          as GetIncomingEscrowPaymentQuoteResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetIncomingEscrowPaymentQuoteResponse create() =>
      GetIncomingEscrowPaymentQuoteResponse._();
  GetIncomingEscrowPaymentQuoteResponse createEmptyInstance() => create();
  static $pb.PbList<GetIncomingEscrowPaymentQuoteResponse> createRepeated() =>
      $pb.PbList<GetIncomingEscrowPaymentQuoteResponse>();
  @$core.pragma('dart2js:noInline')
  static GetIncomingEscrowPaymentQuoteResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetIncomingEscrowPaymentQuoteResponse>(create);
  static GetIncomingEscrowPaymentQuoteResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get fee => $_getI64(0);
  @$pb.TagNumber(1)
  set fee($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasFee() => $_has(0);
  @$pb.TagNumber(1)
  void clearFee() => clearField(1);
}

class GetOutgoingEscrowPaymentQuoteRequest extends $pb.GeneratedMessage {
  factory GetOutgoingEscrowPaymentQuoteRequest() => create();
  GetOutgoingEscrowPaymentQuoteRequest._() : super();
  factory GetOutgoingEscrowPaymentQuoteRequest.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetOutgoingEscrowPaymentQuoteRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetOutgoingEscrowPaymentQuoteRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.payments.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetOutgoingEscrowPaymentQuoteRequest clone() =>
      GetOutgoingEscrowPaymentQuoteRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetOutgoingEscrowPaymentQuoteRequest copyWith(
          void Function(GetOutgoingEscrowPaymentQuoteRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetOutgoingEscrowPaymentQuoteRequest))
          as GetOutgoingEscrowPaymentQuoteRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOutgoingEscrowPaymentQuoteRequest create() =>
      GetOutgoingEscrowPaymentQuoteRequest._();
  GetOutgoingEscrowPaymentQuoteRequest createEmptyInstance() => create();
  static $pb.PbList<GetOutgoingEscrowPaymentQuoteRequest> createRepeated() =>
      $pb.PbList<GetOutgoingEscrowPaymentQuoteRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOutgoingEscrowPaymentQuoteRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetOutgoingEscrowPaymentQuoteRequest>(create);
  static GetOutgoingEscrowPaymentQuoteRequest? _defaultInstance;
}

class GetOutgoingEscrowPaymentQuoteResponse extends $pb.GeneratedMessage {
  factory GetOutgoingEscrowPaymentQuoteResponse({
    $fixnum.Int64? fee,
  }) {
    final $result = create();
    if (fee != null) {
      $result.fee = fee;
    }
    return $result;
  }
  GetOutgoingEscrowPaymentQuoteResponse._() : super();
  factory GetOutgoingEscrowPaymentQuoteResponse.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetOutgoingEscrowPaymentQuoteResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetOutgoingEscrowPaymentQuoteResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.payments.v1'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'fee', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetOutgoingEscrowPaymentQuoteResponse clone() =>
      GetOutgoingEscrowPaymentQuoteResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetOutgoingEscrowPaymentQuoteResponse copyWith(
          void Function(GetOutgoingEscrowPaymentQuoteResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetOutgoingEscrowPaymentQuoteResponse))
          as GetOutgoingEscrowPaymentQuoteResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOutgoingEscrowPaymentQuoteResponse create() =>
      GetOutgoingEscrowPaymentQuoteResponse._();
  GetOutgoingEscrowPaymentQuoteResponse createEmptyInstance() => create();
  static $pb.PbList<GetOutgoingEscrowPaymentQuoteResponse> createRepeated() =>
      $pb.PbList<GetOutgoingEscrowPaymentQuoteResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOutgoingEscrowPaymentQuoteResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetOutgoingEscrowPaymentQuoteResponse>(create);
  static GetOutgoingEscrowPaymentQuoteResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get fee => $_getI64(0);
  @$pb.TagNumber(1)
  set fee($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasFee() => $_has(0);
  @$pb.TagNumber(1)
  void clearFee() => clearField(1);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
