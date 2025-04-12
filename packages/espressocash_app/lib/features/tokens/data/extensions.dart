import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dfunc/dfunc.dart';

import '../../../data/db/db.dart';
import '../token.dart';

extension TokenRowsExt on TokenRow {
  Token toModel() => Token(
    address: address,
    name: name,
    symbol: symbol,
    decimals: decimals,
    logoURI: logoURI,
    chainId: chainId,
    isStablecoin: isStablecoin,
  );
}

extension ParseTag on String {
  bool hasStablecoinTag() {
    if (this.isEmpty) return false;

    return replaceAll('[', '').replaceAll(']', '').split(',').any((e) => e == 'stablecoin');
  }
}

extension ToTokenRows on Stream<String> {
  Stream<List<TokenRow>> transformToTokenRows() => transform(
    StreamTransformer<String, List<TokenRow>>.fromHandlers(
      handleData: (data, sink) => _parseRow(data).let((rows) => sink.add(rows)),
    ),
  );

  List<TokenRow> _parseRow(String data) {
    final List<TokenRow> rows = [];
    final lines = data.split('\n');
    bool isFirstLine = true;
    for (final line in lines) {
      if (isFirstLine) {
        isFirstLine = false;
        continue;
      }
      final values = line.split(',');
      if (values.length >= 8) {
        rows.add(
          TokenRow(
            address: values[0],
            chainId: int.parse(values[1]),
            symbol: values[2],
            name: values[3],
            decimals: int.parse(values[4]),
            logoURI: values[5],
            isStablecoin: values[6].hasStablecoinTag(),
          ),
        );
      }
    }

    return rows;
  }
}

extension DecodeFile on Stream<List<int>> {
  Stream<List<TokenRow>> decodeFile() =>
      transform(gzip.decoder).transform(utf8.decoder).transformToTokenRows();
}
