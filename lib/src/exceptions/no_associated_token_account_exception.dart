part of 'exceptions.dart';

class NoAssociatedTokenAccountException implements Exception {
  NoAssociatedTokenAccountException(this._account, this._mint);

  @override
  String toString() =>
      'there is no associated token account for address $_account and token $_mint';

  final String _account;
  final String _mint;
}
