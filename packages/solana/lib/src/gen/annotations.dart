class SolanaRpcClient {
  const SolanaRpcClient();
}

class SolanaRpcRequest {
  const SolanaRpcRequest();
}

class _ContextedResult {
  const _ContextedResult();
}

class ResponseEncoding {
  const ResponseEncoding(this.encoding);

  final String encoding;
}

const jsonParsed = ResponseEncoding('jsonParsed');
const contexted = _ContextedResult();
