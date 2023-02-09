import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/rpc/dto/account_data/account_data.dart';
import 'package:solana/src/rpc/dto/encoding.dart';

extension EncoderExt on RpcClient {
  Future<AddressLookupTableAccount> getAddressLookupTable(
    Ed25519HDPublicKey account,
  ) async {
    final accountInfo = await getAccountInfo(
      account.toBase58(),
      encoding: Encoding.base64,
    );

    if (accountInfo == null) {
      throw const FormatException('Account not found');
    }

    final data = accountInfo.data;
    if (data == null) {
      throw const FormatException('Account data is null');
    }

    final input = ByteArray((data as BinaryAccountData).data);
    final decode = AddressLookupTableAccount.deserialize(input);

    return AddressLookupTableAccount(key: account, state: decode);
  }

  Future<List<AddressLookupTableAccount>> getAddressLookUpTableAccounts(
    List<MessageAddressTableLookup> addressTableLookups,
  ) async =>
      Future.wait(
        addressTableLookups
            .map((lookup) async => getAddressLookupTable(lookup.accountKey))
            .toList(),
      );

  Future<Message> getMessageFromEncodedTx(String encodedTx) async {
    final tx = SignedTx.decode(encodedTx);

    return tx.compiledMessage.map(
      legacy: (_) async => tx.decompileMessage(),
      v0: (compiledMessage) async {
        final addressTableLookups = compiledMessage.addressTableLookups;

        final lookUpTables =
            await getAddressLookUpTableAccounts(addressTableLookups);

        return tx.decompileMessage(addressLookupTableAccounts: lookUpTables);
      },
    );
  }
}
