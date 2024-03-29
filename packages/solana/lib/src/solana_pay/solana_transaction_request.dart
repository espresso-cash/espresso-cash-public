import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:solana/solana.dart';
import 'package:solana/solana_pay.dart';
import 'package:solana/src/solana_pay/constants.dart';

part 'solana_transaction_request.freezed.dart';

@freezed
class SolanaTransactionRequest with _$SolanaTransactionRequest {
  const factory SolanaTransactionRequest({
    required Uri link,
    String? label,
    String? message,
  }) = _SolanaTransactionRequest;

  const SolanaTransactionRequest._();

  factory SolanaTransactionRequest.parse(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      throw const ParseUrlException('Link invalid');
    }

    if (uri.scheme != 'solana') {
      throw const ParseUrlException('Protocol invalid');
    }

    final link = Uri.tryParse(Uri.decodeComponent(uri.path));
    if (link == null) {
      throw const ParseUrlException('Link invalid');
    }

    if (link.scheme != 'https') {
      throw const ParseUrlException('Protocol invalid');
    }

    final String? label = uri.queryParameters['label'];
    final String? message = uri.queryParameters['message'];

    return SolanaTransactionRequest(
      link: link,
      label: label,
      message: message,
    );
  }

  static SolanaTransactionRequest? tryParse(String url) {
    try {
      return SolanaTransactionRequest.parse(url);
    } on ParseUrlException {
      return null;
    }
  }

  String toUrl() {
    final pathname = link.query.isNotEmpty
        ? Uri.encodeComponent(link.toString().replaceFirst('/?', '?'))
        : link.toString().replaceFirst(RegExp(r'\/$'), '');

    final queryParameters = <String, dynamic>{
      if (label != null) 'label': label,
      if (message != null) 'message': message,
    };

    return Uri(
      scheme: solanaPayScheme,
      path: pathname,
      queryParameters: queryParameters.isNotEmpty
          ? Map<String, dynamic>.fromEntries(queryParameters.entries)
          : null,
    ).toString();
  }

  Future<TransactionRequestInfo> get() async {
    final response = await http.get(link);

    if (response.statusCode != 200) {
      throw HttpException(response.statusCode, response.body);
    }

    return TransactionRequestInfo.fromJson(
      json.decode(response.body) as Map<String, dynamic>,
    );
  }

  Future<TransactionRequestResponse> post({required String account}) async {
    final response = await http.post(
      link,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'account': account}),
    );

    if (response.statusCode != 200) {
      throw HttpException(response.statusCode, response.body);
    }

    return TransactionRequestResponse.fromJson(
      json.decode(response.body) as Map<String, dynamic>,
    );
  }
}
