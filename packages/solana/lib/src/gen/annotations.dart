class SolanaRpcClient {
  const SolanaRpcClient();
}

class SolanaRpcRequest {
  const SolanaRpcRequest();
}

class ResponseEncoding {
  const ResponseEncoding(this.encoding);

  final String encoding;
}

const jsonParsed = ResponseEncoding('jsonParsed');
