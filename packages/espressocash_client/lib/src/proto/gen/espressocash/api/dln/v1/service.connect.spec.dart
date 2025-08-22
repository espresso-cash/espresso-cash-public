//
//  Generated code. Do not modify.
//  source: espressocash/api/dln/v1/service.proto
//

import "package:connectrpc/connect.dart" as connect;
import "service.pb.dart" as espressocashapidlnv1service;

abstract final class DlnService {
  /// Fully-qualified name of the DlnService service.
  static const name = 'espressocash.api.dln.v1.DlnService';

  static const getOutgoingQuote = connect.Spec(
    '/$name/GetOutgoingQuote',
    connect.StreamType.unary,
    espressocashapidlnv1service.GetOutgoingQuoteRequest.new,
    espressocashapidlnv1service.GetOutgoingQuoteResponse.new,
  );

  static const getIncomingQuote = connect.Spec(
    '/$name/GetIncomingQuote',
    connect.StreamType.unary,
    espressocashapidlnv1service.GetIncomingQuoteRequest.new,
    espressocashapidlnv1service.GetIncomingQuoteResponse.new,
  );

  static const getOrderId = connect.Spec(
    '/$name/GetOrderId',
    connect.StreamType.unary,
    espressocashapidlnv1service.GetOrderIdRequest.new,
    espressocashapidlnv1service.GetOrderIdResponse.new,
  );

  static const getOrderStatus = connect.Spec(
    '/$name/GetOrderStatus',
    connect.StreamType.unary,
    espressocashapidlnv1service.GetOrderStatusRequest.new,
    espressocashapidlnv1service.GetOrderStatusResponse.new,
  );

  static const getGasFees = connect.Spec(
    '/$name/GetGasFees',
    connect.StreamType.unary,
    espressocashapidlnv1service.GetGasFeesRequest.new,
    espressocashapidlnv1service.GetGasFeesResponse.new,
  );
}
