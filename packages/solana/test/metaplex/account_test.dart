import 'package:solana/solana.dart';
import 'package:solana/src/metaplex/accounts/collection_details.dart';
import 'package:solana/src/metaplex/accounts/creator.dart';
import 'package:solana/src/metaplex/accounts/on_chain_collection.dart';
import 'package:solana/src/metaplex/accounts/uses.dart';
import 'package:test/test.dart';

void main() {
  group('CollectionDetails', () {
    test('can be serialized and deserialized', () {
      final details = CollectionDetails(size: BigInt.from(123456789));

      final serialized = details.toBorsh();
      final deserialized = CollectionDetails.fromBorsh(serialized);

      expect(deserialized.size, equals(details.size));
    });
  });

  group('Creator', () {
    test('can be serialized and deserialized', () async {
      final account = await Ed25519HDKeyPair.random();

      final creator = Creator(
        address: account.publicKey,
        verified: true,
        share: 50,
      );

      final serialized = creator.toBorsh();
      final deserialized = Creator.fromBorsh(serialized);

      expect(deserialized.address, equals(creator.address));
      expect(deserialized.verified, equals(creator.verified));
      expect(deserialized.share, equals(creator.share));
    });
  });

  group('OnChainCollection', () {
    test('can be serialized and deserialized', () async {
      final account = await Ed25519HDKeyPair.random();

      final collection = OnChainCollection(
        verified: true,
        key: account.publicKey,
      );

      final serialized = collection.toBorsh();
      final deserialized = OnChainCollection.fromBorsh(serialized);

      expect(deserialized.verified, equals(collection.verified));
      expect(deserialized.key, equals(collection.key));
    });
  });

  group('Uses', () {
    test('can be serialized and deserialized', () {
      final uses = Uses(
        useMethod: 1,
        remaining: BigInt.from(100),
        total: BigInt.from(200),
      );

      final serialized = uses.toBorsh();
      final deserialized = Uses.fromBorsh(serialized);

      expect(deserialized.useMethod, equals(uses.useMethod));
      expect(deserialized.remaining, equals(uses.remaining));
      expect(deserialized.total, equals(uses.total));
    });
  });
}
