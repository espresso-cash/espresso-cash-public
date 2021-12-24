import 'dart:async';
import 'dart:convert';

import 'package:solana/src/rpc/dto/account.dart';
import 'package:solana/src/rpc/dto/commitment.dart';
import 'package:solana/src/rpc/dto/confirmation_status.dart';
import 'package:solana/src/rpc/dto/encoding.dart';
import 'package:solana/src/rpc/dto/logs.dart';
import 'package:solana/src/rpc/dto/program_filter.dart';
import 'package:solana/src/rpc/dto/slot.dart';
import 'package:solana/src/subscription_client/abstract_message.dart';
import 'package:solana/src/subscription_client/error_message.dart';
import 'package:solana/src/subscription_client/logs_filter.dart';
import 'package:solana/src/subscription_client/notification_message.dart';
import 'package:solana/src/subscription_client/optional_error.dart';
import 'package:solana/src/subscription_client/subscribed_message.dart';
import 'package:solana/src/subscription_client/subscription_client_exception.dart';
import 'package:web_socket_channel/io.dart';

part 'extension.dart';

/// Provides a websocket based connection to Solana.
class SubscriptionClient {
  SubscriptionClient(this._uri);

  SubscriptionClient.fromUrl(String url) : this(Uri.parse(url));

  late final StreamSubscription<dynamic> _subscription;

  final Uri _uri;

  static int _requestId = 1;

  Stream<T> _subscribe<T>(
    String method, {
    List<dynamic>? params,
    bool singleShot = false,
  }) {
    final channel = IOWebSocketChannel.connect(_uri);
    final controller = StreamController<T>();

    final requestId = _requestId++;
    int? subscriptionId;

    controller.onListen = () {
      channel.stream.listen(
        (event) {
          print('↓ $event');
          if (event is String) {
            final parsed = json.decode(event) as Map<String, dynamic>;
            final message = SubscriptionMessage.fromJson(parsed);

            if (message is SubscribedMessage) {
              if (message.id != requestId) return;

              subscriptionId = message.result;
            } else if (message is ErrorMessage) {
              if (message.id != requestId) return;

              controller.addError(SubscriptionClientException(message.error));
            } else if (message is NotificationMessage) {
              if (message.subscription != subscriptionId) return;

              if (singleShot) subscriptionId = null;

              controller.add(message.value);
            }
          } else {
            throw FormatException(
              'unexpected type received through the websocket ${event.runtimeType}',
            );
          }
        },
        onError: controller.addError,
        onDone: controller.close,
      );
    };

    controller.onCancel = () {
      final id = subscriptionId;
      if (id == null) return;
      final unsubscribeRequestId = _requestId++;

      _sendRequest(
        channel,
        unsubscribeRequestId,
        '${method}Unsubscribe',
        <int>[id],
      );
    };

    _sendRequest(channel, requestId, '${method}Subscribe', params);

    return controller.stream;
  }

  void _sendRequest(
    IOWebSocketChannel channel,
    int id,
    String method,
    List<dynamic>? params,
  ) {
    final payload = json.encode(<String, dynamic>{
      'jsonrpc': '2.0',
      'id': id,
      'method': method,
      if (params != null) 'params': params,
    });

    print('↑ $payload');

    channel.sink.add(payload);
  }

  /// Dispose this object and cancel any existing subscription.
  void dispose() {
    _subscription.cancel();
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
              'commitment': commitment.value,
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
              'commitment': commitment.value,
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
            'encoding': encoding.value,
          },
          if (filters != null) ...filters,
          if (commitment != null)
            <String, String>{
              'commitment': commitment.value,
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
  Stream<void> signatureSubscribe(
    String signature, {
    Commitment? commitment,
  }) =>
      _subscribe<void>(
        'signature',
        params: <dynamic>[
          signature,
          if (commitment != null)
            <String, String>{
              'commitment': commitment.value,
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
