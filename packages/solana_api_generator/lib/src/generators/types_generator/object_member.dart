import 'package:json_annotation/json_annotation.dart';
import 'package:solana_api_generator/src/parse_type.dart';
import 'package:solana_api_generator/src/utils/format_documentation.dart';

part 'object_member.g.dart';

/// An object member
@JsonSerializable()
class ObjectMember {
  ObjectMember({
    required this.type,
    required this.description,
    required this.name,
    this.defaultValue,
    this.constantValue,
    this.isOptional = false,
    this.nullable = false,
    this.fields,
  });

  factory ObjectMember.fromJson(Map<String, dynamic> data) =>
      _$ObjectMemberFromJson(data);

  /// Generate code for a constant getter
  ///
  /// This is used for members that are inherently constant or for ones
  /// that we want to only allow a single value.
  String? toConstantGetter() {
    if (constantValue == null) {
      return null;
    } else {
      return 'String get $name => \'$constantValue\';';
    }
  }

  /// Generates code for a class member declaration
  String? toClassMemberDeclaration() {
    if (constantValue != null) {
      return null;
    } else {
      // Append a '?' marker if the field can be made null or omitted
      final nullableMarker = nullable || isOptional ? '?' : '';
      // Get the language specific type from the spec type
      final type = parseType(this.type);
      // We could need some annotations
      final List<String> annotations = [];
      late final String validName;

      if (name.isCamelCase) {
        validName = name;
      } else {
        validName = name.toCamelCase();
        // In case we've changed the casing, make the serializer
        // correctly read the original field name
        annotations.add('@JsonKey(name: \'$name\')');
      }
      final annotationsValue =
          annotations.isEmpty ? '' : '${annotations.join(' ')} ';

      return '''
        $_documentation
        ${annotationsValue}final $type$nullableMarker $validName;
      ''';
    }
  }

  /// Generate code for a constructor parameter
  String? toConstructorParameter() {
    // Values having this set, are not meant to be used for constructing objects
    if (constantValue != null) {
      return null;
    } else {
      late final String validName;
      // Required values need the 'required' keyword
      final requiredMarker = isOptional ? '' : 'required ';
      if (name.isCamelCase) {
        validName = name;
      } else {
        validName = name.toCamelCase();
      }

      return '${requiredMarker}this.$validName';
    }
  }

  /// Returns the documentation string
  String get _documentation {
    if (description.startsWith('@help/')) {
      return '';
    }

    return formatDocumentation(
      '${description.replaceAll('\n', ' ')}',
    );
  }

  final String type;
  final String description;
  final String name;
  @JsonKey(name: 'is_optional')
  bool isOptional;
  @JsonKey(name: 'default_value')
  dynamic defaultValue;
  @JsonKey(name: 'constant_value')
  dynamic constantValue;
  bool nullable;
  final Map<String, ObjectMember>? fields;
}

extension on String {
  bool get isCamelCase => !contains(RegExp('[^a-zA-Z]'));

  String toCamelCase() {
    final words = split(RegExp('[ _-]'));
    return words
        .map((word) => word.toLowerCase())
        .reduce((concatenated, word) => concatenated + word.toTitle());
  }

  String toTitle() {
    final lowerCased = toLowerCase();
    if (lowerCased.isEmpty) {
      throw ArgumentError('cannot determine the name of this field');
    }

    return lowerCased[0].toUpperCase() + lowerCased.substring(1);
  }
}
