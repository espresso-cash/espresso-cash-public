import 'package:json_annotation/json_annotation.dart';

import 'tag.dart';
import 'token.dart';
import 'version.dart';

part 'parsed_content.g.dart';

@JsonSerializable(createToJson: false)
class ParsedContent {
  const ParsedContent({
    required this.name,
    required this.logoURI,
    required this.keywords,
    required this.tags,
    required this.timestamp,
    required this.tokens,
    required this.version,
  });

  factory ParsedContent.fromJson(Map<String, dynamic> json) =>
      _$ParsedContentFromJson(json);

  final String name;
  final String? logoURI;
  final List<String> keywords;
  final Map<String, Tag> tags;
  final DateTime timestamp;
  final List<Token> tokens;
  final Version version;
}
