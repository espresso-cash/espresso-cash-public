import 'dart:math';

import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';

import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../ramp_partner/models/ramp_partner.dart';
import '../../tokens/token.dart';
import '../models/fee_type.dart';

@injectable
class FeeCalculator {
  const FeeCalculator(this._ecClient, this._solanaClient);

  final EspressoCashClient _ecClient;
  final SolanaClient _solanaClient;

  Future<CryptoAmount> call(FeeType type) => _ecClient.getFees().then(
        (fees) async {
          switch (type) {
            case FeeTypeDirect(:final address, :final token):
              return await _hasAta(address: address, token: token)
                  ? fees.directPayment.ataExists
                  : fees.directPayment.ataDoesNotExist;
            case FeeTypeLink():
              return fees.escrowPayment;
            case FeeTypeWithdraw(:final amount, :final partner, :final address):
              final percentageFee = switch (partner) {
                RampPartner.scalex ||
                RampPartner.scalexBrij =>
                  fees.withdrawFeePercentage.scalex,
                RampPartner.coinflow => fees.withdrawFeePercentage.coinflow,
                RampPartner.guardarian => fees.withdrawFeePercentage.guardarian,
                RampPartner.rampNetwork =>
                  fees.withdrawFeePercentage.rampNetwork,
                RampPartner.kado => fees.withdrawFeePercentage.kado,
                RampPartner.brij || RampPartner.moneygram => 0,
              };
              final percentageFeeAmount = (amount * percentageFee).ceil();

              final accountCreationFeeAmount = address == null
                  ? 0
                  : await _hasAta(address: address, token: Token.usdc)
                      ? fees.directPayment.ataExists
                      : fees.directPayment.ataDoesNotExist;

              return max(percentageFeeAmount, accountCreationFeeAmount);
          }
        },
      ).then((fee) => CryptoAmount(value: fee, cryptoCurrency: Currency.usdc));

  Future<bool> _hasAta({
    required Ed25519HDPublicKey address,
    required Token token,
  }) =>
      _solanaClient.hasAssociatedTokenAccount(
        owner: address,
        mint: token.publicKey,
      );
}
