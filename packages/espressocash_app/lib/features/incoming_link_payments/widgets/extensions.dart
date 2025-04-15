import 'package:flutter/widgets.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:solana/solana.dart';

import '../../../di.dart';
import '../../../ui/loader.dart';
import '../../accounts/models/account.dart';
import '../services/ilp_service.dart';

extension BuildContextExt on BuildContext {
  Future<String> createILP({required Ed25519HDKeyPair escrow}) => runWithLoader(this, () async {
    final span = _start(function: 'createILP');

    final payment = await sl<ILPService>().create(account: sl<MyAccount>().wallet, escrow: escrow);
    await span.finish();

    return payment.id;
  });
}

ISentrySpan _start({required String function}) =>
    Sentry.startTransaction('ILP Tx Creation', function);
