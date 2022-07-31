import 'dart:convert';

import 'package:cryptoplease_link/src/constants.dart';
import 'package:cryptoplease_link/src/payments/create_payment.dart';
import 'package:cryptoplease_link/src/payments/dto.dart';
import 'package:cryptoplease_link/src/payments/receive_payment.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart' as shelf_router;
import 'package:solana/solana.dart';

Future<Handler> paymentHandler({
  required SolanaClient client,
  required Ed25519HDKeyPair platform,
  required String subDomain,
  required Ed25519HDPublicKey mint,
}) async {
  final router = shelf_router.Router()
    ..post(
      '/createPayment',
      createPaymentHandler(client: client, platform: platform, mint: mint),
    )
    ..post(
      '/receivePayment',
      receivePaymentHandler(client: client, platform: platform, mint: mint),
    );

  return (Request request) async {
    if (request.requestedUri.host != '$subDomain.$cpLinkDomain') {
      return Response.notFound(null);
    }

    return router(request);
  };
}

Handler createPaymentHandler({
  required SolanaClient client,
  required Ed25519HDKeyPair platform,
  required Ed25519HDPublicKey mint,
}) =>
    (request) async =>
        processRequest<CreatePaymentRequestDto, CreatePaymentResponseDto>(
          request,
          CreatePaymentRequestDto.fromJson,
          (data) async {
            final payment = await createPaymentTx(
              aSender: Ed25519HDPublicKey.fromBase58(data.senderAccount),
              aEscrow: Ed25519HDPublicKey.fromBase58(data.escrowAccount),
              mint: mint,
              amount: data.amount,
              fee: shareableLinkPaymentFee,
              platform: platform,
              client: client,
              commitment: Commitment.confirmed,
            );

            return CreatePaymentResponseDto(transaction: payment.encode());
          },
        );

Handler receivePaymentHandler({
  required SolanaClient client,
  required Ed25519HDKeyPair platform,
  required Ed25519HDPublicKey mint,
}) =>
    (request) async =>
        processRequest<ReceivePaymentRequestDto, ReceivePaymentResponseDto>(
          request,
          ReceivePaymentRequestDto.fromJson,
          (data) async {
            final payment = await receivePaymentTx(
              aReceiver: Ed25519HDPublicKey.fromBase58(data.receiverAccount),
              aEscrow: Ed25519HDPublicKey.fromBase58(data.escrowAccount),
              mint: mint,
              platform: platform,
              client: client,
              commitment: Commitment.confirmed,
            );

            return ReceivePaymentResponseDto(transaction: payment.encode());
          },
        );

Future<Response> processRequest<T, R>(
  Request request,
  T Function(Map<String, dynamic>) parse,
  Future<R> Function(T data) handler,
) async {
  final body = await request.readAsString();

  final T dto;
  try {
    final data = json.decode(body) as Map<String, dynamic>;
    dto = parse(data);
  } on Object {
    return Response.badRequest(body: 'Invalid JSON');
  }

  return Response.ok(
    json.encode(await handler(dto)),
    headers: {
      'content-type': 'application/json',
    },
  );
}
