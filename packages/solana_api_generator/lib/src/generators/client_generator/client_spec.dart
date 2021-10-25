// Not using `@JsonSerializable` because it is not possible to do it
// at the phase of the build process
import 'package:solana_api_generator/src/generators/client_generator/method.dart';

class ClientSpecs {
  const ClientSpecs({
    required this.methods,
  });

  factory ClientSpecs.fromJson(dynamic data) {
    if (data is! Map<String, dynamic>) {
      throw ArgumentError('invalid input for client spec');
    }

    final list = data['methods'] as List<dynamic>;

    return ClientSpecs(
      methods: list
          .map((dynamic item) => Method.fromJson(item as Map<String, dynamic>))
          .toList(growable: false),
    );
  }

  @override
  String toString() => '''
///
/// Generated file, please do not modify
///
/// All methods needed for the RPC api are defined in this file, they were
/// generated from a specification file in json format.
///

import 'dart:async';

import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/encoder/message.dart';
import 'package:solana/src/json_rpc_client/json_rpc_client.dart';
import 'package:solana/src/rpc_client/exceptions.dart';
import 'package:solana/src/rpc_client/rpc_types.dart';
import 'package:solana/src/rpc_client/rpc_types_extension.dart';
import 'package:solana/src/subscription_client/subscription_client.dart';
import 'package:solana/src/utils.dart';

part 'rpc_client_extension.dart';

/// Solana rpc api client
class RPCClient {
  /// Build an rpc api client to communicate with the solana node [rpcUrl].
  RPCClient({
    required String rpcUrl, 
    required String websocketUrl,
  }) : _client = JsonRpcClient(rpcUrl), 
       _subscriptionClient = SubscriptionClient(websocketUrl);
  
  final JsonRpcClient _client;
  final SubscriptionClient _subscriptionClient;

  ${methods.join('\n')}
  
  dynamic _extractResultFromResponse(dynamic response) {
    if (response is! Map<String, dynamic>) {
      throw InvalidResponseException(response);
    }
    
    return response['result'];
  }
  
  dynamic _extractValueFromWrappedResponse(dynamic response) {
    final dynamic result = _extractResultFromResponse(response);
    if (result == null) {
      throw NullResponseException();
    }
    
    if (result is! Map<String, dynamic>) {
      throw const FormatException('result member must be a map with a "value" key in it');
    }
   
    return result['value'];
  } 
  
  List<T> _convertList<T>(dynamic list, T Function(dynamic item) convert) {
    if (list is! List<dynamic>) {
      throw const FormatException('input object is not a list');
    }
    
    return list.map(convert).toList(growable: false);
  }
  
  Map<K, T> _convertMap<K, T>(
    dynamic map, 
    K Function(dynamic key) convertKey, 
    T Function(dynamic value) convertValue,
  ) {
    if (map is! Map<dynamic, dynamic>) {
      throw const FormatException('input object is not a map');
    }

    final result = <K, T>{};
    for (final entry in map.entries) {
      result[convertKey(entry.key)] = convertValue(entry.value);
    }
    
    return result;
  }
}
''';

  final List<Method> methods;
}
