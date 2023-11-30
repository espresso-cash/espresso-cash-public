import 'dart:core';

import 'package:espressocash_api/espressocash_api.dart';
import 'package:espressocash_backend/src/utils.dart';
import 'package:scalex_api/scalex.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart' as shelf_router;

Handler addScalexHandler() => (shelf_router.Router()
      ..post('/scalex/generate', _generateLinkHandler)
      ..post('/scalex/fetch', _fetchStatusHandler))
    .call;

Future<Response> _generateLinkHandler(Request request) =>
    processRequest<GenerateScalexLinkRequestDto, GenerateScalexLinkResponseDto>(
      request,
      GenerateScalexLinkRequestDto.fromJson,
      (data) async {
        final client = ScalexApiClient();

        final url = await client.generateIFrameUrl(
          GenerateIFrameBodyDto(
            type: data.type,
            address: data.address,
            email: data.email,
            token: 'USDC',
            network: 'SOLANA',
          ),
        );

        return GenerateScalexLinkResponseDto(signedUrl: url.data.link);
      },
    );

Future<Response> _fetchStatusHandler(Request request) =>
    processRequest<OrderStatusScalexRequestDto, OrderStatusScalexResponseDto>(
      request,
      OrderStatusScalexRequestDto.fromJson,
      (data) async {
        final client = ScalexApiClient();

        return client.getTransaction(data.referenceId).then(
              (e) => OrderStatusScalexResponseDto(
                status: e.data.status.toModel(),
              ),
            );
      },
    );

extension on OrderStatus {
  ScalexOrderStatus toModel() => switch (this) {
        OrderStatus.pending => ScalexOrderStatus.pending,
        OrderStatus.completed => ScalexOrderStatus.completed,
        OrderStatus.unknown => ScalexOrderStatus.unknown,
      };
}
