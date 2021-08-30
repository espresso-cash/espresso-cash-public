# Borsh serialization for dart

A code generator for borsh serialization. To use this you need the [borsh_annotation](https://github.com/cryptoplease/cryptoplease-dart/tree/master/packages/borsh_annotation). As an example, you can make an object serializable by using the `@Struct` annotation. Then you can annotate members with the appropriate type annotations _e.g. `@u64` for a 64 bit unsigned integer_.


Then for decoding, use a factory and the generated function

```dart
factory MyStruct.fromBorsh(List<int> bytes) =>
    _MyStructFromBorsh(bytes);
```

for the decoding add a `toBorsh()` method to your class and use the generated function as well,

```dart
List<int> toBorsh() => _MyStructToBorsh(this);
```
