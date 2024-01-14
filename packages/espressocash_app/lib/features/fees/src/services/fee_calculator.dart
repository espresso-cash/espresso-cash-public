import 'dart:math';

import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';

import '../../../../core/amount.dart';
import '../../../../core/currency.dart';
import '../../../ramp/models/ramp_partner.dart';
import '../../../tokens/token.dart';
import '../../models/fee_type.dart';

@injectable
class FeeCalculator {
  const FeeCalculator(this._cryptopleaseClient, this._solanaClient);

  final CryptopleaseClient _cryptopleaseClient;
  final SolanaClient _solanaClient;

  Future<CryptoAmount> call(FeeType type) => _cryptopleaseClient.getFees().then(
        (fees) async {
          switch (type) {
            case FeeTypeDirect(:final address):
              final hasAta = await _solanaClient.hasAssociatedTokenAccount(
                owner: address,
                mint: Token.usdc.publicKey,
              );

              return hasAta
                  ? fees.directPayment.ataExists
                  : fees.directPayment.ataDoesNotExist;
            case FeeTypeLink():
              return fees.escrowPayment;
            case FeeTypeWithdraw(:final amount, :final partner, :final address):
              final percentageFee = switch (partner) {
                RampPartner.scalex => fees.withdrawFeePercentage.scalex,
                RampPartner.coinflow => fees.withdrawFeePercentage.coinflow,
                RampPartner.guardarian => fees.withdrawFeePercentage.guardarian,
                RampPartner.rampNetwork =>
                  fees.withdrawFeePercentage.rampNetwork,
                RampPartner.kado => fees.withdrawFeePercentage.kado,
              };
              final percentageFeeAmount = (amount * percentageFee).ceil();

              final accountCreationFeeAmount = await address.let(
                (depositAddress) async {
                  if (depositAddress == null) return 0;

                  return _solanaClient
                      .hasAssociatedTokenAccount(
                        owner: depositAddress,
                        mint: Token.usdc.publicKey,
                      )
                      .letAsync(
                        (hasAta) => hasAta
                            ? fees.directPayment.ataExists
                            : fees.directPayment.ataDoesNotExist,
                      );
                },
              );

              return max(percentageFeeAmount, accountCreationFeeAmount);
          }
        },
      ).then((fee) => CryptoAmount(value: fee, cryptoCurrency: Currency.usdc));
}
