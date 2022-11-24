import 'package:cryptoplease_api/cryptoplease_api.dart';

Future<int> extractFee(JupiterRoute route) async {
  final totalFeeInSol = route.fees?.totalFeeAndDeposits;

  if (totalFeeInSol == null) {
    throw Exception('Route has no fee object');
  }

  return convertSolToUsdc(totalFeeInSol);
}

// TODO(rhbrunetto): implement after jupiter price API
Future<int> convertSolToUsdc(num _) async {
  throw UnimplementedError();
}
