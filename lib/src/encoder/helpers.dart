part of 'encoder.dart';

/// Compare accounts according to the following rules
///
/// Signer accounts go first, and within them writeable accounts
/// go first
///
/// Non-Signer accounts go after, and within them the writeable
/// accounts go first
int _accountComparator(AccountMeta a1, AccountMeta a2) {
  int score = 0;
  score += a1.isSigner ? -1 : 0;
  score += a2.isSigner ? 1 : 0;
  score += a1.isWriteable ? -1 : 0;
  score += a2.isWriteable ? 1 : 0;
  return score;
}
