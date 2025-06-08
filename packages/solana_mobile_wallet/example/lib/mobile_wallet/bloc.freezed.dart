// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MobileWalletState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is MobileWalletState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MobileWalletState()';
  }
}

/// @nodoc
class $MobileWalletStateCopyWith<$Res> {
  $MobileWalletStateCopyWith(MobileWalletState _, $Res Function(MobileWalletState) __);
}

/// @nodoc

class MobileWalletStateNone implements MobileWalletState {
  const MobileWalletStateNone();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is MobileWalletStateNone);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MobileWalletState.none()';
  }
}

/// @nodoc

class MobileWalletStateSessionTerminated implements MobileWalletState {
  const MobileWalletStateSessionTerminated();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is MobileWalletStateSessionTerminated);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MobileWalletState.sessionTerminated()';
  }
}

/// @nodoc

class MobileWalletStateRemote implements MobileWalletState {
  const MobileWalletStateRemote(this.request);

  final RemoteRequest request;

  /// Create a copy of MobileWalletState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MobileWalletStateRemoteCopyWith<MobileWalletStateRemote> get copyWith =>
      _$MobileWalletStateRemoteCopyWithImpl<MobileWalletStateRemote>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MobileWalletStateRemote &&
            (identical(other.request, request) || other.request == request));
  }

  @override
  int get hashCode => Object.hash(runtimeType, request);

  @override
  String toString() {
    return 'MobileWalletState.remote(request: $request)';
  }
}

/// @nodoc
abstract mixin class $MobileWalletStateRemoteCopyWith<$Res>
    implements $MobileWalletStateCopyWith<$Res> {
  factory $MobileWalletStateRemoteCopyWith(
    MobileWalletStateRemote value,
    $Res Function(MobileWalletStateRemote) _then,
  ) = _$MobileWalletStateRemoteCopyWithImpl;
  @useResult
  $Res call({RemoteRequest request});

  $RemoteRequestCopyWith<$Res> get request;
}

/// @nodoc
class _$MobileWalletStateRemoteCopyWithImpl<$Res>
    implements $MobileWalletStateRemoteCopyWith<$Res> {
  _$MobileWalletStateRemoteCopyWithImpl(this._self, this._then);

  final MobileWalletStateRemote _self;
  final $Res Function(MobileWalletStateRemote) _then;

  /// Create a copy of MobileWalletState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? request = null}) {
    return _then(
      MobileWalletStateRemote(
        null == request
            ? _self.request
            : request // ignore: cast_nullable_to_non_nullable
                as RemoteRequest,
      ),
    );
  }

  /// Create a copy of MobileWalletState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RemoteRequestCopyWith<$Res> get request {
    return $RemoteRequestCopyWith<$Res>(_self.request, (value) {
      return _then(_self.copyWith(request: value));
    });
  }
}

/// @nodoc
mixin _$RemoteRequest {
  Object get request;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RemoteRequest &&
            const DeepCollectionEquality().equals(other.request, request));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(request));

  @override
  String toString() {
    return 'RemoteRequest(request: $request)';
  }
}

/// @nodoc
class $RemoteRequestCopyWith<$Res> {
  $RemoteRequestCopyWith(RemoteRequest _, $Res Function(RemoteRequest) __);
}

/// @nodoc

class RemoteRequestAuthorizeDapp implements RemoteRequest {
  const RemoteRequestAuthorizeDapp({required this.request});

  @override
  final AuthorizeRequest request;

  /// Create a copy of RemoteRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RemoteRequestAuthorizeDappCopyWith<RemoteRequestAuthorizeDapp> get copyWith =>
      _$RemoteRequestAuthorizeDappCopyWithImpl<RemoteRequestAuthorizeDapp>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RemoteRequestAuthorizeDapp &&
            (identical(other.request, request) || other.request == request));
  }

  @override
  int get hashCode => Object.hash(runtimeType, request);

  @override
  String toString() {
    return 'RemoteRequest.authorizeDapp(request: $request)';
  }
}

/// @nodoc
abstract mixin class $RemoteRequestAuthorizeDappCopyWith<$Res>
    implements $RemoteRequestCopyWith<$Res> {
  factory $RemoteRequestAuthorizeDappCopyWith(
    RemoteRequestAuthorizeDapp value,
    $Res Function(RemoteRequestAuthorizeDapp) _then,
  ) = _$RemoteRequestAuthorizeDappCopyWithImpl;
  @useResult
  $Res call({AuthorizeRequest request});

  $AuthorizeRequestCopyWith<$Res> get request;
}

/// @nodoc
class _$RemoteRequestAuthorizeDappCopyWithImpl<$Res>
    implements $RemoteRequestAuthorizeDappCopyWith<$Res> {
  _$RemoteRequestAuthorizeDappCopyWithImpl(this._self, this._then);

  final RemoteRequestAuthorizeDapp _self;
  final $Res Function(RemoteRequestAuthorizeDapp) _then;

  /// Create a copy of RemoteRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? request = null}) {
    return _then(
      RemoteRequestAuthorizeDapp(
        request:
            null == request
                ? _self.request
                : request // ignore: cast_nullable_to_non_nullable
                    as AuthorizeRequest,
      ),
    );
  }

  /// Create a copy of RemoteRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthorizeRequestCopyWith<$Res> get request {
    return $AuthorizeRequestCopyWith<$Res>(_self.request, (value) {
      return _then(_self.copyWith(request: value));
    });
  }
}

/// @nodoc

class RemoteRequestSignPayloads implements RemoteRequest {
  const RemoteRequestSignPayloads({required this.request});

  @override
  final SignPayloadsRequest request;

  /// Create a copy of RemoteRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RemoteRequestSignPayloadsCopyWith<RemoteRequestSignPayloads> get copyWith =>
      _$RemoteRequestSignPayloadsCopyWithImpl<RemoteRequestSignPayloads>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RemoteRequestSignPayloads &&
            (identical(other.request, request) || other.request == request));
  }

  @override
  int get hashCode => Object.hash(runtimeType, request);

  @override
  String toString() {
    return 'RemoteRequest.signPayloads(request: $request)';
  }
}

/// @nodoc
abstract mixin class $RemoteRequestSignPayloadsCopyWith<$Res>
    implements $RemoteRequestCopyWith<$Res> {
  factory $RemoteRequestSignPayloadsCopyWith(
    RemoteRequestSignPayloads value,
    $Res Function(RemoteRequestSignPayloads) _then,
  ) = _$RemoteRequestSignPayloadsCopyWithImpl;
  @useResult
  $Res call({SignPayloadsRequest request});

  $SignPayloadsRequestCopyWith<$Res> get request;
}

/// @nodoc
class _$RemoteRequestSignPayloadsCopyWithImpl<$Res>
    implements $RemoteRequestSignPayloadsCopyWith<$Res> {
  _$RemoteRequestSignPayloadsCopyWithImpl(this._self, this._then);

  final RemoteRequestSignPayloads _self;
  final $Res Function(RemoteRequestSignPayloads) _then;

  /// Create a copy of RemoteRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? request = null}) {
    return _then(
      RemoteRequestSignPayloads(
        request:
            null == request
                ? _self.request
                : request // ignore: cast_nullable_to_non_nullable
                    as SignPayloadsRequest,
      ),
    );
  }

  /// Create a copy of RemoteRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SignPayloadsRequestCopyWith<$Res> get request {
    return $SignPayloadsRequestCopyWith<$Res>(_self.request, (value) {
      return _then(_self.copyWith(request: value));
    });
  }
}

/// @nodoc

class RemoteRequestSignTransactionsForSending implements RemoteRequest {
  const RemoteRequestSignTransactionsForSending({required this.request});

  @override
  final SignAndSendTransactionsRequest request;

  /// Create a copy of RemoteRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RemoteRequestSignTransactionsForSendingCopyWith<RemoteRequestSignTransactionsForSending>
  get copyWith => _$RemoteRequestSignTransactionsForSendingCopyWithImpl<
    RemoteRequestSignTransactionsForSending
  >(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RemoteRequestSignTransactionsForSending &&
            (identical(other.request, request) || other.request == request));
  }

  @override
  int get hashCode => Object.hash(runtimeType, request);

  @override
  String toString() {
    return 'RemoteRequest.signTransactionsForSending(request: $request)';
  }
}

/// @nodoc
abstract mixin class $RemoteRequestSignTransactionsForSendingCopyWith<$Res>
    implements $RemoteRequestCopyWith<$Res> {
  factory $RemoteRequestSignTransactionsForSendingCopyWith(
    RemoteRequestSignTransactionsForSending value,
    $Res Function(RemoteRequestSignTransactionsForSending) _then,
  ) = _$RemoteRequestSignTransactionsForSendingCopyWithImpl;
  @useResult
  $Res call({SignAndSendTransactionsRequest request});

  $SignAndSendTransactionsRequestCopyWith<$Res> get request;
}

/// @nodoc
class _$RemoteRequestSignTransactionsForSendingCopyWithImpl<$Res>
    implements $RemoteRequestSignTransactionsForSendingCopyWith<$Res> {
  _$RemoteRequestSignTransactionsForSendingCopyWithImpl(this._self, this._then);

  final RemoteRequestSignTransactionsForSending _self;
  final $Res Function(RemoteRequestSignTransactionsForSending) _then;

  /// Create a copy of RemoteRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? request = null}) {
    return _then(
      RemoteRequestSignTransactionsForSending(
        request:
            null == request
                ? _self.request
                : request // ignore: cast_nullable_to_non_nullable
                    as SignAndSendTransactionsRequest,
      ),
    );
  }

  /// Create a copy of RemoteRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SignAndSendTransactionsRequestCopyWith<$Res> get request {
    return $SignAndSendTransactionsRequestCopyWith<$Res>(_self.request, (value) {
      return _then(_self.copyWith(request: value));
    });
  }
}

/// @nodoc

class RemoteRequestSendTransactions implements RemoteRequest {
  const RemoteRequestSendTransactions({
    required this.request,
    required final List<Uint8List> signatures,
    required final List<Uint8List> signedTransactions,
  }) : _signatures = signatures,
       _signedTransactions = signedTransactions;

  @override
  final SignAndSendTransactionsRequest request;
  final List<Uint8List> _signatures;
  List<Uint8List> get signatures {
    if (_signatures is EqualUnmodifiableListView) return _signatures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_signatures);
  }

  final List<Uint8List> _signedTransactions;
  List<Uint8List> get signedTransactions {
    if (_signedTransactions is EqualUnmodifiableListView) return _signedTransactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_signedTransactions);
  }

  /// Create a copy of RemoteRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RemoteRequestSendTransactionsCopyWith<RemoteRequestSendTransactions> get copyWith =>
      _$RemoteRequestSendTransactionsCopyWithImpl<RemoteRequestSendTransactions>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RemoteRequestSendTransactions &&
            (identical(other.request, request) || other.request == request) &&
            const DeepCollectionEquality().equals(other._signatures, _signatures) &&
            const DeepCollectionEquality().equals(other._signedTransactions, _signedTransactions));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    request,
    const DeepCollectionEquality().hash(_signatures),
    const DeepCollectionEquality().hash(_signedTransactions),
  );

  @override
  String toString() {
    return 'RemoteRequest.sendTransactions(request: $request, signatures: $signatures, signedTransactions: $signedTransactions)';
  }
}

/// @nodoc
abstract mixin class $RemoteRequestSendTransactionsCopyWith<$Res>
    implements $RemoteRequestCopyWith<$Res> {
  factory $RemoteRequestSendTransactionsCopyWith(
    RemoteRequestSendTransactions value,
    $Res Function(RemoteRequestSendTransactions) _then,
  ) = _$RemoteRequestSendTransactionsCopyWithImpl;
  @useResult
  $Res call({
    SignAndSendTransactionsRequest request,
    List<Uint8List> signatures,
    List<Uint8List> signedTransactions,
  });

  $SignAndSendTransactionsRequestCopyWith<$Res> get request;
}

/// @nodoc
class _$RemoteRequestSendTransactionsCopyWithImpl<$Res>
    implements $RemoteRequestSendTransactionsCopyWith<$Res> {
  _$RemoteRequestSendTransactionsCopyWithImpl(this._self, this._then);

  final RemoteRequestSendTransactions _self;
  final $Res Function(RemoteRequestSendTransactions) _then;

  /// Create a copy of RemoteRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? request = null,
    Object? signatures = null,
    Object? signedTransactions = null,
  }) {
    return _then(
      RemoteRequestSendTransactions(
        request:
            null == request
                ? _self.request
                : request // ignore: cast_nullable_to_non_nullable
                    as SignAndSendTransactionsRequest,
        signatures:
            null == signatures
                ? _self._signatures
                : signatures // ignore: cast_nullable_to_non_nullable
                    as List<Uint8List>,
        signedTransactions:
            null == signedTransactions
                ? _self._signedTransactions
                : signedTransactions // ignore: cast_nullable_to_non_nullable
                    as List<Uint8List>,
      ),
    );
  }

  /// Create a copy of RemoteRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SignAndSendTransactionsRequestCopyWith<$Res> get request {
    return $SignAndSendTransactionsRequestCopyWith<$Res>(_self.request, (value) {
      return _then(_self.copyWith(request: value));
    });
  }
}
