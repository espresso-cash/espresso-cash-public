import 'package:bloc_test/bloc_test.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/core/tx_sender.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/bl/bloc.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/bl/outgoing_direct_payment.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/bl/repository.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import 'bloc_test.mocks.dart';

final sender = MockTxSender();
final client = MockCryptopleaseClient();

@GenerateMocks([TxSender, CryptopleaseClient])
Future<void> main() async {
  final account = await Ed25519HDKeyPair.random();
  final receiver = await Ed25519HDKeyPair.random();
  final repository = MemoryRepository();

  setUp(() {
    reset(sender);
    reset(client);
    repository.clear();
  });

  final stubTx = await Message.only(MemoInstruction(signers: [], memo: 'test'))
      .compile(recentBlockhash: 'EkSnNWid2cvwEVnVx9aBqawnmiCNiDgp3gUdkDPTKN1N')
      .let(
        (it) async => SignedTx(
          messageBytes: it.data,
          signatures: [await account.sign(it.data)],
        ),
      )
      .then((it) => it.encode());

  blocTest<ODPBloc, ODPState>(
    'happy path',
    setUp: () async {
      when(client.createDirectPayment(any)).thenAnswer(
        (_) async => CreateDirectPaymentResponseDto(
          fee: 100,
          transaction: stubTx,
        ),
      );

      when(sender.send(any)).thenAnswer((_) async => const TxSendResult.sent());
      when(sender.wait(any))
          .thenAnswer((_) async => const TxWaitResult.success());
    },
    build: () => ODPBloc(
      repository: repository,
      client: client,
      account: account,
      txSender: sender,
    ),
    act: (b) async {
      b.add(
        ODPEvent.create(
          receiver: receiver.publicKey,
          amount: const CryptoAmount(
            value: 100000000,
            currency: CryptoCurrency(token: Token.usdc),
          ),
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
            .having((it) => it.status, 'status', const ODPStatus.success()),
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

  void clear() => _payments.clear();
}
