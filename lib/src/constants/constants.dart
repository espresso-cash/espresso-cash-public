class SystemProgram {
  static const id = '11111111111111111111111111111111';
}

class Int32Bytes {
  static const zero = [0, 0, 0, 0];
  static const one = [1, 0, 0, 0];
  static const two = [2, 0, 0, 0];
}

class SystemProgramIndex {
  static const createAccount = Int32Bytes.one;
  static const transfer = Int32Bytes.two;
}

class TokenProgramIndex {
  static const initializeMint = Int32Bytes.zero;
}

class MemoProgram {
  static const id = 'MemoSq4gqABAXKb96qnH8TysNcWxMyWCqXgDLGmfcHr';
}

class TokenProgram {
  static const id = 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA';
}

class Sysvar {
  static const clock = 'SysvarC1ock11111111111111111111111111111111';
  static const recentBlockHashes =
      'SysvarRecentB1ockHashes11111111111111111111';
  static const rent = 'SysvarRent111111111111111111111111111111111';
  static const rewards = 'SysvarRewards111111111111111111111111111111';
  static const stakeHistory = 'SysvarStakeHistory1111111111111111111111111';
  static const instructions = 'Sysvar1nstructions1111111111111111111111111';
}

class AssociatedTokenAccountProgram {
  static const id = 'ATokenGPvbdGVxr1b2hvZbsiqW5xWH25efTNsLJA8knL';
}
