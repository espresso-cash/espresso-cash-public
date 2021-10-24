import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana_api_generator/src/generators/types_generator/enum_value.dart';
import 'package:solana_api_generator/src/generators/types_generator/object_member.dart';
import 'package:solana_api_generator/src/parse_type.dart';
import 'package:solana_api_generator/src/utils/format_documentation.dart';

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
      print('object type $name has no description');
    }
    return description != null ? formatDocumentation(description) : '';
  }

  String get stringValue => '''$documentation
  @freezed
  @JsonSerializable(createFactory: false, includeIfNull: false)
  class $name with _\$$name {
    $constructorDocumentation
    const factory $name(${fields.toFactoryParameters()}) = _$name;

    factory $name.fromJson(Map<String, dynamic> data) => _\$${name}FromJson(data);

    ${fields.hasConstantGetters() ? 'const $name._();' : ''}

    ${fields.constantGetters()}
  }''';

  String get constructorDocumentation {
    final fieldsDocumentation = fields.map((f) => f.documentation).join('\n');
    return '$fieldsDocumentation';
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

  String toFactoryParameters() {
    if (isEmpty) {
      return '';
    }
    final content =
        map((f) => f.toFactoryParameter()).whereType<String>().join(',');

    return '{$content,}';
  }
}
