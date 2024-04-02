import 'package:borsh_annotation/borsh_annotation.dart';

part 'collection_details.g.dart';

@BorshSerializable()
class CollectionDetails with _$CollectionDetails {
  factory CollectionDetails({
    @BU64() required BigInt size,
  }) = _CollectionDetails;

  const CollectionDetails._();

  factory CollectionDetails.fromBorsh(Uint8List data) =>
      _$CollectionDetailsFromBorsh(data);
}
