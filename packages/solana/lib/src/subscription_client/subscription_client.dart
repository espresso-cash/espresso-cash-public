import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:solana/src/dto/logs.dart';
import 'package:solana/src/dto/program_filter.dart';
import 'package:solana/src/dto/slot.dart';
import 'package:solana/src/exceptions/bad_state_exception.dart';
import 'package:solana/src/rpc_client/rpc_types.dart';
import 'package:solana/src/rpc_client/rpc_types_extension.dart';
import 'package:solana/src/subscription_client/abstract_message.dart';
import 'package:solana/src/subscription_client/error_message.dart';
import 'package:solana/src/subscription_client/logs_filter.dart';
import 'package:solana/src/subscription_client/maybe_error.dart';
import 'package:solana/src/subscription_client/notification_message.dart';
import 'package:solana/src/subscription_client/subscribed_message.dart';
import 'package:solana/src/subscription_client/subscription_client_exception.dart';
import 'package:solana/src/subscription_client/subscription_manager.dart';

/// Provides a websocket based connection to Solana.
class SubscriptionClient {
  SubscriptionClient(this._url)
      : _unattachedSubscriptionManagers = <int, SubscriptionManager>{},
        _attachedSubscriptionManagers = <int, SubscriptionManager>{};

  final String _url;

  final Map<int, SubscriptionManager> _unattachedSubscriptionManagers;
  final Map<int, SubscriptionManager> _attachedSubscriptionManagers;

  late final StreamSubscription<dynamic> _subscription;
  Future<WebSocket>? _websocket;

  int _lastRequestId = 1;

  Future<WebSocket> _getWebSocket() async {
    final websocketFuture = _websocket;
    if (websocketFuture != null) {
      return websocketFuture;
    }
    final completer = Completer<WebSocket>();
    // This is instantly initialized, now calling this method
    // again will immediately return the future object.
    //
    // This guarantees 2 things. First the connection is only established once
    // and then second, the late final _subscription variable will not be
    // initialized more than once.
    _websocket = completer.future;
    // Connect the websocket now
    final websocket = await WebSocket.connect(_url);
    // Make sure that the instance member is not overwritten before
    // attempting to access it
    _subscription = websocket.listen(_dispatchMessage);
    // Complete the completer so that any caller that is still waiting
    // gets its value
    completer.complete(websocket);
    // Return it now
    return websocket;
  }

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
      // This is an error received after the subscription should have been
      // cancelled. Which means, it was not really cancelled.
    } else {
      subscriptionManager.addError(SubscriptionClientException(message.error));
    }
  }

  void _deliverMessageToTargetStream(NotificationMessage message) {
    final id = message.subscription;
    final subscriptionManager = _attachedSubscriptionManagers[id];
    if (subscriptionManager == null) {
      throw BadStateException(
        'received a message for subscription $id, but it was not found',
      );
    } else {
      subscriptionManager.add(message.value);
    }
  }

  void _attachSubscriptionManager(int requestId, int subscriptionId) {
    final subscriptionManager = _unattachedSubscriptionManagers.remove(
      requestId,
    );
    if (subscriptionManager == null) {
      throw const BadStateException('cannot attach subscription manager');
    } else {
      _attachedSubscriptionManagers[subscriptionId] = subscriptionManager;
      subscriptionManager.subscriptionId = subscriptionId;
    }
  }

  Future<void> _sendRequest(
    int id,
    String method,
    List<dynamic>? params,
  ) async {
    // ignore: close_sinks
    final websocket = await _getWebSocket();

    final payload = json.encode(<String, dynamic>{
      'jsonrpc': '2.0',
      'id': id,
      'method': method,
      if (params != null) 'params': params,
    });

    websocket.add(payload);
  }

  void _createSubscription(int id, String method, List<dynamic>? params) {
    _sendRequest(id, '${method}Subscribe', params);
  }

  void _cancelSubscription(String method, int id) {
    final subscriptionManager = _attachedSubscriptionManagers.remove(id);
    // This would most certainly mean that something went wrong or unexpectedly
    // we throwing an exception seems appropriate
    if (subscriptionManager == null) {
      throw const BadStateException(
        'tried to cancel a non existing subscription',
      );
    }
    // Single shot subscriptions are cancelled without sending the
    // unsubscribe request. So we check that this is not a single shot
    // subscription before sending the unsubscribe request.
    if (subscriptionManager.isSingleShot == false) {
      _sendRequest(_lastRequestId++, '${method}Unsubscribe', <int>[id]);
    }
  }

  Stream<T> _subscribe<T>(
    String method, {
    List<dynamic>? params,
    bool singleShot = false,
  }) {
    late final SubscriptionManager<T> subscriptionManager;
    final requestId = _lastRequestId++;

    subscriptionManager = SubscriptionManager<T>(
      onListen: () {
        _createSubscription(requestId, method, params);
      },
      onCancel: (int subscriptionId) {
        _cancelSubscription(method, subscriptionId);
      },
      singleShot: singleShot,
    );

    _unattachedSubscriptionManagers[requestId] = subscriptionManager;

    return subscriptionManager.stream;
  }

  /// Dispose this object and cancel any existing subscription.
  void dispose() {
    _subscription.cancel();
    // Close the websocket sink now
    _websocket?.then<void>((w) => w.close());
  }

  /// Subscribe to an account with [address] to receive notifications when the
  /// lamports or data for a given account public key changes.
  ///
  /// Returns a [Stream] that can be used to listen for events. By cancelling the
  /// subscription returned by the `Stream.listen()` method of this stream you
  /// can send the _unsubscribe_ JSON RPC message to cancel the subscription cleanly
  /// from Solana.
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
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
              'commitment': commitment.toJson(),
            },
        ],
      );

  /// Subscribe to transaction logging.
  ///
  /// Returns a [Stream] that can be used to listen for events. By cancelling the
  /// subscription returned by the `Stream.listen()` method of this stream you
  /// can send the _unsubscribe_ JSON RPC message to cancel the subscription cleanly
  /// from Solana.
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
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
              'commitment': commitment.toJson(),
            },
        ],
      );

  /// Subscribe to a program to receive notifications when the lamports or data
  /// for a given account owned by the program changes.
  ///
  /// Returns a [Stream] that can be used to listen for events. By cancelling the
  /// subscription returned by the `Stream.listen()` method of this stream you
  /// can send the _unsubscribe_ JSON RPC message to cancel the subscription cleanly
  /// from Solana.
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
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
            'encoding': encoding.toJson(),
          },
          if (filters != null) ...filters,
          if (commitment != null)
            <String, String>{
              'commitment': commitment.toJson(),
            },
        ],
      );

  /// Subscribe to a transaction signature to receive notification when the
  /// transaction is confirmed On signatureNotification, the subscription is
  /// automatically cancelled.
  ///
  /// Returns a [Stream] that can be used to listen for events. There is no need
  /// to manually cancel this subscription and such action has no effect.
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Stream<MaybeError> signatureSubscribe(
    String signature, {
    Commitment? status,
  }) =>
      _subscribe<MaybeError>(
        'signature',
        params: <dynamic>[
          signature,
          if (status != null)
            <String, String>{
              'commitment': status.toJson(),
            },
        ],
        singleShot: true,
      );

  /// Subscribe to receive notification anytime a slot is processed by the
  /// validator.
  ///
  /// Returns a [Stream] that can be used to listen for events. By cancelling the
  /// subscription returned by the `Stream.listen()` method of this stream you
  /// can send the _unsubscribe_ JSON RPC message to cancel the subscription cleanly
  /// from Solana.
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Stream<Slot> slotSubscribe() => _subscribe<Slot>('slot');

  /// Subscribe to receive notification anytime a new root is set by the
  /// validator.
  ///
  /// Returns a [Stream] that can be used to listen for events. By cancelling the
  /// subscription returned by the `Stream.listen()` method of this stream you
  /// can send the _unsubscribe_ JSON RPC message to cancel the subscription cleanly
  /// from Solana.
  ///
  /// For [commitment] parameter description [see this document][see this document]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [see this document]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Stream<int> rootSubscribe() => _subscribe<int>('root');
}
