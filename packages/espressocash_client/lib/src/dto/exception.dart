import 'package:grpc/grpc.dart';

class EspressoCashException implements Exception {
  const EspressoCashException({required this.error});

  final EspressoCashError error;

  static EspressoCashException? tryParse(dynamic error) {
    if (error is! GrpcError) {
      return null;
    }

    final message = error.message?.toLowerCase() ?? '';

    if (message.contains('invalid escrow account')) {
      return const EspressoCashException(error: EspressoCashError.invalidEscrowAccount);
    } else if (message.contains('insufficient funds')) {
      return const EspressoCashException(error: EspressoCashError.insufficientFunds);
    } else if (message.contains('ambassador already assigned')) {
      return const EspressoCashException(error: EspressoCashError.ambassadorAlreadyAssigned);
    } else if (message.contains('user is not ambassador')) {
      return const EspressoCashException(error: EspressoCashError.userIsNotAmbassador);
    }

    return const EspressoCashException(error: EspressoCashError.genericError);
  }
}

enum EspressoCashError {
  /// Account is invalid or does not exist.
  invalidEscrowAccount,

  /// Account has insufficient funds.
  insufficientFunds,

  /// Generic error.
  genericError,

  /// User already has an ambassador assigned
  ambassadorAlreadyAssigned,

  /// User is not an ambassador
  userIsNotAmbassador,
}
