import 'dart:io';

import 'package:solana/solana.dart';

const cpLinkDomain = 'cryptoplease.link';
const link1Host = 'solana1.$cpLinkDomain';
const link2Host = 'solana2.$cpLinkDomain';
const solanaPayHost = 'solanapay.$cpLinkDomain';
const deeplinkScheme = 'cryptoplease-sol';
const protocolMap = {
  link1Host: '1',
  link2Host: '2',
};

const shareableLinkPaymentFee = 10;

final devnetUsdc = Ed25519HDPublicKey.fromBase58(
  '4zMMC9srt5Ri5X14GAgXhaHii3GnPAEERYPJgZJDncDU',
);

final mainnetUsdc = Ed25519HDPublicKey.fromBase58(
  'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v',
);

final devnetPlatformMnemonic =
    Platform.environment['PLATFORM_MNEMONIC_DEVNET'] ?? '';
final mainnetPlatformMnemonic =
    Platform.environment['PLATFORM_MNEMONIC_MAINNET'] ?? '';

final mainnetRpcUrl = Platform.environment['SOLANA_RPC_URL'] ?? '';
final mainnetWsUrl = Platform.environment['SOLANA_WEBSOCKET_URL'] ?? '';
