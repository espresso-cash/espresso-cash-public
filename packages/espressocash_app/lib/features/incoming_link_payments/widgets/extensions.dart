import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana.dart';

import '../../../di.dart';
import '../../../ui/loader.dart';
import '../../accounts/models/account.dart';
import '../models/incoming_link_payment.dart';
import '../services/ilp_service.dart';

extension BuildContextExt on BuildContext {
  Future<String> createILP({
    required Ed25519HDKeyPair escrow,
  }) async =>
      runWithLoader(this, () async {
        final payment = await sl<ILPService>().create(
          account: read<MyAccount>().wallet,
          escrow: escrow,
        );

        return payment.id;
      });

  Future<void> retryILP(IncomingLinkPayment payment) async =>
      runWithLoader(this, () async {
        await sl<ILPService>().retry(
          payment,
          account: read<MyAccount>().wallet,
        );
      });
}
