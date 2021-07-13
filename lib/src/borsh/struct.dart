abstract class BorshStruct {
  const BorshStruct();

  List<int> toBinary();
}

class EmptyBorshStruct extends BorshStruct {
  const EmptyBorshStruct();

  @override
  List<int> toBinary() => [];
}
