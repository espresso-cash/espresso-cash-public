//
//  Generated code. Do not modify.
//  source: espressocash/api/swig/v1/service.proto
//

import "package:connectrpc/connect.dart" as connect;
import "service.pb.dart" as espressocashapiswigv1service;
import "service.connect.spec.dart" as specs;

/// SWIGService manages SWIG smart wallet operations
extension type SWIGServiceClient (connect.Transport _transport) {
  /// Creates a SWIG wallet for a user
  Future<espressocashapiswigv1service.CreateWalletResponse> createWallet(
    espressocashapiswigv1service.CreateWalletRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.SWIGService.createWallet,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  /// Creates a SWIG wallet with platform fee payment
  Future<espressocashapiswigv1service.SubmitCreateWalletResponse> submitCreateWallet(
    espressocashapiswigv1service.SubmitCreateWalletRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.SWIGService.submitCreateWallet,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  /// Prepares an AddAuthority operation (returns unsigned transaction)
  Future<espressocashapiswigv1service.PrepareAddAuthorityResponse> prepareAddAuthority(
    espressocashapiswigv1service.PrepareAddAuthorityRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.SWIGService.prepareAddAuthority,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  /// Submits an AddAuthority operation with SigningResult
  Future<espressocashapiswigv1service.SubmitAddAuthorityResponse> submitAddAuthority(
    espressocashapiswigv1service.SubmitAddAuthorityRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.SWIGService.submitAddAuthority,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  /// Creates an Associated Token Account (ATA) with platform fee payment
  Future<espressocashapiswigv1service.SubmitCreateATAResponse> submitCreateATA(
    espressocashapiswigv1service.SubmitCreateATARequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.SWIGService.submitCreateATA,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  /// Gets list of authorities and roles for a SWIG wallet
  Future<espressocashapiswigv1service.GetWalletAuthoritiesResponse> getWalletAuthorities(
    espressocashapiswigv1service.GetWalletAuthoritiesRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.SWIGService.getWalletAuthorities,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  /// Prepares a SWIG SignV1 transaction (wrapping any instruction)
  Future<espressocashapiswigv1service.PrepareSignV1Response> prepareSignV1(
    espressocashapiswigv1service.PrepareSignV1Request input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.SWIGService.prepareSignV1,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  /// Submits a SignV1 transaction with authority signature
  Future<espressocashapiswigv1service.SubmitSignV1Response> submitSignV1(
    espressocashapiswigv1service.SubmitSignV1Request input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.SWIGService.submitSignV1,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
