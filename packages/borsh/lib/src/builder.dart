import 'package:borsh/src/borsh_serializable_generator.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

Builder borsh(BuilderOptions _) =>
    SharedPartBuilder([const BorshSerializableGenerator()], 'borsh');
