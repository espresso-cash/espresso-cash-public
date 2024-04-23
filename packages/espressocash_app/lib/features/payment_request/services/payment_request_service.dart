import 'package:decimal/decimal.dart';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';
import 'package:solana/solana_pay.dart';
import 'package:uuid/uuid.dart';

import '../../currency/models/amount.dart';
import '../../feature_flags/services/feature_flags_manager.dart';
import '../../tokens/token.dart';
import '../data/repository.dart';
import '../models/payment_request.dart';

@injectable
class PaymentRequestService {
  const PaymentRequestService(this._repository, this._featureFlags);

  final PaymentRequestRepository _repository;
  final FeatureFlagsManager _featureFlags;

  Future<PaymentRequest> create({
    required Ed25519HDPublicKey recipient,
    required CryptoAmount tokenAmount,
    required String? label,
  }) async {
    final reference = await compute(_randomPublicKey, null);
    final Token token = tokenAmount.token;
    final Decimal amount = tokenAmount.decimal;

    final request = SolanaPayRequest(
      recipient: recipient,
      amount: amount,
      splToken: token == Token.sol ? null : token.publicKey,
      label: label,
      reference: [reference],
    );
    final id = const Uuid().v4();

    final showDlnFeature = _featureFlags.isIncomingDlnEnabled();

    final paymentRequest = PaymentRequest(
      id: id,
      created: DateTime.now(),
      payRequest: request,
      dynamicLink: request.toUniversalLink(showDln: showDlnFeature).toString(),
      state: const PaymentRequestState.initial(),
    );
    await _repository.save(paymentRequest);

    return paymentRequest;
  }
}

Future<Ed25519HDPublicKey> _randomPublicKey([dynamic _]) async {
  final keyPair = await Ed25519HDKeyPair.random();

  return keyPair.publicKey;
}
