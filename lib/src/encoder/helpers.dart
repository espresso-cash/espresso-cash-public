part of 'encoder.dart';

/// Compare accounts according to the following rules
///
/// Signer accounts go first, and within them writeable accounts
/// go first
///
/// Non-Signer accounts go after, and within them the writeable
/// accounts go first
int _accountComparator(AccountMeta a1, AccountMeta a2) {
  // Signers go first so it weighs more than being writeable
  // we arbitrarily assign 2 for being a signer and 1 for being
  // writeable.
  int score = 0;
  score += a1.isSigner ? -2 : 0;
  score += a2.isSigner ? 2 : 0;
  score += a1.isWriteable ? -1 : 0;
  score += a2.isWriteable ? 1 : 0;
  return score;
}
