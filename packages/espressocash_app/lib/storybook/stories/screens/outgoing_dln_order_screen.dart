import 'package:dfunc/dfunc.dart';

import 'package:storybook_flutter/storybook_flutter.dart';

import '../../../features/blockchain/models/blockchain.dart';
import '../../../features/currency/models/amount.dart';
import '../../../features/currency/models/currency.dart';
import '../../../features/outgoing_dln_payments/models/dln_payment.dart';
import '../../../features/outgoing_dln_payments/models/outgoing_payment.dart';
import '../../../features/outgoing_dln_payments/screens/details_screen.dart';
import '../../../features/transactions/models/tx_results.dart';

final outgoingDlnScreenStory = Story(
  name: 'Screens/OutgoingDlnOrderScreen',
  builder: (context) => OutgoingDlnOrderScreenContent(
    order: OutgoingDlnPayment(
      id: dummyOrderId,
      amount: const CryptoAmount(
        value: 10000000,
        cryptoCurrency: Currency.usdc,
      ),
      created: DateTime.now(),
      status: context.knobs.options(
        label: 'Status',
        initial: txSent,
        options: [
          txSent,
          success,
          txFailure,
          fulfilled,
          unfulfilled,
        ].map((e) => Option(label: e.name, value: e)).toList(),
      ),
      payment: const DlnPayment(
        inputAmount: CryptoAmount(
          value: 10000000,
          cryptoCurrency: Currency.usdc,
        ),
        receiverAddress: 'receiverAddress',
        receiverBlockchain: Blockchain.arbitrum,
      ),
    ),
  ),
);

const dummyOrderId = 'ORDER_ID';
const dummyTx = StubSignedTx(dummyOrderId);
final dummyBigInt = BigInt.from(0);

final txSent = OutgoingDlnPaymentStatus.txSent(dummyTx, slot: dummyBigInt);
const success =
    OutgoingDlnPaymentStatus.success(dummyTx, orderId: dummyOrderId);
const txFailure = OutgoingDlnPaymentStatus.txFailure(
  reason: TxFailureReason.insufficientFunds,
);
const fulfilled =
    OutgoingDlnPaymentStatus.fulfilled(dummyTx, orderId: dummyOrderId);
const unfulfilled =
    OutgoingDlnPaymentStatus.unfulfilled(dummyTx, orderId: dummyOrderId);

extension on OutgoingDlnPaymentStatus {
  String get name => this.map(
        txCreated: always('Tx Created'),
        txSent: always('Tx Sent'),
        success: always('Success'),
        txFailure: always('Tx Failure'),
        fulfilled: always('Fulfilled'),
        unfulfilled: always('Unfulfilled'),
      );
}
