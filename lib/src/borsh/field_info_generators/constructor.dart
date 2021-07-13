import 'package:solana/src/borsh/generator_utils.dart';

String generateConstructorCode(List<FieldInfo> fields) {
  final StringBuffer buffer = StringBuffer();
  for (final field in fields) {
    final name = field.name;
    buffer.write('$name: $name,');
  }
  return buffer.toString();
}
