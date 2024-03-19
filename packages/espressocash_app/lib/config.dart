import 'package:espressocash_api/espressocash_api.dart';

// If 'PROD' is provided with the value "true" to the dart
// defines, then we mostly use the default values.

const isProd = bool.fromEnvironment('PROD');

const currentChainId = isProd ? _mainNetChainId : _devNetChainId;

const apiCluster = isProd ? Cluster.mainnet : Cluster.devnet;

// Environment dependent constants

const solanaRpcUrl = String.fromEnvironment(
  'SOLANA_RPC_URL',
  defaultValue: 'https://$_solanaHost',
);

const solanaWebSocketUrl = String.fromEnvironment(
  'SOLANA_WEBSOCKET_URL',
  defaultValue: 'wss://$_solanaHost',
);

// Environment independent constants

const twitterUrl = 'https://twitter.com/espresso_cash';

const faqUrl = 'https://www.espressocash.com/docs/intro/';

const sentryDsn = String.fromEnvironment('SENTRY_DSN', defaultValue: '');

const lamportsPerSignature = 5000;

const termsUrl = 'https://espressocash.com/docs/legal/terms';
const privacyUrl = 'https://espressocash.com/docs/legal/privacy';

/// Currently, the rent cost is fixed at the genesis. However, it's anticipated
/// to be dynamic, reflecting the underlying hardware storage cost at the time.
/// So the price is generally expected to decrease as the hardware cost declines
/// as the technology advances.
///
/// For calculating **max** fee it's ok to use this hard-coded value,
/// since it's not expected to grow.
///
/// It's pre-calculated for `TokenProgram.neededAccountSpace = 165`.
const int tokenProgramRent = 2039280;

const Duration waitForSignatureDefaultTimeout = Duration(seconds: 90);
const Duration pingDefaultInterval = Duration(seconds: 1);

const _mainNetChainId = 101;
const _devNetChainId = 103;

/// Although this depends on the environment the only difference is
/// PROD vs non-PROD
const _solanaHost = isProd
    ? '' // mainnet URL should be provided via environment variable
    : 'api.devnet.solana.com';

const espressoCashLinkDomain = 'pay.espressocash.com';
const espressoCashLinkProtocol = 'espressocash';

const kadoBaseUrl = 'https://app.kado.money/';
const kadoApiBaseUrl = 'https://api.kado.money';
const kadoApiKey = String.fromEnvironment('KADO_API_KEY');

const rampApiKey = String.fromEnvironment('RAMP_API_KEY');

const guardarianBaseUrl = 'https://guardarian.com/calculator/v1';
const guardarianApiKey = String.fromEnvironment('GUARDARIAN_API_KEY');

const coinflowApiUrl = isProd
    ? 'https://api.coinflow.cash/api/'
    : 'https://api-sandbox.coinflow.cash/api/';

const coinflowKycUrl = isProd
    ? 'https://coinflow.cash/withdraw/espresso'
    : 'https://sandbox.coinflow.cash/withdraw/espresso';

const maxPayloadsPerSigningRequest = 10;

const playstoreName = 'com.pleasecrypto.flutter';
const appstoreId = '1559625715';

const intercomAppId = String.fromEnvironment('INTERCOM_APP_ID');
const intercomIosKey = String.fromEnvironment('INTERCOM_IOS_KEY');
const intercomAndroidKey = String.fromEnvironment('INTERCOM_ANDROID_KEY');
