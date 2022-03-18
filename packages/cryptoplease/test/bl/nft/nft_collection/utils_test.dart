import 'package:cryptoplease/bl/nft/nft_collection/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solana/dto.dart';

void main() {
  test('Parses correct SplTokenAccountDataInfo', () {
    const info = SplTokenAccountDataInfo(
      tokenAmount: TokenAmount(
        amount: '1',
        decimals: 0,
        uiAmountString: '1',
      ),
      state: 'state',
      isNative: true,
      mint: 'mint',
      owner: 'owner',
    );
    const account = ProgramAccount(
      account: Account(
        lamports: 100,
        owner: 'owner',
        data: ParsedAccountData.splToken(
          SplTokenProgramAccountData.account(
            type: 'type',
            info: info,
          ),
        ),
        executable: false,
        rentEpoch: 0,
      ),
      pubkey: 'pubkey',
    );

    expect(account.toNftAccountDataOrNull(), info);
  });

  test('Returns null for incorrect SplTokenAccountDataInfo', () {
    const info = SplTokenAccountDataInfo(
      tokenAmount: TokenAmount(
        amount: '1',
        decimals: 1,
        uiAmountString: '1',
      ),
      state: 'state',
      isNative: true,
      mint: 'mint',
      owner: 'owner',
    );
    const account = ProgramAccount(
      account: Account(
        lamports: 100,
        owner: 'owner',
        data: ParsedAccountData.splToken(
          SplTokenProgramAccountData.account(
            type: 'type',
            info: info,
          ),
        ),
        executable: false,
        rentEpoch: 0,
      ),
      pubkey: 'pubkey',
    );

    expect(account.toNftAccountDataOrNull(), null);
  });
}
