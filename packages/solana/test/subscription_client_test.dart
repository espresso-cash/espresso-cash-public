import 'dart:async';

import 'package:solana/src/subscription_client/subscription_client.dart';
import 'package:solana/src/types/account.dart';
import 'package:test/test.dart';

void main() {
  test('Subscribe to 1 event', () async {
    StreamSubscription<dynamic>? subscription;

    const address = 'G5iCB42rmm6NbANo9FHhcJvRPbfPTvtYQakNgfv3h7NQ';
    const accountOwner = '11111111111111111111111111111111';
    final client = await SubscriptionClient.connect('ws://127.0.0.1:8900');
    final account = await client.accountSubscribe(address).firstWhere(
          (Account data) => true,
        );
    expect(account.owner, equals(accountOwner));
  });
}
