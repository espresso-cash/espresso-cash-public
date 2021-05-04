import 'package:bip39/bip39.dart' as bip39;
import 'package:cryptography/cryptography.dart' as crypto;
import 'package:solana/solana.dart';
import 'package:solana/src/base58/base58.dart' as base58;
import 'package:solana/src/solana_serializable/signed_transaction.dart';
import 'package:solana/src/types/hd_key_pair.dart';

import 'solana_serializable/solana_serializable.dart';

/// Signs transactions to be sent to a Solana Cluster
class SolanaWallet {
  SolanaWallet._fromKeyPair(
    this._keyPair, {
    required this.address,
  });

  /// Creates and initializes a new SolanaWallet for the given bip39
  /// [mnemonic] string of 12 words.
  ///
  /// Multiple accounts can be attached to the same seed by using the [account]
  /// parameter as index
  static Future<SolanaWallet> fromMnemonic(
    String mnemonic, {
    int account = 0,
  }) async {
    // Create the seed
    final List<int> seedBytes = bip39.mnemonicToSeed(mnemonic);
    final crypto.KeyPair keyPair = await _deriveKeyPair(seedBytes, account);
    final crypto.PublicKey publicKey = await keyPair.extractPublicKey();
    if (publicKey is crypto.SimplePublicKey) {
      // Finally, create a new wallet
      return SolanaWallet._fromKeyPair(
        keyPair,
        address: base58.encode(publicKey.bytes),
      );
    } else {
      throw Exception('could not build a key pair');
    }
  }

  static final _ed25519 = crypto.Ed25519();
  final crypto.KeyPair _keyPair;

  /// The address or public key of this wallet
  final String address;

  static String _getHDPath(int account) => "m/44'/501'/${account - 1}'";

  static Future<crypto.KeyPair> _deriveKeyPair(
    List<int> rawSeed,
    int? account,
  ) async {
    final List<int> seed = rawSeed.sublist(0, 32);
    if (account == null || account == 0) {
      return _ed25519.newKeyPairFromSeed(seed);
    } else {
      return HDKeyPair.fromSeed(seed, _getHDPath(account));
    }
  }

  /// Returns a Future that resolves to the result of signing
  /// [data] with the private key held internally by a given
  /// instance
  Future<crypto.Signature> sign(List<int> data) =>
      _ed25519.sign(data, keyPair: _keyPair);

  /// Sign a solana program message
  Future<SignedTx> signMessage(Message message) async {
    final List<int> serializedMessage = message.serialize();
    final signature = Signature.from(await sign(serializedMessage));

    return SignedTx(
      signatures: CompactArray.fromList([signature]),
      message: message,
    );
  }

  /// Create a transfer of [lamports] from this wallet to
  /// [destination] transaction and sign it
  Future<SignedTx> buildAndSignTransferTx({
    required String destination,
    required int lamports,
    required Blockhash recentBlockhash,
  }) {
    final transferTx = TransferTx(
      source: address,
      destination: destination,
      lamports: lamports,
    );

    return signMessage(
      transferTx.compile(recentBlockhash),
    );
  }
}
