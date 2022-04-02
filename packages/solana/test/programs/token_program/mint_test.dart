import 'package:solana/solana.dart';
import 'package:solana/src/programs/token_program/mint.dart';
import 'package:test/test.dart';

void main() {
  final client = RpcClient('https://api.devnet.solana.com');

  test('getMint', () async {
    final mint = await getMint(
      client: client,
      address: Ed25519HDPublicKey.fromBase58(
        'Gh9ZwEmdLJ8DscKNTkTqPbNwLNNBjuSzaG9Vp2KGtKJr',
      ),
    );
    final expected = Mint(
      address: Ed25519HDPublicKey.fromBase58(
        'Gh9ZwEmdLJ8DscKNTkTqPbNwLNNBjuSzaG9Vp2KGtKJr',
      ),
      supply: BigInt.from(44777805549199974),
      decimals: 6,
      isInitialized: true,
      mintAuthority: Ed25519HDPublicKey.fromBase58(
        'Gh9ZwEmdLJ8DscKNTkTqPbNwLNNBjuSzaG9Vp2KGtKJr',
      ),
    );

    expect(mint, expected);
  });
}
