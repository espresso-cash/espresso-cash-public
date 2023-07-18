import 'package:pigeon/pigeon.dart';

@HostApi()
abstract class ApiLocalAssociationScenario {
  const ApiLocalAssociationScenario();
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

  @async
  AuthorizationResultDto authorize(
    int id,
    String? identityUri,
    String? iconUri,
    String? identityName,
    String? cluster,
  );

  @async
  AuthorizationResultDto reauthorize(
    int id,
    String? identityUri,
    String? iconUri,
    String? identityName,
    String authToken,
  );

  @async
  void deauthorize(int id, String authToken);

  @async
  SignPayloadsResultDto signTransactions(int id, List<Uint8List> transactions);

  @async
  SignMessagesResultDto signMessages(
    int id,
    List<Uint8List> messages,
    List<Uint8List> addresses,
  );

  @async
  SignAndSendTransactionsResultDto signAndSendTransactions(
    int id,
    List<Uint8List> transactions,
    int? minContextSlot,
  );
}

class GetCapabilitiesResultDto {
  const GetCapabilitiesResultDto({
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

class AuthorizationResultDto {
  const AuthorizationResultDto({
    required this.authToken,
    required this.publicKey,
    required this.accountLabel,
    required this.walletUriBase,
  });

  final String authToken;
  final Uint8List publicKey;
  final String? accountLabel;
  final String? walletUriBase;
}

class SignPayloadsResultDto {
  const SignPayloadsResultDto({
    required this.signedPayloads,
  });

  final List<Uint8List?> signedPayloads;
}

class SignAndSendTransactionsResultDto {
  const SignAndSendTransactionsResultDto({
    required this.signatures,
  });

  final List<Uint8List?> signatures;
}

class SignedMessageDto {
  const SignedMessageDto({
    required this.message,
    required this.addresses,
    required this.signatures,
  });

  final Uint8List message;
  final List<Uint8List?> addresses;
  final List<Uint8List?> signatures;
}

class SignMessagesResultDto {
  const SignMessagesResultDto({
    required this.messages,
  });

  final List<SignedMessageDto?> messages;
}
