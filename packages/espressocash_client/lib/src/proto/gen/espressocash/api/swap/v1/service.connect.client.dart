//
//  Generated code. Do not modify.
//  source: espressocash/api/swap/v1/service.proto
//

import "package:connectrpc/connect.dart" as connect;
import "service.pb.dart" as espressocashapiswapv1service;
import "service.connect.spec.dart" as specs;

extension type SwapServiceClient (connect.Transport _transport) {
  Future<espressocashapiswapv1service.SwapRouteResponse> swap(
    espressocashapiswapv1service.SwapRouteRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.SwapService.swap,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
