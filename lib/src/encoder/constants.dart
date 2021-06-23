part of 'encoder.dart';

abstract class SystemProgram {
  SystemProgram._();

  static const id = '11111111111111111111111111111111';
  static const createAccount = [0, 0, 0, 0];
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
  static const initializeAccount = [1];
  static const mintTo = [7];

  // This is computed by adding the bytes in the following
  // structure
  //
  // mintAuthorityOption:   int32 ( 4 bytes)
  // mintAuthority:        PubKey (32 bytes)
  // supply:                int64 ( 8 bytes)
  // decimals:               byte ( 1 bytes)
  // isInitialized:          byte ( 1 bytes)
  // freezeAuthorityOption: int32 ( 4 bytes)
  // freezeAuthority:      PubKey (32 bytes)
  static const neededMintAccountSpace = 82;

  // This is computed by adding the bytes in the following
  // structure
  //
  // mint:                 PubKey (32 bytes),
  // owner:                PubKey (32 bytes),
  // amount:               uint64 ( 8 bytes),
  // delegateOption:       uint32 ( 4 bytes),
  // delegate:             PubKey (32 bytes),
  // state:                byte   ( 1 bytes),
  // isNativeOption:       uint32 ( 4 bytes),
  // isNative:             uint64 ( 8 bytes),
  // delegatedAmount:      uint64 ( 8 bytes),
  // closeAuthorityOption: uint32 ( 4 bytes),
  // closeAuthority:       PubKey (32 bytes),
  static const neededAccountSpace = 165;
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
