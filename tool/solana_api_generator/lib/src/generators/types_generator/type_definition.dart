import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana_api_generator/src/generators/types_generator/enum_value.dart';
import 'package:solana_api_generator/src/generators/types_generator/object_member.dart';
import 'package:solana_api_generator/src/parse_type.dart';
import 'package:solana_api_generator/src/utils/format_documentation.dart';
import 'package:solana_api_generator/src/utils/to_snake_case.dart';

part 'type_definition.freezed.dart';
part 'type_definition.g.dart';

@Freezed(unionKey: 'type', fallbackUnion: 'alias')
class TypeDefinition with _$TypeDefinition {
  @FreezedUnionValue('enum')
  const factory TypeDefinition.enumType({
    required String name,
    required List<EnumValue> values,
    required String description,
  }) = EnumType;

  @FreezedUnionValue('object')
  const factory TypeDefinition.objectType({
    required String name,
    required List<ObjectMember> fields,
    String? description,
  }) = ObjectType;

  const factory TypeDefinition.alias({
    required String name,
    required String description,
    required String type,
  }) = AliasType;

  factory TypeDefinition.fromJson(Map<String, dynamic> data) =>
      _$TypeDefinitionFromJson(data);

  const TypeDefinition._();

  @override
  String toString() => map(
        enumType: (e) => e.stringValue,
        objectType: (o) => o.stringValue,
        alias: (a) => a.stringValue,
      );
}

extension on ObjectType {
  String get documentation {
    final description = this.description;
    if (description == null) {
      // Warn if the description is missing
      print('object type $name has no description');
      return '';
    } else {
      return formatDocumentation(description);
    }
  }

  String get imports {
    final imports = [
      'package:json_annotation/json_annotation.dart',
      ...fields
          .map((field) {
            return _getImportFromTypeName(field.type);
          })
          .whereType<String>()
          .toList(growable: false),
    ]..sort((i, j) => i.compareTo(j));
    final part = 'part \'${toSnakeCase(name)}.g.dart\';';

    return 'import \'${imports.join('\';\nimport \'')}\';\n\n$part';
  }

  String get stringValue {
    final createFactory = !fields.hasConstantGetters();
    final factory = createFactory
        ? 'factory $name.fromJson(Map<String, dynamic> json) => _\$${name}FromJson(json);'
        : '';

    return '''$imports
    
  $documentation
  @JsonSerializable(createFactory: $createFactory, includeIfNull: false)
  class $name {
    const $name(${fields.toConstructorParameters()});

    $factory
    
    Map<String, dynamic> toJson() => _\$${name}ToJson(this);

    ${fields.constantGetters()}
    
    ${fields.toClassMemberList()}
  }''';
  }
}

extension on AliasType {
  String get stringValue {
    final importPackage = _getImportFromTypeName(type);

    return '''
${importPackage == null ? '' : 'import \'$importPackage\';'}
${formatDocumentation(description)}
typedef $name = ${parseType(type)};
''';
  }
}

extension on EnumType {
  String get stringValue => '''
enum $name {
  ${values.map((v) => v.code).join('\n')}
}
''';
}

extension on List<ObjectMember> {
  String constantGetters() {
    final getters = where((f) => f.constantValue != null);
    if (getters.isEmpty) {
      return '';
    } else {
      return getters.map((f) => f.toConstantGetter()).join('\n');
    }
  }

  bool hasConstantGetters() => any((f) => f.constantValue != null);

  String toConstructorParameters() {
    if (isEmpty) {
      return '';
    }
    final content =
        map((f) => f.toConstructorParameter()).whereType<String>().join(',');

    return '{$content,}';
  }

  String toClassMemberList() {
    if (isEmpty) {
      return '';
    }

    return map((f) => f.toClassMemberDeclaration())
        .whereType<String>()
        .join('\n');
  }
}

String? _getImportFromTypeName(String typeName) {
  late final String name;
  if (typeName.startsWith('map[')) {
    name = typeName.replaceFirst('map[string]', '');
  } else if (typeName.startsWith('[]')) {
    name = typeName.substring(2);
  } else {
    name = typeName;
  }

  switch (name) {
    case 'string':
    case 'bool':
    case 'u8':
    case 'u64':
    case 'usize':
    case 'int':
    case 'f64':
    case 'i64':
    case 'u16':
    case 'boolean':
    case 'object':
      return null;
    default:
      return 'package:solana/src/dto/${toSnakeCase(name)}.dart';
  }
}
