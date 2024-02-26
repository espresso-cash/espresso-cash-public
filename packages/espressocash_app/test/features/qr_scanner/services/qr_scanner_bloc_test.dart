import 'package:bloc_test/bloc_test.dart';
import 'package:espressocash_app/features/qr_scanner/models/qr_address_data.dart';
import 'package:espressocash_app/features/qr_scanner/models/qr_scanner_request.dart';
import 'package:espressocash_app/features/qr_scanner/services/qr_scanner_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solana/solana.dart';

void main() {
  late final String sampleAddress;

  setUpAll(() async {
    sampleAddress = (await Ed25519HDKeyPair.random()).address;
  });

  group('QrScannerBloc tests:', () {
    blocTest<QrScannerBloc, QrScannerState>(
      'bloc can be correctly initialized',
      build: QrScannerBloc.new,
      act: (bloc) => bloc.add(const QrScannerEvent.initialized()),
      expect: () => [const QrScannerState.initial()],
    );

    blocTest<QrScannerBloc, QrScannerState>(
      'solana pay QR code leads to done state',
      build: QrScannerBloc.new,
      act: (bloc) => bloc.add(
        QrScannerEvent.received(
          _buildSolanaPayURI(recipientAddress: sampleAddress),
        ),
      ),
      expect: () => [isA<QrScannerDoneState>()],
    );

    blocTest<QrScannerBloc, QrScannerState>(
      'simple address qr scanned',
      build: QrScannerBloc.new,
      act: (bloc) => bloc.add(QrScannerEvent.received(sampleAddress)),
      expect: () => [
        QrScannerState.done(
          QrScannerRequest.address(
            QrAddressDataSolana(
              address: Ed25519HDPublicKey.fromBase58(sampleAddress),
            ),
          ),
        ),
      ],
    );
  });
}

String _buildSolanaPayURI({
  required String recipientAddress,
  String? splToken,
  String? reference,
  double? amount,
}) {
  final Iterable<String> values = <String, String?>{
    'spl-token': splToken,
    'reference': reference,
    'amount': amount?.toString(),
  }
      .entries
      .where((entry) => entry.value != null)
      .map((entry) => '${entry.key}=${entry.value}');

  return 'solana:$recipientAddress?${values.join('&')}';
}
