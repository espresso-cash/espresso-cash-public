import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../../../../data/db/db.dart';
import '../../../../stellar/models/stellar_wallet.dart';
import '../../../../stellar/service/stellar_client.dart';
import '../../../models/ramp_type.dart';

class MoneygramInterceptor extends Interceptor {
  const MoneygramInterceptor(
    this._db,
    this._stellarClient,
    this._stellarWallet,
  );

  final MyDatabase _db;
  final StellarClient _stellarClient;
  final StellarWallet _stellarWallet;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    await _handleToken(options);
    handler.next(options);
  }

  Future<void> _handleToken(RequestOptions options) async {
    final token = options.headers['Authorization'] as String?;
    if (token == null || _hasTokenExpired(token)) {
      final newToken =
          await _stellarClient.fetchToken(wallet: _stellarWallet.keyPair);
      options.headers['Authorization'] = 'Bearer $newToken';
      final type = options.headers['type'] as RampType?;
      final orderId = options.queryParameters['id'] as String?;

      if (type != null && orderId != null) {
        switch (type) {
          case RampType.onRamp:
            _updateOnRampOrder(orderId, newToken);
          case RampType.offRamp:
            _updateOffRampOrder(orderId, newToken);
        }
      }
    }
  }

  void _updateOnRampOrder(String orderId, String token) {
    _db.update(_db.onRampOrderRows)
      ..where((tbl) => tbl.partnerOrderId.equals(orderId))
      ..write(
        OnRampOrderRowsCompanion(
          authToken: Value(token),
        ),
      );
  }

  void _updateOffRampOrder(String orderId, String token) {
      _db.update(_db.offRampOrderRows)
      ..where((tbl) => tbl.partnerOrderId.equals(orderId))
      ..write(
        OffRampOrderRowsCompanion(
          authToken: Value(token),
        ),
      );
  }

  bool _hasTokenExpired(String? token) {
    if (token == null) return true;
    return JwtDecoder.isExpired(token);
  }
}
