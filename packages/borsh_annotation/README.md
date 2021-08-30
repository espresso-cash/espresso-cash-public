## Annotations for the borsh generator

See [borsh generator](https://github.com/cryptoplease/cryptoplease-dart/tree/master/packages/borsh).

This package is still under development, as an example you can use it as follows

```dart

@Struct()
class SimpleStruct1 extends BorshStruct {
  const SimpleStruct1({
    required this.strValue,
    required this.int32Value,
    required this.fixedIntegersArray,
    required this.dynamicStringArray,
  });

  factory SimpleStruct1.fromBorsh(List<int> bytes) =>
      _SimpleStruct1FromBorsh(bytes);

  @override
  List<int> toBorsh() => _SimpleStruct1ToBorsh(this);

  @string
  final String strValue;

  @i32
  final int int32Value;

  @Array.fixed(Borsh.u8, length: 3)
  final List<int> fixedIntegersArray;

  @Array.dynamic(Borsh.string)
  final List<String> dynamicStringArray;
}
```

The generator will generate a _.g.dart_ file that you must include in your file as a _part_.
