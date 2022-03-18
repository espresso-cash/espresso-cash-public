import 'package:cryptoplease/bl/tokens/tag.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/bl/tokens/version.dart';
import 'package:json_annotation/json_annotation.dart';

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
