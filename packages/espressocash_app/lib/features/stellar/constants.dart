import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';

const _isStellarProd =
    bool.fromEnvironment('STELLAR_PROD', defaultValue: false);

final stellarNetwork = _isStellarProd ? Network.PUBLIC : Network.TESTNET;
final stellarSdk = _isStellarProd ? StellarSDK.PUBLIC : StellarSDK.TESTNET;

const _devSorobanRpcUrl = 'https://soroban-testnet.stellar.org';
const _prodSorobanRpcUrl = String.fromEnvironment('SOROBAN_RPC_URL');
const sorobanRpcUrl = _isStellarProd ? _prodSorobanRpcUrl : _devSorobanRpcUrl;

const _devBaseUrl = 'https://extstellar.moneygram.com/stellaradapterservice';
const _prodBaseUrl = 'https://stellar.moneygram.com/stellaradapterservice';
const moneygramBaseUrl = _isStellarProd ? _prodBaseUrl : _devBaseUrl;

const _devSigningKey =
    'GCSESAP5ILVM6CWIEGK2SDOCQU7PHVFYYT7JNKRDAQNVQWKD5YEE5ZJ4';
const _prodSigningKey =
    'GD5NUMEX7LYHXGXCAD4PGW7JDMOUY2DKRGY5XZHJS5IONVHDKCJYGVCL';
const moneygramSigningKey = _isStellarProd ? _prodSigningKey : _devSigningKey;

const _devAssetIssuer =
    'GBBD47IF6LWK7P7MDEVSCWR7DPUWV3NY3DTQEVFL4NAT4AQH3ZLLFLA5';
const _prodAssetIssuer =
    'GA5ZSEJYB37JRC5AVCIA5MOP4RHTM335X2KGX3IHOJAPP5RE34K4KZVN';
const moneygramAssetIssuer =
    _isStellarProd ? _prodAssetIssuer : _devAssetIssuer;

const _devAuthDomain = 'stellar-dev.espressocash.com';
const _prodAuthDomain = 'espressocash.com';
const espressoClientDomain = _isStellarProd ? _prodAuthDomain : _devAuthDomain;
