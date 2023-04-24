import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana.dart';

import '../../../../core/api_version.dart';
import '../../core/accounts/bl/account.dart';
import '../../di.dart';
import '../../ui/loader.dart';
import 'src/bl/incoming_split_key_payment.dart';
import 'src/bl/iskp_service.dart';

extension ISKPExt on BuildContext {
  Future<String> createISKP({
    required Ed25519HDKeyPair escrow,
    required SplitKeyApiVersion version,
  }) async =>
      runWithLoader(this, () async {
        final payment = await sl<ISKPService>().create(
          account: read<MyAccount>().wallet,
          escrow: escrow,
          apiVersion: version,
        );

        return payment.id;
      });

  Future<void> retryISKP(IncomingSplitKeyPayment payment) async =>
      runWithLoader(this, () async {
        await sl<ISKPService>().retry(
          payment,
          account: read<MyAccount>().wallet,
        );
      });
}
