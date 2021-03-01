class TxMeta {
  TxMeta(dynamic meta)
      : err = meta['err'],
        fee = meta['fee'];

  final dynamic err;
  final int fee;
  // TODO add other fields
}
