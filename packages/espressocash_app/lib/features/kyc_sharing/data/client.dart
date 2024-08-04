import 'package:grpc/grpc.dart';
import 'package:kyc_app_client/kyc_app_client.dart';

class XFlowClient {
  XFlowClient({String? baseUrl})
      : _channel = ClientChannel(
          baseUrl ?? 'localhost',
          port: 50051,
          options: ChannelOptions(
            credentials: const ChannelCredentials.insecure(),
            codecRegistry:
                CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
          ),
        );

  final ClientChannel _channel;

  KycServiceClient get kycValidatorClient => KycServiceClient(_channel);
  OtpServiceClient get otpServiceClient => OtpServiceClient(_channel);
}
