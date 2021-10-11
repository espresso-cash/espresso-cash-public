import 'package:solana/src/subscription_client/subscription_client.dart';
import 'package:solana/src/types/account.dart';
import 'package:test/test.dart';

void main() {
  test('accountSubscribe must return account owned by the system program',
      () async {
    const address = 'G5iCB42rmm6NbANo9FHhcJvRPbfPTvtYQakNgfv3h7NQ';
    // System program
    const accountOwner = '11111111111111111111111111111111';
    final client = await SubscriptionClient.connect(_websocketUrl);
    final account = await client.accountSubscribe(address).firstWhere(
          (Account data) => true,
        );

    expect(account.owner, equals(accountOwner));
  });
}

const _websocketUrl = 'ws://127.0.0.1:8900';
