import 'dart:io';

import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';

const isProd = bool.fromEnvironment('STELLAR_PROD', defaultValue: false);

final stellarNetwork = isProd ? Network.PUBLIC : Network.TESTNET;
final stellarSdk = isProd ? StellarSDK.PUBLIC : StellarSDK.TESTNET;

const _devBaseUrl = 'https://extstellar.moneygram.com/stellaradapterservice';
const _prodBaseUrl = 'https://stellar.moneygram.com/stellaradapterservice';
const moneygramBaseUrl = isProd ? _prodBaseUrl : _devBaseUrl;

final _prodPlatformSecret = Platform.environment['STELLAR_PROD_SECRET'] ?? '';
final _devPlatformSecret = Platform.environment['STELLAR_DEV_SECRET'] ??
    'SB22JSWC6HEUSOUGL2BG754FVEVT6C56HKFEZVFTKI7F5JXCYCGG4TRO';
final stellarPlatformKeyPair =
    KeyPair.fromSecretSeed(isProd ? _prodPlatformSecret : _devPlatformSecret);

const _devSigningKey =
    'GCSESAP5ILVM6CWIEGK2SDOCQU7PHVFYYT7JNKRDAQNVQWKD5YEE5ZJ4';
const _prodSigningKey =
    'GD5NUMEX7LYHXGXCAD4PGW7JDMOUY2DKRGY5XZHJS5IONVHDKCJYGVCL';
const moneygramSigningKey = isProd ? _prodSigningKey : _devSigningKey;

const _devAssetIssuer =
    'GBBD47IF6LWK7P7MDEVSCWR7DPUWV3NY3DTQEVFL4NAT4AQH3ZLLFLA5';
const _prodAssetIssuer =
    'GA5ZSEJYB37JRC5AVCIA5MOP4RHTM335X2KGX3IHOJAPP5RE34K4KZVN';
const moneygramAssetIssuer = isProd ? _prodAssetIssuer : _devAssetIssuer;

const _devAuthDomain = 'stellar-dev.espressocash.com';
const _prodAuthDomain = 'stellar-prod.espressocash.com';
const espressoClientDomain = isProd ? _prodAuthDomain : _devAuthDomain;
