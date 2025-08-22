//
//  Generated code. Do not modify.
//  source: espressocash/api/stellar/v1/service.proto
//

import "package:connectrpc/connect.dart" as connect;
import "service.pb.dart" as espressocashapistellarv1service;

abstract final class StellarService {
  /// Fully-qualified name of the StellarService service.
  static const name = 'espressocash.api.stellar.v1.StellarService';

  static const submitTransaction = connect.Spec(
    '/$name/SubmitTransaction',
    connect.StreamType.unary,
    espressocashapistellarv1service.SubmitTransactionRequest.new,
    espressocashapistellarv1service.SubmitTransactionResponse.new,
  );

  static const getTransaction = connect.Spec(
    '/$name/GetTransaction',
    connect.StreamType.unary,
    espressocashapistellarv1service.GetTransactionRequest.new,
    espressocashapistellarv1service.GetTransactionResponse.new,
  );
}
