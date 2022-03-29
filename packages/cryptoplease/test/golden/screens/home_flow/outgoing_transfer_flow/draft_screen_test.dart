import 'package:cryptoplease/bl/outgoing_transfers/outgoing_payment.dart';
import 'package:cryptoplease/bl/outgoing_transfers/outgoing_transfers_bloc/bloc.dart';
import 'package:cryptoplease/presentation/screens/authenticated/outgoing_transfer_flow/draft_screen.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../utils.dart';
import 'draft_screen_test.mocks.dart';

@GenerateMocks([OutgoingTransfersBloc])
void main() {
  final bloc = MockOutgoingTransfersBloc();
  final transfer = OutgoingTransfer.direct(
    id: 'id',
    created: DateTime.now(),
    recipient: 'recipient',
    amount: 100,
    tokenAddress: 'sol',
    state: const OutgoingTransferState.draft(),
    tokenType: OutgoingTransferTokenType.fungibleToken,
  );

  tearDown(() => reset(bloc));

  testGoldensWidget(
    'DraftScreen loading',
    BlocProvider<OutgoingTransfersBloc>.value(
      value: bloc,
      child: DraftScreen(transfer: transfer),
    ),
    setUp: () => whenListen(
      bloc,
      initialState: OutgoingTransfersState(processingIds: ['id'].lock),
    ),
    // Don't use default pump (which is pumpAndSettle) because
    // there should be a loader animation, so it will never finish.
    customPump: (t) => t.pump(),
  );

  testGoldensWidget(
    'DraftScreen error',
    BlocProvider<OutgoingTransfersBloc>.value(
      value: bloc,
      child: DraftScreen(transfer: transfer),
    ),
    setUp: () => whenListen(
      bloc,
      initialState: OutgoingTransfersState(
        errors: {'id': Exception('Test exception')}.lock,
      ),
    ),
  );
}
