import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:solana/anchor.dart';
import 'package:solana/dto.dart';

part 'basic1.g.dart';

class Basic1DataAccount implements AnchorAccount {
  const Basic1DataAccount._({
    required this.discriminator,
    required this.data,
  });

  factory Basic1DataAccount._fromBinary(
    List<int> bytes,
  ) {
    final accountData = _AccountData.fromBorsh(Uint8List.fromList(bytes));

    return Basic1DataAccount._(
      discriminator: accountData.discriminator,
      data: accountData.data.toInt(),
    );
  }

  factory Basic1DataAccount.fromAccountData(AccountData accountData) {
    if (accountData is BinaryAccountData) {
      return Basic1DataAccount._fromBinary(accountData.data);
    }

    throw const FormatException('invalid account data found');
  }

  @override
  final List<int> discriminator;

  final int data;
}

@BorshSerializable()
class _AccountData with _$_AccountData {
  factory _AccountData({
    @BFixedArray(8, BU8()) required List<int> discriminator,
    @BU64() required BigInt data,
  }) = __AccountData;

  const _AccountData._();

  factory _AccountData.fromBorsh(Uint8List data) =>
      _$_AccountDataFromBorsh(data);
}

@BorshSerializable()
class Basic1Arguments with _$Basic1Arguments {
  factory Basic1Arguments({
    @BU64() required BigInt data,
  }) = _Basic1Arguments;

  const Basic1Arguments._();

  factory Basic1Arguments.fromBorsh(Uint8List data) =>
      _$Basic1ArgumentsFromBorsh(data);
}
