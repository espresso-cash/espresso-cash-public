import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data/db/db.dart';
import '../../../../accounts/auth_scope.dart';
import '../../../../stellar/service/stellar_client.dart';
import '../../../models/ramp_type.dart';

@LazySingleton(scope: authScope)
class MoneygramInterceptor extends Interceptor {
  const MoneygramInterceptor(
    this._db,
    this._stellarClient,
  );

  final MyDatabase _db;
  final StellarClient _stellarClient;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    await _handleToken(options);
    handler.next(options);
  }

  Future<void> _handleToken(RequestOptions options) async {
    String? token = options.headers['Authorization'] as String?;
    if (token == null || _isTokenExpired(token)) {
      token = await _stellarClient.fetchToken();
      final type = options.headers['type'] as RampType?;
      final orderId = options.queryParameters['id'] as String?;

      if (type != null && orderId != null) {
        switch (type) {
          case RampType.onRamp:
            _updateOnRampOrder(orderId, token);
          case RampType.offRamp:
            _updateOffRampOrder(orderId, token);
        }
      }
    }
    options.headers['Authorization'] = token.toAuthHeader();
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

  bool _isTokenExpired(String? token) {
    if (token == null) return true;
    final decodedToken = JWT.decode(token);
    final payload = decodedToken.payload as Map<String, dynamic>?;
    final expiration = payload?['exp'] as int?;

    if (expiration == null) return true;

    final expirationDate =
        DateTime.fromMillisecondsSinceEpoch(expiration * 1000);

    return DateTime.now().isAfter(expirationDate);
  }
}

extension on String {
  String toAuthHeader() => 'Bearer $this';
}
