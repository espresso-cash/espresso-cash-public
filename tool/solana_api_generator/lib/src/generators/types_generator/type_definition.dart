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

  String get imports => map(
        enumType: (_) => '',
        alias: (_) => '',
        objectType: (_) {
          final imports = fields
              .map((field) {
                final name = toSnakeCase(field.type);

                switch (field.type) {
                  case 'string':
                  case 'bool':
                  case 'u64':
                  case 'usize':
                    return null;
                  default:
                    return 'import \'package:solana/src/dto/$name.dart\';';
                }
              })
              .whereType<String>()
              .toList(growable: false);
          return imports.join('\n');
        },
      );

  String get stringValue {
    final createFactory = !fields.hasConstantGetters();
    final factory = createFactory
        ? 'factory $name.fromJson(Map<String, dynamic> json) => _\$${name}FromJson(json);'
        : '';

    return '''$imports
    
  $documentation
  @JsonSerializable(createToJson: false, createFactory: $createFactory, includeIfNull: false,)
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
  String get stringValue => '''
${formatDocumentation(description)}
typedef $name = ${parseType(type)};
''';
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
