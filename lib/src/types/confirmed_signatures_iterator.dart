import 'package:solana_dart/src/types/confirmed_signature.dart';

class ConfirmedSignatureIterator extends Iterator<ConfirmedSignature> {
  ConfirmedSignatureIterator(this._list);

  int currentIndex = 0;
  final List<ConfirmedSignature> _list;

  @override
  get current {
    return _list[currentIndex];
  }

  @override
  bool moveNext() {
    if (currentIndex < _list.length) {
      currentIndex += 1;
      return true;
    } else {
      return false;
    }
  }
}
