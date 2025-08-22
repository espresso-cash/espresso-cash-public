//
//  Generated code. Do not modify.
//  source: espressocash/api/swap/v1/service.proto
//

import "package:connectrpc/connect.dart" as connect;
import "service.pb.dart" as espressocashapiswapv1service;

abstract final class SwapService {
  /// Fully-qualified name of the SwapService service.
  static const name = 'espressocash.api.swap.v1.SwapService';

  static const swap = connect.Spec(
    '/$name/Swap',
    connect.StreamType.unary,
    espressocashapiswapv1service.SwapRouteRequest.new,
    espressocashapiswapv1service.SwapRouteResponse.new,
  );
}
