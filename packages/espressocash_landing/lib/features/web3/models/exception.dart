import 'package:freezed_annotation/freezed_annotation.dart';

part 'exception.freezed.dart';

@freezed
sealed class Web3Exception with _$Web3Exception implements Exception {
  const factory Web3Exception.metaMaskNotInstalled() = MetaMaskNotInstalled;
  const factory Web3Exception.userRejected() = UserRejected;
  const factory Web3Exception.other() = OtherException;
}
