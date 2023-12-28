class WalletContractV1 {
  static const packageSeedVault = 'com.solanamobile.seedvaultimpl';

  static const permissionAccessSeedVault =
      'com.solanamobile.seedvault.ACCESS_SEED_VAULT';

  static const permissionSeedVaultImpl =
      'com.solanamobile.seedvault.SEED_VAULT_IMPL';

  static const authorityWallet = 'com.solanamobile.seedvault.wallet.v1';

  static const actionAuthorizeSeedAccess =
      '$authorityWallet.ACTION_AUTHORIZE_SEED_ACCESS';

  static const actionSignTransaction =
      '$authorityWallet.ACTION_SIGN_TRANSACTION';

  static const actionSignMessage = '$authorityWallet.ACTION_SIGN_MESSAGE';

  static const actionGetPublicKey = '$authorityWallet.ACTION_GET_PUBLIC_KEY';

  static const actionCreateSeed = '$authorityWallet.ACTION_CREATE_SEED';

  static const actionImportSeed = '$authorityWallet.ACTION_IMPORT_SEED';

  static const resultUnspecifiedError = _Activity.resultFirstUser + 1000;

  static const resultInvalidAuthToken = _Activity.resultFirstUser + 1001;

  static const resultInvalidPayload = _Activity.resultFirstUser + 1002;

  static const resultAuthenticationFailed = _Activity.resultFirstUser + 1003;

  static const resultNoAvailableSeeds = _Activity.resultFirstUser + 1004;

  static const resultInvalidPurpose = _Activity.resultFirstUser + 1005;

  static const resultInvalidDerivationPath = _Activity.resultFirstUser + 1006;

  static const resultImplementationLimitExceeded =
      _Activity.resultFirstUser + 1007;

  static const extraPurpose = 'Purpose';

  static const extraAuthToken = 'AuthToken';

  static const extraSigningRequest = 'SigningRequest';

  static const extraSigningResponse = 'SigningResponse';

  static const extraDerivationPath = 'DerivationPath';

  static const extraPublicKey = 'PublicKey';

  static const purposeSignSolanaTransaction = 0;

  static const bip32UriScheme = 'bip32';

  static const bip44UriScheme = 'bip44';

  static const bip32UriMaxDepth = 20;

  static const bip32UriMasterKeyIndicator = 'm';

  static const bipUriHardenedIndexIdentifier = "'";

  static const minSupportedSigningRequests = 3;

  static const minSupportedRequestedSignatures = 3;

  static const minSupportedRequestedPublicKeys = 10;

  static const authorityWalletProvider = '$authorityWallet.walletprovider';

  final Uri walletProviderContentUriBase =
      Uri.parse('content://$authorityWalletProvider');

  static const authorizedSeedsTable = 'authorizedseeds';

  Uri get authorizedSeedsContentUri =>
      walletProviderContentUriBase.resolve(authorizedSeedsTable);

  static const authorizedSeedsMimeSubtype =
      'vnd.$authorityWalletProvider.$authorizedSeedsTable';

  static const authorizedSeedsAuthToken = _BaseColumns.id;

  static const authorizedSeedsAuthPurpose = 'AuthorizedSeeds_AuthPurpose';

  static const authorizedSeedsSeedName = 'AuthorizedSeeds_SeedName';

  static const authorizedSeedsAllColumns = [
    authorizedSeedsAuthToken,
    authorizedSeedsAuthPurpose,
    authorizedSeedsSeedName,
  ];

  static const unauthorizedSeedsTable = 'unauthorizedseeds';

  Uri get unauthorizedSeedsContentUri =>
      walletProviderContentUriBase.resolve(unauthorizedSeedsTable);

  static const unauthorizedSeedsMimeSubtype =
      'vnd.$authorityWalletProvider.$unauthorizedSeedsTable';

  static const unauthorizedSeedsAuthPurpose = _BaseColumns.id;

  static const unauthorizedSeedsHasUnauthorizedSeeds =
      'UnauthorizedSeeds_HasUnauthorizedSeeds';

  static const unauthorizedSeedsAllColumns = [
    unauthorizedSeedsAuthPurpose,
    unauthorizedSeedsHasUnauthorizedSeeds,
  ];

  static const accountsTable = 'accounts';

  Uri get accountsContentUri =>
      walletProviderContentUriBase.resolve(accountsTable);

  static const accountsMimeSubtype =
      'vnd.$authorityWalletProvider.$accountsTable';

  static const accountsAccountId = _BaseColumns.id;

  static const accountsBip32DerivationPath = 'Accounts_Bip32DerivationPath';

  static const accountsPublicKeyRaw = 'Accounts_PublicKeyRaw';

  static const accountsPublicKeyEncoded = 'Accounts_PublicKeyEncoded';

  static const accountsAccountName = 'Accounts_AccountName';

  static const accountsAccountIsUserWallet = 'Accounts_IsUserWallet';

  static const accountsAccountIsValid = 'Accounts_IsValid';

  static const accountsAllColumns = [
    accountsAccountId,
    accountsBip32DerivationPath,
    accountsPublicKeyRaw,
    accountsPublicKeyEncoded,
    accountsAccountName,
    accountsAccountIsUserWallet,
    accountsAccountIsValid,
  ];

  static const implementationLimitsTable = 'implementationlimits';

  Uri get implementationLimitsContentUri =>
      walletProviderContentUriBase.resolve(implementationLimitsTable);

  static const implementationLimitsMimeSubtype =
      'vnd.$authorityWalletProvider.$implementationLimitsTable';

  static const implementationLimitsAuthPurpose = _BaseColumns.id;

  static const implementationLimitsMaxSigningRequests = 'MaxSigningRequests';

  static const implementationLimitsMaxRequestedSignatures =
      'MaxRequestedSignatures';

  static const implementationLimitsMaxRequestedPublicKeys =
      'MaxRequestedPublicKeys';

  static const implementationLimitsAllColumns = [
    implementationLimitsAuthPurpose,
    implementationLimitsMaxSigningRequests,
    implementationLimitsMaxRequestedSignatures,
    implementationLimitsMaxRequestedPublicKeys,
  ];

  static const resolveBip32DerivationPathMethod = 'ResolveBipDerivationPath';

  static const extraResolvedBip32DerivationPath =
      'ResolveBipDerivationPath_ResolvedBip32DerivationPath';
}

class _BaseColumns {
  static const String id = '_id';
}

class _Activity {
  static const resultFirstUser = 1;
}
