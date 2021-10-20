// Not using `@JsonSerializable` because it is not possible to do it
// at the phase of the build process
class ApiMethod {
  const ApiMethod({
    required this.name,
    required this.description,
    required this.isDeprecated,
    required this.isNew,
    required this.result,
    this.parameters,
  });

  factory ApiMethod.fromJson(Map<String, dynamic> data) => ApiMethod(
        name: data['name'] as String,
        description: data['description'] as String,
        isDeprecated: data['is_deprecated'] as bool,
        isNew: data['is_new'] as bool,
        parameters: _toFieldsList(data['parameters'] as List<dynamic>?),
        result: MethodResult.fromJson(data['result'] as Map<String, dynamic>),
      );

  final String name;
  final String description;
  final bool isDeprecated;
  final bool isNew;
  final List<Field>? parameters;
  final MethodResult result;
}
