import 'dart:io';
import 'package:auto_dto/src/dto_generator.dart';
import 'package:auto_dto/src/idl_parser.dart';
import 'package:test/test.dart';

void main() {
  group('Dto Generation for Foundational Types', () {
    final idlPath = 'test/test_idl.json';
    final parser = IdlParser();
    final generator = DtoGenerator();

    test('should generate correct DTOs for foundational types', () async {
      final dtos = await parser.parse(idlPath);
      final generatedCode = generator.generate(dtos, libraryFileStem: 'test_dto');

      expect(generatedCode, contains("import 'dart:typed_data';"));
      expect(generatedCode, contains("import 'package:borsh_annotation/borsh_annotation.dart';"));
      expect(generatedCode, contains("import 'package:solana/solana.dart';"));
      expect(generatedCode, contains("part 'test_dto.g.dart';"));

      expect(generatedCode, contains("@BorshSerializable()"));
      expect(generatedCode, contains("class TestDto with _\$TestDto {"));
      expect(generatedCode, contains("  factory TestDto({"));
      expect(generatedCode, contains("    @BString() required String myString,"));
      expect(generatedCode, contains("    @BBool() required bool myBool,"));
      expect(generatedCode, contains("    @BU8() required int myU8,"));
      expect(generatedCode, contains("    @BU16() required int myU16,"));
      expect(generatedCode, contains("    @BU32() required int myU32,"));
      expect(generatedCode, contains("    @BU64() required BigInt myU64,"));
      expect(generatedCode, contains("  }) = _TestDto;"));
      expect(generatedCode, contains("  TestDto._();"));
      expect(generatedCode, contains("  factory TestDto.fromBorsh(Uint8List data) =>"));
      expect(generatedCode, contains("      _\$TestDtoFromBorsh(data);"));
      expect(generatedCode, contains("  Uint8List toBorsh() => _\$TestDtoToBorsh(this);"));
    });
  });
}
