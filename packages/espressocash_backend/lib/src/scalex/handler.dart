import 'dart:core';

import 'package:espressocash_api/espressocash_api.dart' hide OrderStatus;
import 'package:espressocash_backend/src/scalex/client/client.dart';
import 'package:espressocash_backend/src/scalex/client/model.dart';
import 'package:espressocash_backend/src/utils.dart';
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
                onRampDetails: e.data.type == 'onramp'
                    ? OnRampScalexDetails(
                        currency: e.data.fromCurrency,
                        bankName: e.data.bankToFund?.bankName ?? '',
                        bankAccount: e.data.bankToFund?.accountNumber ?? '',
                        fromAmount: e.data.fromAmount,
                        fiatCurrency: e.data.fromCurrency,
                      )
                    : null,
              ),
            );
      },
    );

extension on OrderStatus {
  ScalexOrderStatus toModel() => switch (this) {
        OrderStatus.pending => ScalexOrderStatus.pending,
        OrderStatus.completed => ScalexOrderStatus.completed,
        OrderStatus.failed => ScalexOrderStatus.failed,
        OrderStatus.expired => ScalexOrderStatus.expired,
        OrderStatus.unknown => ScalexOrderStatus.unknown,
      };
}
