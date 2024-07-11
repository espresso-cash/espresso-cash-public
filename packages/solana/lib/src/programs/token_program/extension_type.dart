enum ExtensionType {
  uninitialized(0),
  transferFeeConfig(1),
  transferFeeAmount(2),
  mintCloseAuthority(3),
  confidentialTransferMint(4),
  confidentialTransferAccount(5),
  defaultAccountState(6),
  immutableOwner(7),
  memoTransfer(8),
  nonTransferable(9),
  interestBearingConfig(10),
  cpiGuard(11),
  permanentDelegate(12),
  nonTransferableAccount(13),
  transferHook(14),
  transferHookAccount(15),
  metadataPointer(18),
  tokenMetadata(19),
  groupPointer(20),
  tokenGroup(21),
  groupMemberPointer(22),
  tokenGroupMember(23);

  const ExtensionType(this.value);

  final int value;
}
