abstract class BorshStruct {
  const BorshStruct();

  List<int> toBorsh();
}

class EmptyBorshStruct extends BorshStruct {
  const EmptyBorshStruct();

  @override
  List<int> toBorsh() => [];
}
