import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana_mobile_wallet/solana_mobile_wallet.dart';

part 'remote_request.freezed.dart';

@freezed
class RemoteRequest with _$RemoteRequest {
  const factory RemoteRequest.authorizeDapp({
    required AuthorizeRequest request,
  }) = AuthorizeDapp;

  const factory RemoteRequest.reauthorizeDapp({
    required ReauthorizeRequest request,
  }) = ReauthorizeDapp;

  const factory RemoteRequest.signPayloads({
    required SignPayloadsRequest request,
  }) = SignPayloads;

  const factory RemoteRequest.signTransactionsForSending({
    required SignAndSendTransactionsRequest request,
  }) = SignTransactionsForSending;

  const factory RemoteRequest.sendTransactions({
    required SignAndSendTransactionsRequest request,
    required List<Uint8List> signatures,
    required List<Uint8List> signedTransactions,
  }) = SendTransactions;
}
