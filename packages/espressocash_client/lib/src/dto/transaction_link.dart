// TransactionLink Service DTOs

// GetOnboardingLink
class GetOnboardingLinkRequestDto {
  const GetOnboardingLinkRequestDto({
    required this.returnUrl,
    this.walletAddress,
    this.passkeyPublicKey,
    this.privyPublicKey,
    this.platform,
  });

  final String returnUrl;
  final String? walletAddress;
  final List<int>? passkeyPublicKey;
  final List<int>? privyPublicKey;
  final String? platform;
}

class GetOnboardingLinkResponseDto {
  const GetOnboardingLinkResponseDto({
    required this.onboardingUrl,
  });

  final String onboardingUrl;
}

// CreateTransactionLink
class CreateTransactionLinkRequestDto {
  const CreateTransactionLinkRequestDto({
    required this.returnUrl,
    required this.signerPublicKey,
    required this.requiredApprovals,
    this.expireAfterSeconds,
    this.paymentParams,
    this.swapParams,
  });

  final String returnUrl;
  final String signerPublicKey;
  final int requiredApprovals;
  final int? expireAfterSeconds;
  final PaymentParamsDto? paymentParams;
  final SwapParamsDto? swapParams;
}

class CreateTransactionLinkResponseDto {
  const CreateTransactionLinkResponseDto({
    required this.transactionUrl,
    required this.transactionId,
  });

  final String transactionUrl;
  final String transactionId;
}

// GetTransactionStatus
class GetTransactionStatusRequestDto {
  const GetTransactionStatusRequestDto({
    required this.transactionId,
  });

  final String transactionId;
}

class GetTransactionStatusResponseDto {
  const GetTransactionStatusResponseDto({
    required this.status,
    this.transactionSignature,
    this.failureReason,
  });

  final String status;
  final String? transactionSignature;
  final String? failureReason;
}

// Supporting DTOs
class PaymentParamsDto {
  const PaymentParamsDto({
    required this.receiverAddress,
    required this.amount,
    required this.tokenMint,
    this.reference,
  });

  final String receiverAddress;
  final int amount;
  final String tokenMint;
  final String? reference;
}

class SwapParamsDto {
  const SwapParamsDto({
    required this.inputMint,
    required this.outputMint,
    required this.amount,
    required this.slippageBps,
  });

  final String inputMint;
  final String outputMint;
  final int amount;
  final int slippageBps;
}
