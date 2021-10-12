import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:solana/src/dto/account.dart';
import 'package:solana/src/dto/commitment.dart';
import 'package:solana/src/dto/encoding.dart';
import 'package:solana/src/dto/logs.dart';
import 'package:solana/src/dto/program_filter.dart';
import 'package:solana/src/dto/slot.dart';
import 'package:solana/src/dto/slot_update.dart';
import 'package:solana/src/exceptions/bad_state_exception.dart';
import 'package:solana/src/subscription_client/abstract_message.dart';
import 'package:solana/src/subscription_client/error_message.dart';
import 'package:solana/src/subscription_client/logs_filter.dart';
import 'package:solana/src/subscription_client/notification_message.dart';
import 'package:solana/src/subscription_client/optional_error.dart';
import 'package:solana/src/subscription_client/subscribed_message.dart';
import 'package:solana/src/subscription_client/subscription_client_exception.dart';
import 'package:solana/src/subscription_client/subscription_manager.dart';

class SubscriptionClient {
  SubscriptionClient._(this._webSocket)
      : _unattachedSubscriptionManagers = <int, SubscriptionManager>{},
        _attachedSubscriptionManagers = <int, SubscriptionManager>{} {
    _subscription = _webSocket.listen(_dispatchMessage);
  }

  final WebSocket _webSocket;
  final Map<int, SubscriptionManager> _unattachedSubscriptionManagers;
  final Map<int, SubscriptionManager> _attachedSubscriptionManagers;

  late final StreamSubscription<dynamic> _subscription;

  int _lastCallId = 1;

  void dispose() {
    _subscription.cancel();
  }

  static Future<SubscriptionClient> connect(String url) async =>
      SubscriptionClient._(await WebSocket.connect(url));

  void _dispatchMessage(dynamic data) {
    if (data is String) {
      final parsed = json.decode(data) as Map<String, dynamic>;
      final message = SubscriptionMessage.fromJson(parsed);
      if (message is SubscribedMessage) {
        _attachSubscriptionManager(message.id, message.result);
      } else if (message is ErrorMessage) {
        _destroySubscriptionManager(message);
      } else if (message is NotificationMessage) {
        _deliverMessageToTargetStream(message);
      }
    } else {
      throw FormatException(
        'unexpected type received through the websocket ${data.runtimeType}',
      );
    }
  }

  void _destroySubscriptionManager(ErrorMessage message) {
    final id = message.id;
    final subscriptionManager = _unattachedSubscriptionManagers.remove(id);
    if (subscriptionManager == null) {
      throw BadStateException(
        'subscription manager not found for ${message.id}',
      );
    } else {
      subscriptionManager.addError(SubscriptionClientException(message.error));
    }
  }

  void _deliverMessageToTargetStream(NotificationMessage message) {
    final id = message.subscription;
    final subscriptionManager = _attachedSubscriptionManagers[id];
    if (subscriptionManager == null) {
      throw BadStateException(
        'subscription manager not found for ${message.subscription}',
      );
    } else {
      subscriptionManager.add(message.value);
    }
  }

  void _attachSubscriptionManager(int callId, int subscriptionId) {
    final subscriptionManager = _unattachedSubscriptionManagers.remove(callId);
    if (subscriptionManager == null) {
      throw BadStateException('subscription manager not found for $callId');
    } else {
      // We now move the controller to the attached controllers. The id
      // in the map is now the subscription id
      _attachedSubscriptionManagers[subscriptionId] = subscriptionManager;
    }
  }

  void _sendRequest(int id, String method, List<dynamic>? params) {
    _webSocket.add(
      json.encode(<String, dynamic>{
        'jsonrpc': '2.0',
        'id': id,
        'method': method,
        if (params != null) 'params': params,
      }),
    );
  }

  void _createSubscription(int id, String method, List<dynamic>? params) {
    _sendRequest(id, '${method}Subscribe', params);
  }

  void _cancelSubscription(String method, int? id) {
    if (id != null) {
      _sendRequest(_lastCallId++, '${method}Unsubscribe', <int>[id]);
      _attachedSubscriptionManagers.remove(id);
    }
  }

  Stream<T> _subscribe<T>(
    String method, {
    List<dynamic>? params,
  }) {
    late final SubscriptionManager<T> subscriptionManager;

    final callId = _lastCallId++;

    subscriptionManager = SubscriptionManager<T>(
      StreamController<T>(
        onListen: () {
          _createSubscription(callId, method, params);
        },
        onCancel: () {
          _cancelSubscription(method, subscriptionManager.subscriptionId);
        },
      ),
    );
    _unattachedSubscriptionManagers[callId] = subscriptionManager;

    return subscriptionManager.stream;
  }

  Stream<Account> accountSubscribe(
    String address, {
    Commitment? commitment,
  }) =>
      _subscribe<Account>(
        'account',
        params: <dynamic>[
          address,
          if (commitment != null)
            <String, String>{
              'commitment': commitment.value,
            },
        ],
      );

  Stream<Logs> logsSubscribe(
    LogsFilter filter, {
    Commitment? commitment,
  }) =>
      _subscribe<Logs>(
        'logs',
        params: <dynamic>[
          filter.when(
            all: () => 'all',
            allWithVotes: () => 'allWithVotes',
            mentions: (pubKeys) => <String, List<String>>{
              'mentions': pubKeys,
            },
          ),
          if (commitment != null)
            <String, String>{
              'commitment': commitment.value,
            },
        ],
      );

  Stream<dynamic> programSubscribe(
    String programId, {
    Encoding encoding = Encoding.jsonParsed,
    List<ProgramFilter>? filters,
    Commitment? commitment,
  }) =>
      _subscribe<dynamic>(
        'program',
        params: <dynamic>[
          <String, String>{
            'encoding': encoding.value,
          },
          if (filters != null) ...filters,
          if (commitment != null)
            <String, String>{
              'commitment': commitment.value,
            },
        ],
      );

  Stream<OptionalError> signatureSubscribe(
    String signature, {
    Commitment? commitment,
  }) =>
      _subscribe<OptionalError>(
        'signature',
        params: <dynamic>[
          signature,
          if (commitment != null)
            <String, String>{
              'commitment': commitment.value,
            },
        ],
      );

  Stream<Slot> slotSubscribe() => _subscribe<Slot>('slot');

  Stream<SlotUpdate> slotUpdatesSubscribe() =>
      _subscribe<SlotUpdate>('slotUpdates');

  Stream<int> rootSubscribe() => _subscribe<int>('root');
}
