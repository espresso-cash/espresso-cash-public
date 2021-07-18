import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:borsh/src/field_info_generators/constructor.dart';
import 'package:borsh/src/field_info_generators/field_list_deserialization.dart';
import 'package:borsh/src/field_info_generators/field_list_serialization.dart';
import 'package:borsh/src/field_info_generators/size_calculation.dart';
import 'package:borsh/src/generator_utils.dart';
import 'package:borsh/src/struct_annotation.dart';
import 'package:source_gen/source_gen.dart';

String createFromBorsh(String name, List<FieldInfo> fields) => '''
$name _${name}FromBorsh(List<int> _data) {
    ByteData _view = ByteData.sublistView(Uint8List.fromList(_data));
    int offset = 0;
    
    ${generateDeserializationCode(fields)}

    return $name(
      ${generateConstructorCode(fields)}
    );
  }
''';

String createToBorsh(String name, List<FieldInfo> fields) => '''
List<int> _${name}ToBorsh($name s) {
  int size = 0;
  ${generateSizeComputationCode(fields)}
  final data = ByteData(size);
  int offset = 0;
  ${generateSerializationCode(fields)}
  
  return data.buffer.asUint8List();
}
''';

class StructGenerator extends GeneratorForAnnotation<Struct> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final buffer = StringBuffer();
    if (element.kind != ElementKind.CLASS) {
      throw const FormatException('only classes can be annotated with @Struct');
    }
    final classElement = element as ClassElement;
    final fields = classFieldToFieldInfos(classElement.fields);

    if (annotation.read('createFromBorsh').boolValue) {
      buffer.write(createFromBorsh(element.displayName, fields));
    }

    if (annotation.read('createToBorsh').boolValue) {
      buffer.write(createToBorsh(element.displayName, fields));
    }

    return buffer.toString();
  }

  @override
  TypeChecker get typeChecker => const TypeChecker.fromRuntime(Struct);

  @override
  String toString() => 'Borsh Struct Generator';
}
