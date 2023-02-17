import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:solana/anchor.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/borsh_ext.dart';

part 'models.g.dart';

class EscrowDataAccount implements AnchorAccount {
  const EscrowDataAccount._({
    required this.discriminator,
    required this.vaultTokenAccount,
    required this.status,
    required this.senderAccount,
    required this.senderTokenAccount,
    required this.depositorAccount,
  });

  factory EscrowDataAccount._fromBinary(
    List<int> bytes,
  ) {
    final accountData =
        _EscrowDataAccount.fromBorsh(Uint8List.fromList(bytes.sublist(8)));

    return EscrowDataAccount._(
      discriminator: bytes.sublist(0, 8),
      senderAccount: accountData.senderAccount,
      senderTokenAccount: accountData.senderTokenAccount,
      depositorAccount: accountData.depositorAccount,
      vaultTokenAccount: accountData.vaultTokenAccount,
      status: EscrowStatus.values[accountData.status],
    );
  }

  factory EscrowDataAccount.fromAccountData(AccountData accountData) {
    if (accountData is BinaryAccountData) {
      return EscrowDataAccount._fromBinary(accountData.data);
    } else {
      throw const FormatException('invalid account data found');
    }
  }

  @override
  final List<int> discriminator;

  final Ed25519HDPublicKey senderAccount;
  final Ed25519HDPublicKey vaultTokenAccount;
  final Ed25519HDPublicKey senderTokenAccount;
  final Ed25519HDPublicKey depositorAccount;
  final EscrowStatus status;
}

@BorshSerializable()
class _EscrowDataAccount with _$_EscrowDataAccount {
  factory _EscrowDataAccount({
    @BPublicKey() required Ed25519HDPublicKey senderAccount,
    @BPublicKey() required Ed25519HDPublicKey vaultTokenAccount,
    @BPublicKey() required Ed25519HDPublicKey senderTokenAccount,
    @BPublicKey() required Ed25519HDPublicKey depositorAccount,
    @BU8() required int status,
  }) = __EscrowDataAccount;

  _EscrowDataAccount._();

  factory _EscrowDataAccount.fromBorsh(Uint8List data) =>
      _$_EscrowDataAccountFromBorsh(data);
}

enum EscrowStatus {
  pending,
  canceled,
  completed;
}

@BorshSerializable()
class EscrowArgument with _$EscrowArgument {
  factory EscrowArgument({
    @BU64() required BigInt amount,
  }) = _EscrowArgument;

  EscrowArgument._();

  factory EscrowArgument.fromBorsh(Uint8List data) =>
      _$EscrowArgumentFromBorsh(data);
}
