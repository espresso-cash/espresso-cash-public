part of 'encoder.dart';

abstract class SystemProgram {
  SystemProgram._();

  static const id = '11111111111111111111111111111111';
  static const createAccount = [1, 0, 0, 0];
  static const transfer = [2, 0, 0, 0];
}

abstract class MemoProgram {
  MemoProgram._();

  static const id = 'MemoSq4gqABAXKb96qnH8TysNcWxMyWCqXgDLGmfcHr';
}

abstract class TokenProgram {
  TokenProgram._();

  static const id = 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA';
  static const initializeMint = [0];

  /// This is computed by adding the bytes in the following
  /// structure
  ///
  /// mintAuthorityOption:   int32 ( 4 bytes)
  /// mintAuthority:        PubKey (32 bytes)
  /// supply:                int64 ( 8 bytes)
  /// decimals:               int8 ( 1 bytes)
  /// isInitialized:          int8 ( 1 bytes)
  /// freezeAuthorityOption: int32 ( 4 bytes)
  /// freezeAuthority:      PubKey (32 bytes)
  static const neededMintAccountSpace = 82;
}

abstract class Sysvar {
  Sysvar._();

  static const clock = 'SysvarC1ock11111111111111111111111111111111';
  static const recentBlockHashes =
      'SysvarRecentB1ockHashes11111111111111111111';
  static const rent = 'SysvarRent111111111111111111111111111111111';
  static const rewards = 'SysvarRewards111111111111111111111111111111';
  static const stakeHistory = 'SysvarStakeHistory1111111111111111111111111';
  static const instructions = 'Sysvar1nstructions1111111111111111111111111';
}

abstract class AssociatedTokenAccountProgram {
  AssociatedTokenAccountProgram._();

  static const id = 'ATokenGPvbdGVxr1b2hvZbsiqW5xWH25efTNsLJA8knL';
}
