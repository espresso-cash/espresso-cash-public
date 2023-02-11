import 'package:bloc_test/bloc_test.dart';
import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:espressocash_app/core/accounts/bl/ec_wallet.dart';
import 'package:espressocash_app/core/amount.dart';
import 'package:espressocash_app/core/currency.dart';
import 'package:espressocash_app/core/tokens/token.dart';
import 'package:espressocash_app/core/transactions/tx_sender.dart';
import 'package:espressocash_app/features/outgoing_direct_payments/models/outgoing_direct_payment.dart';
import 'package:espressocash_app/features/outgoing_direct_payments/src/bl/bloc.dart';
import 'package:espressocash_app/features/outgoing_direct_payments/src/bl/repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

import 'bloc_test.mocks.dart';

final sender = MockTxSender();
final client = MockCryptopleaseClient();

@GenerateMocks([TxSender, CryptopleaseClient])
Future<void> main() async {
  final account = LocalWallet(await Ed25519HDKeyPair.random());
  final receiver = await Ed25519HDKeyPair.random();
  final repository = MemoryRepository();

  setUp(() {
    reset(sender);
    reset(client);
    repository.clear();
  });

  final stubTx = await Message.only(
    MemoInstruction(signers: const [], memo: 'test'),
  )
      .compile(
        recentBlockhash: 'EkSnNWid2cvwEVnVx9aBqawnmiCNiDgp3gUdkDPTKN1N',
        feePayer: account.publicKey,
      )
      .let(
        (it) async => SignedTx(
          compiledMessage: it,
          signatures: [await account.sign(it.toByteArray())],
        ),
      )
      .then((it) => it.encode());
  final testApiResponse = CreateDirectPaymentResponseDto(
    fee: 100,
    transaction: stubTx,
  );
  const testAmount = CryptoAmount(
    value: 100000000,
    cryptoCurrency: CryptoCurrency(token: Token.usdc),
  );

  ODPBloc createBloc() => ODPBloc(
        repository: repository,
        client: client,
        account: account,
        txSender: sender,
      );

  blocTest<ODPBloc, ODPState>(
    'happy path',
    setUp: () async {
      when(client.createDirectPayment(any))
          .thenAnswer((_) async => testApiResponse);

      when(sender.send(any)).thenAnswer((_) async => const TxSendResult.sent());
      when(sender.wait(any))
          .thenAnswer((_) async => const TxWaitResult.success());
    },
    build: createBloc,
    act: (b) async {
      b.add(
        ODPEvent.create(
          id: const Uuid().v4(),
          receiver: receiver.publicKey,
          reference: null,
          amount: testAmount,
        ),
      );
    },
    verify: (b) async {
      verify(sender.send(any)).called(1);
      verify(sender.wait(any)).called(1);

      expect(repository._payments.length, 1);
      expect(
        repository._payments.values.first,
        isA<OutgoingDirectPayment>()
            .having((it) => it.status, 'status', isA<ODPStatusSuccess>()),
      );
    },
  );

  blocTest<ODPBloc, ODPState>(
    'failed to get tx from API',
    setUp: () async {
      when(client.createDirectPayment(any))
          .thenAnswer((_) async => throw Exception());
    },
    build: createBloc,
    act: (b) async {
      b.add(
        ODPEvent.create(
          id: const Uuid().v4(),
          receiver: receiver.publicKey,
          reference: null,
          amount: testAmount,
        ),
      );
    },
    verify: (b) async {
      verifyNever(sender.send(any));
      verifyNever(sender.wait(any));

      expect(repository._payments.length, 1);
      expect(
        repository._payments.values.first,
        isA<OutgoingDirectPayment>()
            .having((it) => it.status, 'status', const ODPStatus.txFailure()),
      );
    },
  );
}

class MemoryRepository implements ODPRepository {
  final Map<String, OutgoingDirectPayment> _payments = {};

  @override
  Future<OutgoingDirectPayment?> load(String id) async => _payments[id];

  @override
  Future<void> save(OutgoingDirectPayment payment) async {
    _payments[payment.id] = payment;
  }

  @override
  Future<void> clear() async => _payments.clear();

  @override
  Stream<OutgoingDirectPayment?> watch(String id) {
    throw UnimplementedError();
  }
}
