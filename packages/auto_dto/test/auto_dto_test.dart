import 'package:auto_dto/src/dto_generator.dart';
import 'package:auto_dto/src/idl_parser.dart';
import 'package:test/test.dart';

void main() {
  group('Dto Generation from IDL', () {
    final idlPath = 'test/test_idl.json';
    final parser = IdlParser();
    final generator = DtoGenerator();

    test('should generate correct DTOs for instructions', () async {
      final dtos = await parser.parse(idlPath);
      final generatedCode = generator.generate(dtos, libraryFileStem: 'test_dto');

      expect(generatedCode, contains("import 'dart:typed_data';"));
      expect(generatedCode, contains("import 'package:borsh_annotation/borsh_annotation.dart';"));
      expect(generatedCode, contains("import 'package:solana/solana.dart';"));
      expect(generatedCode, contains("part 'test_dto.g.dart';"));

      // Assertions for CreatePlayerProfileArgs
      expect(generatedCode, contains("@BorshSerializable()"));
      expect(generatedCode, contains("class CreatePlayerProfileArgs with _\$CreatePlayerProfileArgs {"));
      expect(generatedCode, contains("  factory CreatePlayerProfileArgs({"));
      expect(generatedCode, contains("    @BString() required String name,"));
      expect(generatedCode, contains("  }) = _CreatePlayerProfileArgs;"));
      expect(generatedCode, contains("  CreatePlayerProfileArgs._();"));
      expect(generatedCode, contains("  factory CreatePlayerProfileArgs.fromBorsh(Uint8List data) =>"));
      expect(generatedCode, contains("      _\$CreatePlayerProfileArgsFromBorsh(data);"));
      expect(generatedCode, contains("  Uint8List toBorsh() => _\$CreatePlayerProfileArgsToBorsh(this);"));

      // Assertions for ExecuteTossArgs
      expect(generatedCode, contains("class ExecuteTossArgs with _\$ExecuteTossArgs {"));
      expect(generatedCode, contains("  factory ExecuteTossArgs({"));
      expect(generatedCode, contains("    @BBool() required bool won,"));
      expect(generatedCode, contains("  }) = _ExecuteTossArgs;"));
      expect(generatedCode, contains("  ExecuteTossArgs._();"));
      expect(generatedCode, contains("  factory ExecuteTossArgs.fromBorsh(Uint8List data) =>"));
      expect(generatedCode, contains("      _\$ExecuteTossArgsFromBorsh(data);"));
      expect(generatedCode, contains("  Uint8List toBorsh() => _\$ExecuteTossArgsToBorsh(this);"));
    });
  });
}
