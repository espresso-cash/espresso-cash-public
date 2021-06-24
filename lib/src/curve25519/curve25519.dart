library curve25519;

part 'completed_point.dart';
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
part 'compressed_edwards_y.dart';
part 'edwards_point.dart';
part 'extensions.dart';
part 'field_element.dart';
part 'projective_point.dart';
