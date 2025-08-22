//
//  Generated code. Do not modify.
//  source: espressocash/api/users/v1/service.proto
//

import "package:connectrpc/connect.dart" as connect;
import "service.pb.dart" as espressocashapiusersv1service;

abstract final class UserService {
  /// Fully-qualified name of the UserService service.
  static const name = 'espressocash.api.users.v1.UserService';

  static const login = connect.Spec(
    '/$name/Login',
    connect.StreamType.unary,
    espressocashapiusersv1service.LoginRequest.new,
    espressocashapiusersv1service.LoginResponse.new,
  );

  static const getWalletProofMessage = connect.Spec(
    '/$name/GetWalletProofMessage',
    connect.StreamType.unary,
    espressocashapiusersv1service.GetWalletProofMessageRequest.new,
    espressocashapiusersv1service.GetWalletProofMessageResponse.new,
  );

  static const updateCountry = connect.Spec(
    '/$name/UpdateCountry',
    connect.StreamType.unary,
    espressocashapiusersv1service.UpdateCountryRequest.new,
    espressocashapiusersv1service.UpdateCountryResponse.new,
  );
}
