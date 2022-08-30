/// The v1 is used to create the transaction using solana lib directly while v2
/// uses the cryptoplease API to create the transaction to pay the fees in USDC
enum ApiVersion { v1, v2 }

ApiVersion findVersionByName(String name) => ApiVersion.values.firstWhere(
      (ref) => ref.name == name,
      orElse: () => ApiVersion.v1,
    );
