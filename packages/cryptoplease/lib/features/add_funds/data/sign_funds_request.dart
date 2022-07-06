import 'package:cloud_functions/cloud_functions.dart';
import 'package:decimal/decimal.dart';

Future<String> signFundsRequest(String address, Decimal value) async {
  final body = {
    'receiverAddress': address,
    'value': value.toDouble(),
  };
  final function = FirebaseFunctions.instance.httpsCallable('signRequest');
  final response = await function.call<Map<String, dynamic>>(body);

  return response.data['signed_url'] as String;
}
