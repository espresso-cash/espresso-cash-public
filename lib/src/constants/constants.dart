abstract class SystemProgram {
  SystemProgram._();

  static const id = '11111111111111111111111111111111';
}

abstract class Int32Bytes {
  Int32Bytes._();

  static const zero = [0, 0, 0, 0];
  static const one = [1, 0, 0, 0];
  static const two = [2, 0, 0, 0];
}

abstract class SystemProgramIndex {
  SystemProgramIndex._();

  static const createAccount = Int32Bytes.one;
  static const transfer = Int32Bytes.two;
}

abstract class TokenProgramIndex {
  TokenProgramIndex._();

  static const initializeMint = Int32Bytes.zero;
}

abstract class MemoProgram {
  MemoProgram._();

  static const id = 'MemoSq4gqABAXKb96qnH8TysNcWxMyWCqXgDLGmfcHr';
}

abstract class TokenProgram {
  TokenProgram._();

  static const id = 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA';
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
