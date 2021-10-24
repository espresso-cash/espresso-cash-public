import 'package:json_annotation/json_annotation.dart';
import 'package:solana_api_generator/src/parse_type.dart';
import 'package:solana_api_generator/src/utils/format_documentation.dart';

part 'object_member.g.dart';

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

  String? toConstantGetter() {
    if (constantValue == null) {
      return null;
    } else {
      return 'String get $name => \'$constantValue\';';
    }
  }

  String? toFactoryParameter() {
    if (constantValue != null) {
      return null;
    } else {
      final nullableMarker = nullable || isOptional ? '?' : '';
      final requiredMarker = isOptional ? '' : 'required ';
      late final String validName;
      final type = parseType(this.type);
      final List<String> annotations = [];

      // Type AccountData is special. It requires a custom json
      // converter because it can be present in different formats
      // some of which are not even json.
      if (type == 'AccountData') {
        annotations.add('@AccountDataConverter()');
      }

      if (name.isCamelCase) {
        validName = name;
      } else {
        annotations.add('@JsonKey(name: \'$name\')');
        validName = name.toCamelCase();
      }
      final annotation = annotations.isEmpty ? '' : '${annotations.join(' ')} ';

      return '$annotation$requiredMarker$type$nullableMarker $validName';
    }
  }

  String get documentation {
    late final String validName;
    if (name.isCamelCase) {
      validName = name;
    } else {
      validName = name.toCamelCase();
    }

    return formatDocumentation(
      '- [$validName] ${description.replaceAll('\n', ' ')}',
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
