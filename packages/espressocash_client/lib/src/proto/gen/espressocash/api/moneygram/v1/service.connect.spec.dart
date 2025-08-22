//
//  Generated code. Do not modify.
//  source: espressocash/api/moneygram/v1/service.proto
//

import "package:connectrpc/connect.dart" as connect;
import "service.pb.dart" as espressocashapimoneygramv1service;

abstract final class MoneygramService {
  /// Fully-qualified name of the MoneygramService service.
  static const name = 'espressocash.api.moneygram.v1.MoneygramService';

  static const signChallenge = connect.Spec(
    '/$name/SignChallenge',
    connect.StreamType.unary,
    espressocashapimoneygramv1service.MoneygramChallengeSignRequest.new,
    espressocashapimoneygramv1service.MoneygramChallengeSignResponse.new,
  );

  static const swapToSolana = connect.Spec(
    '/$name/SwapToSolana',
    connect.StreamType.unary,
    espressocashapimoneygramv1service.SwapToSolanaRequest.new,
    espressocashapimoneygramv1service.MoneygramSwapResponse.new,
  );

  static const swapToStellar = connect.Spec(
    '/$name/SwapToStellar',
    connect.StreamType.unary,
    espressocashapimoneygramv1service.SwapToStellarRequest.new,
    espressocashapimoneygramv1service.MoneygramSwapResponse.new,
  );

  static const calculateFee = connect.Spec(
    '/$name/CalculateFee',
    connect.StreamType.unary,
    espressocashapimoneygramv1service.MoneygramFeeRequest.new,
    espressocashapimoneygramv1service.MoneygramFeeResponse.new,
  );

  static const fundXlm = connect.Spec(
    '/$name/FundXlm',
    connect.StreamType.unary,
    espressocashapimoneygramv1service.FundXlmRequest.new,
    espressocashapimoneygramv1service.FundXlmResponse.new,
  );
}
