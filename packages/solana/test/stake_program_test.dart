import 'package:solana/src/constants.dart';
import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/programs/stake_program/stake_instruction.dart';
import 'package:solana/src/programs/stake_program/stake_program.dart';
import 'package:solana/src/programs/stake_program/state.dart';
import 'package:solana/src/rpc/client.dart';
import 'package:solana/src/rpc/dto/confirmation_status.dart';
import 'package:solana/src/subscription_client/subscription_client.dart';
import 'package:test/test.dart';

import 'config.dart';

void main() {
  final RpcClient rpcClient = RpcClient(devnetRpcUrl);
  final SubscriptionClient subscriptionClient =
      SubscriptionClient.connect(devnetWebsocketUrl);

  test('Initialize account instruction encodes correctly', () async {
    for (var each in _initializeInstruction) {
      final instruction = StakeInstruction.initialize(
        stakePubKey: each.stakePubKey,
        authorized: Authorized(
          staker: each.staker,
          withdrawer: each.withdrawer,
        ),
        lockup: Lockup(
          custodian: each.custodian,
          unixTimestamp: each.unixTimestamp,
          epoch: each.epoch,
        ),
      );

      expect(instruction.data, equals(each.result));
    }
  });

  test('Create Account', () async {
    final stakeAmount = 10 * lamportsPerSol;
    final ownerKey = await _createFundedKey(rpcClient, subscriptionClient);
    final stakeAccountKey = await Ed25519HDKeyPair.random();
    final rent = await rpcClient
        .getMinimumBalanceForRentExemption(StakeProgram.neededAccountSpace);
    final message = StakeProgram.createAccount(
      fromPubKey: ownerKey.address,
      stakePubKey: stakeAccountKey.address,
      authorized: Authorized(
        staker: stakeAccountKey.address,
        withdrawer: stakeAccountKey.address,
      ),
      lamports: rent + stakeAmount,
    );

    expect(
      rpcClient.signAndSendTransaction(message, [ownerKey, stakeAccountKey]),
      completes,
    );
  });
}

Future<Ed25519HDKeyPair> _createFundedKey(
  RpcClient rpcClient,
  SubscriptionClient subscriptionClient,
) async {
  final keyPair = await Ed25519HDKeyPair.random();
  final signature = await rpcClient.requestAirdrop(
    keyPair.address,
    100 * lamportsPerSol,
  );
  await subscriptionClient.waitForSignatureStatus(
    signature,
    status: ConfirmationStatus.finalized,
  );

  return keyPair;
}

class _InitializeInstructionTest {
  const _InitializeInstructionTest({
    required this.stakePubKey,
    required this.fromPubKey,
    required this.staker,
    required this.withdrawer,
    required this.result,
    required this.custodian,
    required this.unixTimestamp,
    required this.epoch,
  });

  final String stakePubKey;
  final String fromPubKey;
  final String staker;
  final String withdrawer;
  final String custodian;
  final int unixTimestamp;
  final int epoch;
  final List<int> result;
}

final _initializeInstruction = [
  _InitializeInstructionTest(
    stakePubKey: '6KiP35Nn1TSWnEFZn31aDfP4nqYSxssHPnE2vicEEEta',
    fromPubKey: 'EodkntvoReUiUvxdyXQT1BJoBHbB4fjANF6CmUxJo1Nd',
    withdrawer: 'Gdim4nhVJfRA2VoniuAZzJ7R8v2tpZY2zEXJsXoJLvki',
    staker: '55MhT5rKmcnVcGEUopLGaZb8Na5LyN2hTMMtZPZybLWJ',
    custodian: 'G5xFJn8diyKEYjYKQKGmnphfUiJpHjhgWxuh7z9AnkMe',
    unixTimestamp: 1641233401837,
    epoch: 1641233401837,
    result: [
      0, 0, 0, 0, 60, 140, 121, 60, 80, 195, //
      237, 68, 85, 104, 26, 38, 41, 249, 205, 208, //
      66, 250, 158, 55, 73, 27, 60, 78, 2, 245, //
      218, 133, 134, 152, 61, 159, 232, 71, 110, 80, //
      166, 69, 4, 20, 17, 33, 253, 246, 179, 246, //
      236, 238, 160, 164, 119, 159, 232, 244, 137, 172, //
      19, 14, 183, 235, 187, 202, 101, 163, 237, 71, //
      34, 33, 126, 1, 0, 0, 237, 71, 34, 33, //
      126, 1, 0, 0, 224, 36, 24, 64, 122, 139, //
      228, 20, 135, 222, 143, 19, 108, 45, 127, 22, //
      87, 192, 216, 5, 85, 167, 235, 233, 211, 172, //
      157, 93, 158, 32, 28, 145
    ],
  ),
  _InitializeInstructionTest(
    stakePubKey: 'A8bahvTDmxeo1AHCfAUP2Sx5wzjo2d5xXW1UhKVEUmt',
    fromPubKey: 'xH1A1SH2SSTjMZBByjS4SRX6PG6NBcfT9A4jCk6uPbc',
    withdrawer: 'Hqc7SaPDKNGwk8TSto7m6fisTTRnFWkMgVxMUfDC1hDo',
    staker: 'GcSZnzGPpH49EQrv7wjjaySiZUq7trQnjEEZHbSfWzHD',
    custodian: 'DbPiKiPbEg4DEYU6cMxehtBFnCexNbecCgGUGjrdWW4d',
    unixTimestamp: 1641233401860,
    epoch: 1641233401860,
    result: [
      0, 0, 0, 0, 231, 243, 138, 2, 61, 240, //
      41, 248, 52, 201, 157, 192, 24, 149, 143, 49, //
      68, 197, 215, 149, 207, 110, 76, 28, 159, 174, //
      104, 170, 103, 48, 22, 184, 250, 46, 145, 225, //
      162, 171, 179, 254, 112, 252, 241, 238, 10, 140, //
      154, 183, 150, 228, 10, 241, 194, 55, 175, 29, //
      215, 35, 103, 10, 136, 203, 222, 182, 4, 72, //
      34, 33, 126, 1, 0, 0, 4, 72, 34, 33, //
      126, 1, 0, 0, 187, 27, 171, 243, 132, 242, //
      98, 72, 196, 250, 140, 218, 121, 157, 15, 13, //
      102, 59, 93, 71, 177, 145, 40, 190, 239, 213, //
      221, 94, 41, 5, 215, 78
    ],
  ),
  _InitializeInstructionTest(
    stakePubKey: '6SQdAT4okuuRNLQ44e2k6DhLx9yHHXGKzzQ1VtFx59ed',
    fromPubKey: 'Hw6EMvribTf4e4GPdLsg1a2qqjEDZ7h6PYUhxRAmc4Ew',
    withdrawer: 'Cwp8bNqEj6hPguDfYqDxcGN68MPTQL773tJjDxeZRDfd',
    staker: '5dn1u5KrBs4xe3toboiBB8nmeBG98xuTtw8pXb32cJct',
    custodian: 'GqGrEuhPBGszevHK3TuE8JuYLDK7DkjGdR9p2DXmtzXZ',
    unixTimestamp: 1641233401880,
    epoch: 1641233401880,
    result: [
      0, 0, 0, 0, 68, 218, 142, 85, 219, 63, //
      63, 252, 97, 190, 216, 141, 71, 38, 181, 150, //
      251, 41, 221, 67, 56, 25, 117, 143, 12, 64, //
      219, 131, 183, 21, 23, 205, 177, 123, 54, 2, //
      1, 252, 169, 117, 244, 159, 57, 40, 213, 88, //
      159, 30, 168, 42, 241, 170, 205, 182, 2, 183, //
      160, 75, 221, 250, 181, 103, 146, 16, 24, 72, //
      34, 33, 126, 1, 0, 0, 24, 72, 34, 33, //
      126, 1, 0, 0, 235, 61, 26, 107, 239, 201, //
      108, 232, 222, 255, 198, 160, 100, 49, 245, 140, //
      79, 239, 110, 54, 64, 146, 92, 145, 75, 227, //
      144, 97, 21, 118, 149, 232
    ],
  ),
  _InitializeInstructionTest(
    stakePubKey: 'HAnCsmU8h98MSgAJSMmmnrPSVJbNms7iarWxDLq2DfvX',
    fromPubKey: 'EncihD2kK7xacphmvYQQxAajCZErm1RN2cKWBzk31pvy',
    withdrawer: '9ugKzceAmSfQhuChS5F8SVK47vtCHhrDd1PzPssFCoq',
    staker: '3AbWs4myzjTu8VwRAPSaJLjcB72tCcsLYeEUQoVAPQ6d',
    custodian: 'H5eawnUaXNmqoqgM8ttZsji89KxRgaKaEhyuHsBzguoi',
    unixTimestamp: 1641233401902,
    epoch: 1641233401902,
    result: [
      0, 0, 0, 0, 32, 44, 160, 146, 147, 77, //
      109, 21, 108, 75, 73, 123, 254, 97, 58, 239, //
      99, 153, 191, 17, 57, 35, 221, 35, 185, 217, //
      201, 29, 65, 185, 60, 2, 2, 72, 53, 177, //
      213, 77, 231, 109, 202, 56, 66, 152, 53, 201, //
      219, 226, 10, 225, 93, 56, 6, 232, 39, 200, //
      56, 251, 214, 120, 33, 240, 37, 184, 46, 72, //
      34, 33, 126, 1, 0, 0, 46, 72, 34, 33, //
      126, 1, 0, 0, 238, 235, 207, 212, 134, 114, //
      4, 89, 24, 239, 86, 100, 81, 26, 182, 15, //
      9, 112, 78, 16, 239, 251, 109, 62, 173, 26, //
      48, 224, 192, 17, 175, 77
    ],
  ),
  _InitializeInstructionTest(
    stakePubKey: 'Ehd3QWEoJBJHaVjW5CCjeHcBBBHMqmyDnompHerMAdVw',
    fromPubKey: '65a1S12VytE7QZqApvbP246zoCffXvupbLd8zqdu1RNg',
    withdrawer: 'FqA8gqeQQNowE9QZq77yxahf1idyc82BJ6fWnHCeijuF',
    staker: '3eRzrhHgCpMWdDwAwWzaqzXeYiqpEbjX2P8HpJMWzdcq',
    custodian: 'DEKEepebhKiG5UZju2nrk84NMXRWEvo7wCZeXVKscQJG',
    unixTimestamp: 1641233401923,
    epoch: 1641233401923,
    result: [
      0, 0, 0, 0, 39, 78, 32, 235, 19, 236, //
      127, 230, 104, 170, 208, 156, 108, 16, 213, 235, //
      221, 255, 227, 144, 23, 199, 196, 32, 237, 137, //
      196, 21, 118, 131, 253, 38, 220, 89, 210, 110, //
      13, 7, 33, 110, 201, 211, 206, 47, 52, 18, //
      205, 196, 179, 223, 48, 60, 86, 82, 209, 171, //
      186, 31, 167, 217, 224, 102, 166, 214, 67, 72, //
      34, 33, 126, 1, 0, 0, 67, 72, 34, 33, //
      126, 1, 0, 0, 181, 181, 105, 150, 1, 223, //
      78, 102, 199, 216, 215, 189, 54, 251, 27, 69, //
      186, 130, 118, 217, 14, 215, 9, 151, 78, 237, //
      232, 115, 154, 170, 2, 253
    ],
  ),
  _InitializeInstructionTest(
    stakePubKey: 'C3AL8nhRzZ6uAj8shmTGJRRvtbMXtrZeYCFyAJbThGRr',
    fromPubKey: 'BuTRMZoKcnRZghgF25DwXex8k3JPp4UZW76jMdyLiDTn',
    withdrawer: '4nLXuerWNE3Cs9Ef8oHomxRfZaDJnVrqrMpqvpe1UbXQ',
    staker: '7sE5x9hqQHqJH7uBUtvSMwBRTvwnB5XQTgsfJBsfWmv8',
    custodian: 'EhKTTXjBqGznNTeAhnFaW8y1163CaRBgoVCMQ2ECmBrf',
    unixTimestamp: 1641233401945,
    epoch: 1641233401945,
    result: [
      0, 0, 0, 0, 102, 3, 245, 42, 52, 184, //
      106, 42, 184, 9, 194, 153, 35, 209, 109, 20, //
      255, 89, 147, 65, 54, 89, 10, 16, 240, 137, //
      210, 221, 124, 61, 149, 97, 56, 48, 72, 121, //
      64, 137, 232, 196, 47, 96, 33, 5, 177, 91, //
      138, 208, 126, 108, 90, 48, 179, 232, 92, 184, //
      115, 151, 222, 79, 92, 192, 104, 67, 89, 72, //
      34, 33, 126, 1, 0, 0, 89, 72, 34, 33, //
      126, 1, 0, 0, 203, 124, 7, 230, 24, 245, //
      222, 202, 51, 247, 235, 28, 55, 92, 242, 168, //
      117, 130, 101, 72, 40, 79, 226, 35, 29, 185, //
      87, 204, 111, 114, 80, 24
    ],
  ),
  _InitializeInstructionTest(
    stakePubKey: 'HNxDZrhByf6PqcMtcQ6zn1MysnxWVi3sexJyY4UcaVVH',
    fromPubKey: '85Gr1oV2XdxCmgKYjTQy6UoZsyQdwpqGtAcZM57CiFgM',
    withdrawer: 'BDuJvXhvQDpqhShYvQyR8aVxhxeiDSjgxtnM7idhDt1A',
    staker: 'ENgBBoUhVgwb4GzFTXoDiZNcAE51TZAbHVQ3rK6GDSM3',
    custodian: '3MnbKeP4pA7RPTA5NxGRfS85hBKhcXjha1jiPLDTxKoy',
    unixTimestamp: 1641233401970,
    epoch: 1641233401970,
    result: [
      0, 0, 0, 0, 198, 181, 108, 77, 54, 111, //
      180, 109, 6, 87, 103, 182, 239, 38, 21, 105, //
      227, 179, 210, 181, 180, 116, 45, 1, 34, 177, //
      0, 31, 152, 118, 241, 254, 151, 226, 252, 38, //
      174, 129, 141, 11, 83, 227, 42, 137, 224, 174, //
      234, 144, 170, 43, 41, 208, 183, 174, 180, 182, //
      147, 95, 212, 48, 153, 67, 70, 85, 114, 72, //
      34, 33, 126, 1, 0, 0, 114, 72, 34, 33, //
      126, 1, 0, 0, 35, 10, 138, 113, 45, 35, //
      31, 211, 190, 182, 1, 204, 111, 65, 17, 38, //
      217, 206, 12, 86, 111, 64, 134, 136, 121, 209, //
      186, 242, 60, 21, 255, 164
    ],
  ),
  _InitializeInstructionTest(
    stakePubKey: 'Fpoz5kcGM9mr8hnYijCaJgF1XPUTT6E79zRkwvhgiUyQ',
    fromPubKey: 'GQ6dU6hNyEYteyXoSamKB5j7DYFi71JjEGtvqXmDrJcV',
    withdrawer: '8YJTkS5aCtXhZPMb4zdZh7PyLe2SSMW3wwGGyDRX8ps1',
    staker: 'ApDiMoAdGfHZZD5zhmv4MxeggUXev3ZADEVcaDXi1KM3',
    custodian: 'HJ4P8GTGQQ9HDTHh2WT3mJhNRQskvtcdhgFpPBapUgnz',
    unixTimestamp: 1641233401995,
    epoch: 1641233401995,
    result: [
      0, 0, 0, 0, 145, 209, 218, 231, 1, 38, //
      191, 32, 83, 121, 97, 49, 93, 243, 204, 37, //
      223, 148, 229, 75, 78, 89, 115, 100, 212, 135, //
      203, 57, 59, 168, 213, 226, 112, 6, 142, 151, //
      18, 0, 230, 65, 213, 222, 181, 215, 190, 90, //
      212, 240, 1, 45, 250, 96, 203, 196, 86, 99, //
      47, 62, 68, 208, 217, 233, 14, 232, 139, 72, //
      34, 33, 126, 1, 0, 0, 139, 72, 34, 33, //
      126, 1, 0, 0, 242, 25, 176, 33, 220, 138, //
      124, 195, 158, 96, 9, 237, 221, 20, 225, 216, //
      247, 220, 74, 60, 22, 244, 25, 216, 201, 108, //
      176, 28, 166, 144, 25, 47
    ],
  ),
  _InitializeInstructionTest(
    stakePubKey: '4UwjpewXFPSiYNikXf2SVWeBib7ypZuPsATBeoSdBsv5',
    fromPubKey: 'AA4mCmk9TyqCRiX79zRc9a6czSgPpfBdoP6D2f9VZXgc',
    withdrawer: 'G3mK1k29xGq4PzH2Ea7Gi8zNMUcgEjj6vy1kw2S6xmfR',
    staker: '6EYg9mRoFzXifKhcBksM4cz1hBexKPTwHFToNSoWxQDD',
    custodian: 'Bp5Q8k5gUQjjdu1hkYkEAUGC1yy8vvSh1G9p3q1s8fRH',
    unixTimestamp: 1641233402018,
    epoch: 1641233402018,
    result: [
      0, 0, 0, 0, 77, 194, 204, 218, 120, 129, //
      228, 146, 203, 20, 168, 75, 80, 214, 68, 119, //
      12, 242, 84, 119, 62, 230, 45, 32, 246, 100, //
      6, 155, 221, 65, 207, 232, 223, 148, 145, 80, //
      40, 125, 86, 7, 39, 112, 17, 109, 130, 133, //
      221, 198, 247, 182, 67, 194, 190, 36, 111, 62, //
      230, 85, 35, 55, 8, 111, 135, 172, 162, 72, //
      34, 33, 126, 1, 0, 0, 162, 72, 34, 33, //
      126, 1, 0, 0, 160, 164, 36, 30, 111, 191, //
      49, 97, 176, 179, 128, 0, 224, 142, 120, 23, //
      158, 181, 162, 35, 249, 230, 229, 9, 65, 213, //
      135, 160, 181, 164, 249, 16
    ],
  ),
  _InitializeInstructionTest(
    stakePubKey: 'GzCBYwYKzjwsv21sAWBrQ45Uz4VWApjVCfXnLggzpP9T',
    fromPubKey: 'FdfrAknnuqqUK5GmRcPwoTeuVnwtRBk8wTh9VP1Q7YDs',
    withdrawer: 'HhXEwRc1dfJAUhSxqs2eBmZWRM9EGRgLqL387nN1FVGr',
    staker: '4rP4LzjWG4nFw7WHCpmvEMrXRPddYbRdStxH8L6igPEM',
    custodian: 'CkiH1n3XnUBTEUTH7q7qw3NMpoffQNHmDE9LZ1SVW7mo',
    unixTimestamp: 1641233402042,
    epoch: 1641233402042,
    result: [
      0, 0, 0, 0, 57, 57, 118, 11, 53, 126, //
      136, 17, 159, 153, 21, 247, 248, 197, 244, 169, //
      226, 203, 132, 77, 209, 255, 44, 1, 47, 204, //
      95, 224, 34, 98, 158, 38, 248, 28, 106, 128, //
      62, 104, 193, 205, 219, 223, 91, 201, 192, 38, //
      50, 255, 99, 157, 73, 0, 135, 233, 43, 96, //
      140, 42, 204, 133, 40, 17, 87, 23, 186, 72, //
      34, 33, 126, 1, 0, 0, 186, 72, 34, 33, //
      126, 1, 0, 0, 174, 163, 51, 182, 189, 227, //
      61, 238, 117, 224, 53, 18, 39, 211, 94, 32, //
      208, 131, 236, 183, 244, 174, 118, 194, 235, 129, //
      63, 177, 212, 161, 160, 230
    ],
  ),
];
