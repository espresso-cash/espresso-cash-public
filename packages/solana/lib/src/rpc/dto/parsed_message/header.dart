/// The header of a [ParsedMessage]
class Header {
  Header({
    required this.numRequiredSignatures,
    required this.numReadonlySignedAccounts,
    required this.numReadonlyUnsignedAccounts,
  });

  factory Header.fromJson(dynamic json) {
    if (json is List) {
      return Header(
        numRequiredSignatures: json[0] as int,
        numReadonlySignedAccounts: json[2] as int,
        numReadonlyUnsignedAccounts: json[1] as int,
      );
    } else {
      return Header(
        numRequiredSignatures: json['numRequiredSignatures'] as int,
        numReadonlySignedAccounts: json['numReadonlySignedAccounts'] as int,
        numReadonlyUnsignedAccounts: json['numReadonlyUnsignedAccounts'] as int,
      );
    }
  }

  final int numRequiredSignatures;
  final int numReadonlySignedAccounts;
  final int numReadonlyUnsignedAccounts;
}
