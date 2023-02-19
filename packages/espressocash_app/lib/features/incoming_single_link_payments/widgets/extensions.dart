import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/single_key_payments.dart';
import '../../../routes.gr.dart';
import '../src/widgets/extensions.dart';

extension BuildContextExt on BuildContext {
  Future<void> processISLP(SingleKeyPaymentData data) async {
    final id = await createISLP(data);
    await router.push(IncomingSingleLinkRoute(id: id));
  }
}
