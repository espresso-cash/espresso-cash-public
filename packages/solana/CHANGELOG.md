## 0.13.3+1

 - **FIX**: Add missing `mint` value to the SPL tokens transfer info (#108).

## 0.13.3

 - **FEAT**: Export `base58encode` (#106).

## 0.13.2

 - **REFACTOR**: Update the polling timeout for `waitForSignatureStatus()` (#101).
 - **REFACTOR**: Organize some commonly used types (#88).
 - **FIX**: Allow program as null for unsupported instruction (#83).
 - **FEAT**: Add Ed25519HDKeyPair from private key bytes constructor (#99).
 - **FEAT**: Add support for checked transfer SPL and SOL (#98).
 - **FEAT**: Implement subscription API (#89).

## 0.13.1

 - **FEAT**: Export SignedTx (#78).

## 0.13.0

> Note: This release has breaking changes.

 - **BREAKING** **FEAT**: Make TransactionSignature typedef (#76).

## 0.12.0+1

 - **TEST**: Add a test for sending SPL and SOL in a single transaction (#73).
 - **FIX**: Throw TransactionException in waitForSignatureStatus.

## 0.12.0

> Note: This release has breaking changes.

 - **FIX**: Remove commitment from `simulateTransaction` and `sendTransaction`. (#67).
 - **BREAKING** **FIX**: Use commitment when waiting for signature status (#69).

## 0.11.0

> Note: This release has breaking changes.

 - **BREAKING** **FEAT**: Create a separate sign method and split waiting for signature statuses from sending transactions (#64).

## 0.10.0+2

 - Update a dependency to the latest release.

## 0.10.0+1

 - **FIX**: Update tests to reflect some API changes (#59).
 - **CHORE**: Splits borsh package (#60).
 - **CHORE**: publish packages.
 - **CHORE**: publish packages.

## 0.10.0

> Note: This release has breaking changes.

 - **FIX**: Update tests to reflect some API changes (#59).
 - **FEAT**: Support anchor generated programs (#42).
 - **CHORE**: Add an example and a test for sending SPL with a fee payer (#55).
 - **CHORE**: Update readme (#49).
 - **CHORE**: Restructure packages (#44).
 - **BREAKING** **FIX**: Remove explicit tokens adding (#52).
 - **BREAKING** **FEAT**: Implement `getTokenAccountsByOwner` rpc method (#53).

## 0.9.0+1

 - **FIX**: Add required exports (#41).
 - **FIX**: Add readonly signers once (#40).

## 0.9.0

> Note: This release has breaking changes.

 - **FEAT**: Derive associated token account address. (#34).
 - **BREAKING** **FEAT**: Add spl token support and an API to write arbitrary transactions  (#35).
 - **BREAKING** **FEAT**: Memo program implementation (#31).

## 0.8.0

> Note: This release has breaking changes.

- **FEAT**: Add commitment parameter to transactions methods (#28).
- **BREAKING** **FIX**: Correct the derivation method (#27)


## 0.7.0

> Note: This release has breaking changes.

 - **STYLE**: Fix formatting.
 - **DOCS**: Update documentation.
 - **BREAKING** **FEAT**: Add `commitment` parameters to Solana client.

## 0.6.0

> Note: This release has breaking changes.

 - **FEAT**: Add a function to validate solana addresses (#22).
 - **BREAKING** **FEAT**: Separate signing and sending transaction (#23).

## 0.5.1

 - **FEAT**: Add accounts support (#19).

## 0.5.0

> Note: This release has breaking changes.

 - **BREAKING** **FIX**: Update errors base classes.

## 0.4.2+1

 - **FIX**: Fix instruction parsing.

## 0.4.2

 - **FEAT**: Add UnknownTx.

## 0.4.1

 - **FEAT**: Update ConfirmedTransaction model.

## 0.4.0+1

 - **REFACTOR**: Fix analyzer issue.
 - **CHORE**: Update dependencies.

## 0.4.0

> Note: This release has breaking changes.

 - **CHORE**: Update .gitignore.
 - **CHORE**: Fix warnings.
 - **BREAKING** **FEAT**: Migrate to nullsafety.

## 0.3.1

 - Bump "solana" to `0.3.1`.

## 0.3.0

> Note: This release has breaking changes.

 - **BREAKING** **CHORE**: Rename library to solana.

## 0.2.0

 - Bump "solana_dart" to `0.2.0`.

## 0.1.0

> Note: This release has breaking changes.

- **BREAKING** **REFACTOR**: Update models.

# 0.0.5

- Export some needed types for library users
- Fix casing of global constants

# 0.0.4

- Use a better technique for json deserialization

# 0.0.3

- Added the ability to list recent transactions
- General cleanup
- Generated documentation

## 0.0.2

- Added a method to wait for a specific signature status or a time out
- Fixed return value of a couple of methods

## 0.0.1

- Call some rpc methods: `getBalance`, `getAccountInfo`, `requestAirdrop`
- Simulate sending transfer transactions from pubkey A to pubkey B
- Sending transfer transactions from pubkey A to pubkey B
