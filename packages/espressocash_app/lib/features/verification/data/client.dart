import 'package:grpc/grpc.dart';
import 'package:kyc_app_client/kyc_app_client.dart';

final channel = ClientChannel(
  'localhost',
  port: 50051,
  options: ChannelOptions(
    credentials: const ChannelCredentials.insecure(),
    codecRegistry: CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
  ),
);
final kycClient = KycServiceClient(channel);
final otpClient = OtpServiceClient(channel);
