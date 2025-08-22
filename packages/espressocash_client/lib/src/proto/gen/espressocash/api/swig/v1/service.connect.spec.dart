//
//  Generated code. Do not modify.
//  source: espressocash/api/swig/v1/service.proto
//

import "package:connectrpc/connect.dart" as connect;
import "service.pb.dart" as espressocashapiswigv1service;

/// SWIGService manages SWIG smart wallet operations
abstract final class SWIGService {
  /// Fully-qualified name of the SWIGService service.
  static const name = 'espressocash.api.swig.v1.SWIGService';

  /// Creates a SWIG wallet for a user
  static const createWallet = connect.Spec(
    '/$name/CreateWallet',
    connect.StreamType.unary,
    espressocashapiswigv1service.CreateWalletRequest.new,
    espressocashapiswigv1service.CreateWalletResponse.new,
  );

  /// Prepares an AddAuthority operation (returns unsigned transaction)
  static const prepareAddAuthority = connect.Spec(
    '/$name/PrepareAddAuthority',
    connect.StreamType.unary,
    espressocashapiswigv1service.PrepareAddAuthorityRequest.new,
    espressocashapiswigv1service.PrepareAddAuthorityResponse.new,
  );

  /// Submits an AddAuthority operation with SigningResult
  static const submitAddAuthority = connect.Spec(
    '/$name/SubmitAddAuthority',
    connect.StreamType.unary,
    espressocashapiswigv1service.SubmitAddAuthorityRequest.new,
    espressocashapiswigv1service.SubmitAddAuthorityResponse.new,
  );

  /// Gets list of authorities and roles for a SWIG wallet
  static const getWalletAuthorities = connect.Spec(
    '/$name/GetWalletAuthorities',
    connect.StreamType.unary,
    espressocashapiswigv1service.GetWalletAuthoritiesRequest.new,
    espressocashapiswigv1service.GetWalletAuthoritiesResponse.new,
  );

  /// Prepares a SWIG SignV1 transaction (wrapping any instruction)
  static const prepareSignV1 = connect.Spec(
    '/$name/PrepareSignV1',
    connect.StreamType.unary,
    espressocashapiswigv1service.PrepareSignV1Request.new,
    espressocashapiswigv1service.PrepareSignV1Response.new,
  );

  /// Submits a SignV1 transaction with authority signature
  static const submitSignV1 = connect.Spec(
    '/$name/SubmitSignV1',
    connect.StreamType.unary,
    espressocashapiswigv1service.SubmitSignV1Request.new,
    espressocashapiswigv1service.SubmitSignV1Response.new,
  );
}
