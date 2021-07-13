import 'package:build/build.dart';
import 'package:solana/src/borsh/struct_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder borsh(BuilderOptions options) =>
    SharedPartBuilder([StructGenerator()], 'borsh');
