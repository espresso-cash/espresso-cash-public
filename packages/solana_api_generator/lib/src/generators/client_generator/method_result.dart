class MethodResult {
  const MethodResult({
    required this.type,
    required this.description,
    this.nullable = false,
  });

  factory MethodResult.fromJson(Map<String, dynamic> data) => MethodResult(
        type: data['type'] as String,
        description: data['description'] as String,
        nullable: data['nullable'] as bool?,
      );

  final String type;
  final String description;
  final bool? nullable;
}
