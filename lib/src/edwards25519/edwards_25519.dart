library edwards25519;

/**
 * Most of the code in this library was taken from
 *
 * https://github.com/cryptography-cafe/curve25519-elisabeth
 *
 * and correctly converted to dart by the crypto-please
 * team.
 *
 * Please not that in no way this pretends to be a complete
 * implementation. We only extracted the needed parts and
 * used the bits that we need to validate ed25519 public keys
 * by confirming that they are points of the elliptic curve
 */
export 'compressed_edwards_y.dart' show CompressedEdwardsY;
export 'edwards_point.dart' show EdwardsPoint;
