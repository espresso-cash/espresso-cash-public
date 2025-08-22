// Manage Service DTOs

// GetPlatformAccountInfo
class GetPlatformAccountInfoRequestDto {
  const GetPlatformAccountInfoRequestDto();
}

class GetPlatformAccountInfoResponseDto {
  const GetPlatformAccountInfoResponseDto({
    required this.accountId,
    required this.publicKey,
    required this.balance,
    required this.tokenAccounts,
  });

  final String accountId;
  final String publicKey;
  final int balance;
  final Map<String, int> tokenAccounts;
}
