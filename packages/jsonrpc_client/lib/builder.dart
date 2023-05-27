import 'package:build/build.dart';
import 'package:jsonrpc_client/src/client_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder clientBuilder(BuilderOptions _) =>
    PartBuilder([const ClientGenerator()], '.rpc.dart');
