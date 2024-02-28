// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';

import 'package:dfunc/dfunc.dart';
import 'package:injectable/injectable.dart';
import 'package:webthree/browser.dart';
import 'package:webthree/contracts/erc20.dart';
import 'package:webthree/crypto.dart';
import 'package:webthree/webthree.dart';

import '../../../features/blockchain/models/blockchain.dart';
import '../../di.dart';
import 'js.dart';
import 'models/exception.dart';

@LazySingleton(scope: landingScope)
class Web3Service {
  const Web3Service();

  bool get isEnabled => window.ethereum != null;

  Ethereum get eth {
    final eth = window.ethereum;
    if (eth == null) {
      throw const Web3Exception.metaMaskNotInstalled();
    }

    return eth;
  }

  Web3Client get client => Web3Client.custom(eth.asRpcService());

  Stream<String> get chainChanged =>
      eth.chainChanged.map((event) => event.toString());

  Stream<String> get accountsChanged => eth.accountsChanged
      .map((event) => (event as List<Object?>).cast<String>().first);

  Future<(EthereumAddress, int)> connect() async {
    final client = Web3Client.custom(eth.asRpcService());
    final credentials = await eth.requestAccounts();
    final chainId = await client.getNetworkId();

    return (credentials[0].address, chainId);
  }

  Future<int> getChainId() => client.getNetworkId();

  Future<String> sendTransaction({
    required String to,
    required BigInt value,
    String? data,
  }) async {
    final credentials = await eth.requestAccounts();

    final baseGas = await client.getGasPrice();
    final updatedGas = baseGas.getValueInUnit(EtherUnit.wei) * 1.8;
    final gas = EtherAmount.fromDouble(EtherUnit.wei, updatedGas);

    final transaction = Transaction(
      to: EthereumAddress.fromHex(to),
      data: data?.let(hexToBytes),
      value: EtherAmount.inWei(value),
      gasPrice: gas,
    );

    return client.sendTransaction(
      credentials.first,
      transaction,
    );
  }

  Future<String> approveContract({
    required String contractAddress,
    required String to,
    required int amount,
  }) async {
    final credentials = await eth.requestAccounts();

    final token = IERC20(
      address: EthereumAddress.fromHex(contractAddress),
      client: client,
    );

    return token.approve(
      EthereumAddress.fromHex(to),
      BigInt.from(amount),
      credentials: credentials.first,
    );
  }

  Future<void> switchChain(Blockchain chain) async {
    try {
      await eth.rawRequest(
        'wallet_switchEthereumChain',
        params: [JSrawRequestSwitchChainParams(chainId: chain.hexChainId)],
      );
    } on EthereumException catch (error) {
      if (error.code == 4902) {
        await _addChain(chain);
      } else {
        throw const Web3Exception.userRejected();
      }
    }
  }

  Future<void> _addChain(Blockchain chain) async {
    final params = switch (chain) {
      Blockchain.arbitrum => _arbitrum,
      Blockchain.polygon => _polygon,
      Blockchain.ethereum => _ethChain,
      Blockchain.solana => null,
    };

    if (params == null) return;

    await eth
        .rawRequest('wallet_addEthereumChain', params: [mapToJsObject(params)]);
  }
}

const _ethChain = <String, dynamic>{
  'chainId': '0x1',
  'chainName': 'Ethereum',
  'nativeCurrency': <String, dynamic>{
    'name': 'Ether',
    'symbol': 'ETH',
    'decimals': 18,
  },
  'rpcUrls': ['https://mainnet.infura.io/v3/'],
  'blockExplorerUrls': ['https://etherscan.io/'],
};

const _polygon = <String, dynamic>{
  'chainId': '0x89',
  'chainName': 'Polygon',
  'nativeCurrency': <String, dynamic>{
    'name': 'MATIC',
    'symbol': 'MATIC',
    'decimals': 18,
  },
  'rpcUrls': ['https://polygon-rpc.com/'],
  'blockExplorerUrls': ['https://polygonscan.com'],
};

const _arbitrum = <String, dynamic>{
  'chainId': '0xa4b1',
  'chainName': 'Arbitrum One',
  'nativeCurrency': <String, dynamic>{
    'name': 'Arbitrum Ether',
    'symbol': 'AETH',
    'decimals': 18,
  },
  'rpcUrls': [' https://arb1.arbitrum.io/rpc'],
  'blockExplorerUrls': ['https://arbiscan.io'],
};
