import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

void main() {
  _download();
}

FutureOr<void> _download() async {
  const path = 'lib/bl/tokens/solana.tokenlist.json';

  final response = await http.get(Uri.parse(_fileUrl));
  final file = File(path);

  await file.writeAsBytes(response.bodyBytes);
}

const _fileUrl =
    'https://raw.githubusercontent.com/solana-labs/token-list/main/src/tokens/solana.tokenlist.json';
