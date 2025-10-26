import 'package:analyzer/dart/element/element.dart';
import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class BorshSerializableGenerator extends GeneratorForAnnotation<BorshSerializable> {
  const BorshSerializableGenerator();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final buffer = StringBuffer();

    if (element is! ClassElement) {
      throw ArgumentError('Only classes can be annotated with @BorshSerializable');
    }

    final name = element.name;
    final className = name?.replaceFirst(r'$', '') ?? '';
    final parameters = element.constructors.firstWhere((c) => c.name == 'new').formalParameters;

    final generatedMixin = '''
mixin _\$$className {
  ${_generateFields(parameters).join('\n')}

  ${_generateToBorsh(parameters).join('\n')}
}
''';

    final privateClass = '''
class _$className extends $className {
  _$className({
    ${_generateConstructor(parameters).join('\n')}
  }) : super._();

  ${_generatePrivateClassFields(parameters).join('\n')}
}
''';

    final scheme = '''
class B$className implements BType<$className> {
  const B$className();
  
  ${_generateWrite(className).join('\n')}
  ${_generateRead(className, parameters).join('\n')}
}
''';

    final fromBorsh = '''
$className _\$${className}FromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const B$className().read(reader);
}
''';

    buffer
      ..writeln(generatedMixin)
      ..writeln(privateClass)
      ..writeln(scheme)
      ..writeln(fromBorsh);

    return buffer.toString();
  }
}

Iterable<String> _generateConstructor(Iterable<FormalParameterElement> parameters) sync* {
  for (final p in parameters) {
    yield '${p.isRequiredNamed ? 'required' : ''} this.${p.name},';
  }
}

Iterable<String> _generatePrivateClassFields(Iterable<FormalParameterElement> parameters) sync* {
  for (final p in parameters) {
    yield 'final ${p.type} ${p.name};';
  }
}

Iterable<String> _generateFields(Iterable<FormalParameterElement> parameters) sync* {
  for (final parameter in parameters) {
    yield '${parameter.type} get ${parameter.name} => throw UnimplementedError();';
  }
}

Iterable<String> _generateToBorsh(Iterable<FormalParameterElement> parameters) sync* {
  yield 'Uint8List toBorsh() {';

  yield 'final writer = BinaryWriter();\n\n';

  for (final parameter in parameters) {
    yield 'const ${parameter.metadata.annotations.first.toSource().substring(1)}.write(writer, ${parameter.name});';
  }

  yield '\n\nreturn writer.toArray();';

  yield '}';
}

Iterable<String> _generateWrite(String className) sync* {
  yield '''
@override 
void write(BinaryWriter writer, $className value) {
  writer.writeStruct(value.toBorsh());
}
''';
}

Iterable<String> _generateRead(
  String className,
  Iterable<FormalParameterElement> parameters,
) sync* {
  String line(FormalParameterElement p) =>
      '${p.name}: const ${p.metadata.annotations.first.toSource().substring(1)}.read(reader),';

  yield '''
@override
$className read(BinaryReader reader) {
  return $className(
    ${parameters.map(line).join('\n')}
  );
}
''';
}
