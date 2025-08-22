//
//  Generated code. Do not modify.
//  source: espressocash/api/payments/v1/service.proto
//

import "package:connectrpc/connect.dart" as connect;
import "service.pb.dart" as espressocashapipaymentsv1service;

abstract final class PaymentService {
  /// Fully-qualified name of the PaymentService service.
  static const name = 'espressocash.api.payments.v1.PaymentService';

  static const createDirectPayment = connect.Spec(
    '/$name/CreateDirectPayment',
    connect.StreamType.unary,
    espressocashapipaymentsv1service.CreateDirectPaymentRequest.new,
    espressocashapipaymentsv1service.CreateDirectPaymentResponse.new,
  );

  static const getDirectPaymentQuote = connect.Spec(
    '/$name/GetDirectPaymentQuote',
    connect.StreamType.unary,
    espressocashapipaymentsv1service.GetDirectPaymentQuoteRequest.new,
    espressocashapipaymentsv1service.GetDirectPaymentQuoteResponse.new,
  );

  static const createEscrowPayment = connect.Spec(
    '/$name/CreateEscrowPayment',
    connect.StreamType.unary,
    espressocashapipaymentsv1service.CreateEscrowPaymentRequest.new,
    espressocashapipaymentsv1service.CreateEscrowPaymentResponse.new,
  );

  static const receiveEscrowPayment = connect.Spec(
    '/$name/ReceiveEscrowPayment',
    connect.StreamType.unary,
    espressocashapipaymentsv1service.ReceiveEscrowPaymentRequest.new,
    espressocashapipaymentsv1service.ReceiveEscrowPaymentResponse.new,
  );

  static const cancelEscrowPayment = connect.Spec(
    '/$name/CancelEscrowPayment',
    connect.StreamType.unary,
    espressocashapipaymentsv1service.CancelEscrowPaymentRequest.new,
    espressocashapipaymentsv1service.CancelEscrowPaymentResponse.new,
  );

  static const getOutgoingEscrowPaymentQuote = connect.Spec(
    '/$name/GetOutgoingEscrowPaymentQuote',
    connect.StreamType.unary,
    espressocashapipaymentsv1service.GetOutgoingEscrowPaymentQuoteRequest.new,
    espressocashapipaymentsv1service.GetOutgoingEscrowPaymentQuoteResponse.new,
  );

  static const getIncomingEscrowPaymentQuote = connect.Spec(
    '/$name/GetIncomingEscrowPaymentQuote',
    connect.StreamType.unary,
    espressocashapipaymentsv1service.GetIncomingEscrowPaymentQuoteRequest.new,
    espressocashapipaymentsv1service.GetIncomingEscrowPaymentQuoteResponse.new,
  );
}
