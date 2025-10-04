# auto_dto

A Dart package for automatically generating Data Transfer Objects (DTOs) from `idl.json` files. This tool streamlines the process of creating Dart classes that can be serialized and deserialized using the Borsh format, which is commonly used in Solana projects.

## Features

*   **IDL Parsing**: Parses `idl.json` files to extract account structures.
*   **Code Generation**: Automatically generates Dart classes for each account defined in the IDL.
*   **Borsh Serialization**: The generated DTOs are annotated with `@BorshSerializable` and come with `fromBorsh` and `toBorsh` methods.
*   **Type Mapping**: Maps IDL data types to corresponding Dart types and Borsh annotations.
*   **Command-Line Interface**: Provides a simple CLI to trigger the DTO generation process.

## Usage

1.  **Add dependencies to your `pubspec.yaml`:**

    ```yaml
    dependencies:
      borsh_annotation: <version>
      solana: <version>

    dev_dependencies:
      auto_dto: <version>
      build_runner: <version>
      borsh: <version>
    ```
    *Replace `<version>` with the appropriate package versions.*

2.  **Provide an `idl.json` file.**
    For example, create a file named `idl.json`:
    ```json
    {
      "version": "0.1.0",
      "name": "my_project",
      "instructions": [],
      "accounts": [
        {
          "name": "MyDto",
          "type": {
            "kind": "struct",
            "fields": [
              {
                "name": "myString",
                "type": "string"
              },
              {
                "name": "myInt",
                "type": "u64"
              },
              {
                "name": "myBool",
                "type": "bool"
              }
            ]
          }
        }
      ],
      "errors": []
    }
    ```

3.  **Run the code generator.**
    Execute the command-line tool, providing the path to your `idl.json` file. The generated files will be placed in `lib/src/generated/`.

    ```bash
    dart run auto_dto idl.json
    ```

4.  **Generate serialization code.**
    Use `build_runner` to generate the necessary `.g.dart` files for Borsh serialization.

    ```bash
    dart run build_runner build
    ```

5.  **Use the generated DTOs.**
    You can now import and use the generated DTOs in your project.

    ```dart
    import 'package:my_project/src/generated/my_dto.dart';

    void main() {
      final myDto = MyDto(myString: 'hello', myInt: BigInt.from(123), myBool: true);
      final borshBytes = myDto.toBorsh();
      final deserializedDto = MyDto.fromBorsh(borshBytes);
    }
    ```

The current capabilities of the @auto_dto package do not fully address the GitHub issue described in auto_dto/issue.MD.

  Here's a breakdown:

  What is currently supported:

   * Basic DTO generation: The package can parse a simple idl.json and generate Dart classes with @BorshSerializable() annotations, fromBorsh(),
     and toBorsh() methods.
   * Basic type mapping: It correctly maps string to String (@BString()), bool to bool (@BBool()), u8, u16, u32 to int (@BU8(), @BU16(), @BU32()),
      and u64 to BigInt (@BU64()).

  What is NOT currently supported (and is required by the issue):

   * Parsing of complex IDL types: The idl_parser.dart is currently limited to parsing simple string types for fields. It cannot interpret nested
     type definitions for vec, option, or array (fixed-size arrays).
   * Code generation for complex types: The dto_generator.dart lacks the necessary _mapBorshAnno and _mapDartType logic to handle:
       * publicKey (expected to map to Ed25519HDPublicKey or Uint8List with @BPublicKey() or @BFixedArray(32, BU8())).
       * fixed array (e.g., array<u8, 32> expected to map to Uint8List with @BFixedArray(32, BU8())).
       * vec<T> (expected to map to List<T> with @BVec()).
       * option<T> (expected to map to T? with @BOption()).

  In summary, while the foundational structure for DTO generation exists, the package needs significant enhancements in both its IDL parsing and
   code generation logic to support the full range of types commonly found in Solana IDL files, as requested in the issue.MD.