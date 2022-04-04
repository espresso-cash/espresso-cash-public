import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/solana_pay/constants.dart';
import 'package:solana/src/solana_pay/exceptions.dart';

part 'solana_pay_request.freezed.dart';

@freezed
class SolanaPayRequest with _$SolanaPayRequest {
  const factory SolanaPayRequest({
    required Ed25519HDPublicKey recipient,
    Decimal? amount,
    Ed25519HDPublicKey? splToken,
    Iterable<Ed25519HDPublicKey>? reference,
    String? label,
    String? message,
    String? memo,
  }) = _SolanaPayRequest;

  const SolanaPayRequest._();

  factory SolanaPayRequest.parse(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      throw const ParseUrlException('Link invalid');
    }

    if (uri.scheme != 'solana') {
      throw const ParseUrlException('Protocol invalid');
    }

    final Ed25519HDPublicKey recipient;
    try {
      if (uri.path.isEmpty) {
        throw const ParseUrlException('Recipient missing');
      }
      recipient = Ed25519HDPublicKey.fromBase58(uri.path);
    } on Object {
      throw const ParseUrlException('Recipient invalid');
    }

    final Decimal? amount;
    final amountParam = uri.queryParameters['amount'];
    if (amountParam == null) {
      amount = null;
    } else {
      try {
        amount = Decimal.parse(amountParam);
      } on Object {
        throw const ParseUrlException('Amount invalid');
      }
    }

    final Ed25519HDPublicKey? splToken;
    final splTokenParam = uri.queryParameters['spl-token'];
    if (splTokenParam == null) {
      splToken = null;
    } else {
      try {
        splToken = Ed25519HDPublicKey.fromBase58(splTokenParam);
      } on Object {
        throw const ParseUrlException('Token invalid');
      }
    }

    final Iterable<Ed25519HDPublicKey>? reference;
    final referenceParam = uri.queryParametersAll['reference'];
    if (referenceParam == null) {
      reference = null;
    } else {
      try {
        reference = referenceParam.map(Ed25519HDPublicKey.fromBase58);
      } on Object {
        throw const ParseUrlException('Reference invalid');
      }
    }

    final String? label = uri.queryParameters['label'];
    final String? message = uri.queryParameters['message'];
    final String? memo = uri.queryParameters['memo'];

    return SolanaPayRequest(
      recipient: recipient,
      amount: amount,
      splToken: splToken,
      reference: reference,
      label: label,
      message: message,
      memo: memo,
    );
  }

  static SolanaPayRequest? tryParse(String url) {
    try {
      return SolanaPayRequest.parse(url);
    } on ParseUrlException {
      return null;
    }
  }

  String toUrl() {
    final queryParameters = <String, dynamic>{
      'amount': amount?.toString(),
      'spl-token': splToken?.toBase58(),
      'reference': reference?.map((r) => r.toBase58()).toList(),
      'label': label,
      'message': message,
      'memo': memo,
    };

    return Uri(
      scheme: solanaPayScheme,
      path: recipient.toBase58(),
      queryParameters: Map<String, dynamic>.fromEntries(
        queryParameters.entries.where((e) => e.value != null),
      ),
    ).toString().replaceAll('+', '%20');
  }
}
