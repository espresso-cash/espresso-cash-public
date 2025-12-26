// If 'PROD' is provided with the value "true" to the dart
// defines, then we mostly use the default values.

const isProd = bool.fromEnvironment('PROD');

const currentChainId = isProd ? _mainNetChainId : _devNetChainId;

// Environment dependent constants

const solanaRpcUrl = String.fromEnvironment('SOLANA_RPC_URL', defaultValue: 'https://$_solanaHost');

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

const brijBaseUrl = 'https://widget-demo.brij.fi/quote';
const brijApiKey = 'demo-integrator';

const maxPayloadsPerSigningRequest = 10;

const intercomAppId = String.fromEnvironment('INTERCOM_APP_ID');
const intercomIosKey = String.fromEnvironment('INTERCOM_IOS_KEY');
const intercomAndroidKey = String.fromEnvironment('INTERCOM_ANDROID_KEY');
