import 'package:pigeon/pigeon.dart';

@HostApi()
abstract class ApiLocalAssociationScenario {
  @async
  void create(int id);

  @async
  void start(int id);

  @async
  void close(int id);

  @async
  void startActivityForResult(int id, String? uriPrefix);

  @async
  GetCapabilitiesResultDto getCapabilities(int id);
}

class GetCapabilitiesResultDto {
  GetCapabilitiesResultDto({
    required this.supportsCloneAuthorization,
    required this.supportsSignAndSendTransactions,
    required this.maxTransactionsPerSigningRequest,
    required this.maxMessagesPerSigningRequest,
  });

  final bool supportsCloneAuthorization;
  final bool supportsSignAndSendTransactions;
  final int maxTransactionsPerSigningRequest;
  final int maxMessagesPerSigningRequest;
}
