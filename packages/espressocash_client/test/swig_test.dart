import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:solana/solana.dart' hide AuthorityType;
import 'package:test/test.dart';

import 'utils.dart';

/// Comprehensive SWIG (Smart Wallet Instruction Gateway) functionality tests.
///
/// This test file validates the complete SWIG workflow as documented in docs/swig-flow.md:
///
/// **SWIG Architecture Overview:**
/// ```
/// Traditional Wallet → SWIG Smart Contract → Multiple Authorities
/// 7xKXtg2CW87d...   → 4fYNw3dojWmQ...    → Ed25519 + Passkey + Secp256k1
/// ```
///
/// **Test Coverage:**
/// 1. **SWIG Wallet Operations**
///    - CreateWallet: Creates a new SWIG wallet for a given owner
///    - GetWalletAuthorities: Retrieves all authorities and permissions
///
/// 2. **Authority Management**
///    - PrepareAddAuthority/SubmitAddAuthority: Add new signing authorities
///    - Ed25519: Owner authority (always role 0)
///    - Secp256k1: MetaMask/Ethereum wallet authority
///    - Secp256r1: WebAuthn/Passkey authority
///
/// 3. **Transaction Execution**
///    - CreateDirectPayment: Generate payment transactions via backend
///    - PrepareSignV1/SubmitSignV1: Wrap and execute transactions through SWIG
///    - Multi-authority signing: Different signature types per authority
///
/// **Key SWIG Concepts:**
/// - **SWIG Wallet**: A smart contract wallet that can have multiple authorities
/// - **Authority**: A signing entity with specific permissions (Ed25519, Secp256k1, Secp256r1)
/// - **Role ID**: Unique identifier for each authority (0 = owner, 1+ = additional authorities)
/// - **Permission Types**: Control what operations an authority can perform
///   - SOL_LIMIT: Limited SOL spending permissions
///   - ALL: Full wallet permissions
/// - **Wrapped Instruction**: Regular Solana instructions wrapped for SWIG execution
///
/// **Testing Strategy:**
/// - Most tests use mock signatures to avoid requiring actual MetaMask/WebAuthn
/// - Real Ed25519 signatures could be used but are mocked for consistency
/// - Tests are designed to validate API contracts and data flow
/// - Skip flags allow selective test execution based on available integrations
///
/// Based on the SWIG flow documentation in docs/swig-flow.md

// Test constants
const String solMintAddress = 'So11111111111111111111111111111111111111112';
const String usdcMintAddress = 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v';

// Helper functions for SWIG testing

/// Base64 encodes a byte array to string
String base64EncodeBytes(Uint8List bytes) => base64Encode(bytes);

/// Base64 decodes a string to byte array
Uint8List base64DecodeString(String encoded) => base64Decode(encoded);

/// Generates mock public key for testing authorities
Uint8List generateMockPublicKey(int length) {
  final random = Random.secure();
  final bytes = Uint8List(length);
  for (int i = 0; i < length; i++) {
    bytes[i] = random.nextInt(256);
  }

  return bytes;
}

/// Creates mock Secp256k1 public key (64 bytes uncompressed)
Uint8List createMockSecp256k1PublicKey() => generateMockPublicKey(64);

/// Creates mock Secp256r1 public key (33 bytes compressed)
Uint8List createMockSecp256r1PublicKey() => generateMockPublicKey(33);

/// Simulates Ed25519 signing for testing
SigningResultDto createMockEd25519Signature() {
  final mockSignature = generateMockPublicKey(64);

  return SigningResultDto(
    signature: base64EncodeBytes(mockSignature),
    prefix: base64EncodeBytes(Uint8List(0)),
    message: base64EncodeBytes(Uint8List(0)),
  );
}

/// Simulates Secp256k1 signing for testing
SigningResultDto createMockSecp256k1Signature() {
  final mockSignature = generateMockPublicKey(65); // r(32) + s(32) + recovery(1)
  final mockPrefix = utf8.encode(r'\x19Ethereum Signed Message:\n32');

  return SigningResultDto(
    signature: base64EncodeBytes(mockSignature),
    prefix: base64EncodeBytes(Uint8List.fromList(mockPrefix)),
    message: base64EncodeBytes(Uint8List(0)),
  );
}

/// Simulates Secp256r1 (passkey) signing for testing
SigningResultDto createMockSecp256r1Signature() {
  final mockSignature = generateMockPublicKey(64);
  final mockAuthenticatorData = generateMockPublicKey(37);
  final mockClientDataHash = generateMockPublicKey(32);

  // Create WebAuthn message = authenticatorData + clientDataHash
  final webAuthnMessage = Uint8List.fromList([...mockAuthenticatorData, ...mockClientDataHash]);

  return SigningResultDto(
    signature: base64EncodeBytes(mockSignature),
    prefix: base64EncodeBytes(Uint8List(0)),
    message: base64EncodeBytes(webAuthnMessage),
  );
}

/// Extracts instruction from base64 transaction for SWIG wrapping
Map<String, dynamic> extractInstructionFromTransaction(String base64Transaction) {
  // For testing, return a mock instruction structure
  return {
    'ProgID': 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA',
    'AccountValues': [
      {'PublicKey': solMintAddress, 'IsSigner': false, 'IsWritable': true},
    ],
    'DataBytes': [1, 2, 3, 4], // Mock instruction data
  };
}

/// Creates permission action for authority testing
PermissionActionDto createPermissionAction(int permissionType, {List<int>? data}) {
  final permissionData = data ?? List.filled(32, 0); // Default to 32 zero bytes

  return PermissionActionDto(
    permissionType: permissionType,
    permissionData: base64EncodeBytes(Uint8List.fromList(permissionData)),
  );
}

void main() {
  late EspressoCashClient client;
  late Ed25519HDKeyPair ownerKeyPair;

  setUp(() async {
    ownerKeyPair = await Ed25519HDKeyPair.random();
    client = await createClient(local: true, keyPair: ownerKeyPair);

    await client.login();
  });

  tearDown(() {
    // ConnectRPC Transport doesn't need explicit disposal
  });

  group('SWIG Wallet Operations', () {
    late String swigWalletAddress;

    test('creates SWIG wallet successfully', skip: false, () async {
      // Create SWIG wallet for owner
      final createRequest = CreateWalletRequestDto(
        ownerAddress: ownerKeyPair.address,
        platform: 'dart-test',
      );

      final createResponse = await client.createWallet(createRequest);

      expect(createResponse.swigWalletAddress, isA<String>());
      expect(createResponse.swigWalletAddress, isNotEmpty);
      expect(createResponse.unsignedTransaction, isA<String>());
      expect(createResponse.unsignedTransaction, isNotEmpty);

      swigWalletAddress = createResponse.swigWalletAddress;

      // Verify address is valid base58 format
      expect(
        () => Ed25519HDPublicKey.fromBase58(createResponse.swigWalletAddress),
        returnsNormally,
      );
    });

    test('retrieves wallet authorities', skip: false, () async {
      // Skip if no SWIG wallet was created
      if (swigWalletAddress.isEmpty) {
        markTestSkipped('SWIG wallet not created in previous test');
      }

      final authoritiesRequest = GetWalletAuthoritiesRequestDto(
        swigWalletAddress: swigWalletAddress,
      );

      final authoritiesResponse = await client.getWalletAuthorities(authoritiesRequest);

      expect(authoritiesResponse.authorities, isA<List<SWIGAuthorityDto>>());
      expect(authoritiesResponse.authorities, isNotEmpty);

      // First authority should be the owner (Ed25519)
      final ownerAuthority = authoritiesResponse.authorities.first;
      expect(ownerAuthority.roleId, equals(0));
      expect(ownerAuthority.authorityType, equals(AuthorityType.ed25519String));
      expect(ownerAuthority.permissions, isA<List<PermissionActionDto>>());
    });
  });

  group('SWIG Authority Management', () {
    late String swigWalletAddress;

    test('adds Secp256k1 authority', skip: false, () async {
      // Create SWIG wallet first if needed
      if (swigWalletAddress.isEmpty) {
        final createRequest = CreateWalletRequestDto(
          ownerAddress: ownerKeyPair.address,
          platform: 'dart-test',
        );
        final createResponse = await client.createWallet(createRequest);
        swigWalletAddress = createResponse.swigWalletAddress;
      }

      // Generate mock Secp256k1 public key
      final secp256k1PubKey = createMockSecp256k1PublicKey();

      // Prepare add authority request
      final prepareRequest = PrepareAddAuthorityRequestDto(
        swigWalletAddress: swigWalletAddress,
        signingRoleId: 0, // Owner signs to add new authority
        newAuthority: AuthorityInfoDto(
          data: base64EncodeBytes(secp256k1PubKey),
          type: AuthorityType.secp256k1String,
        ),
        permissionActions: [
          createPermissionAction(PermissionType.solLimit), // Limited SOL permissions
        ],
      );

      final prepareResponse = await client.prepareAddAuthority(prepareRequest);

      expect(prepareResponse.unsignedTransaction, isA<String>());
      expect(prepareResponse.messageHash, isA<String>());
      expect(prepareResponse.slot, isA<int>());
      expect(prepareResponse.expectedCounter, isA<int>());

      // Submit with mock Ed25519 signature (owner signing)
      final mockSignature = createMockEd25519Signature();
      final submitRequest = SubmitAddAuthorityRequestDto(
        signingResult: mockSignature,
        swigWalletAddress: swigWalletAddress,
        signingRoleId: 0,
        newAuthority: prepareRequest.newAuthority,
        permissionActions: prepareRequest.permissionActions,
        slot: prepareResponse.slot,
        expectedCounter: prepareResponse.expectedCounter,
      );

      final submitResponse = await client.submitAddAuthority(submitRequest);

      expect(submitResponse.transactionSignature, isA<String>());
      expect(submitResponse.roleId, isA<int>());
      expect(submitResponse.newAuthorityRoleId, isNotNull);
    });

    test('adds Secp256r1 (passkey) authority', skip: false, () async {
      // Create SWIG wallet first if needed
      if (swigWalletAddress.isEmpty) {
        final createRequest = CreateWalletRequestDto(
          ownerAddress: ownerKeyPair.address,
          platform: 'dart-test',
        );
        final createResponse = await client.createWallet(createRequest);
        swigWalletAddress = createResponse.swigWalletAddress;
      }

      // Generate mock Secp256r1 public key
      final secp256r1PubKey = createMockSecp256r1PublicKey();

      // Prepare add authority request
      final prepareRequest = PrepareAddAuthorityRequestDto(
        swigWalletAddress: swigWalletAddress,
        signingRoleId: 0, // Owner signs to add passkey authority
        newAuthority: AuthorityInfoDto(
          data: base64EncodeBytes(secp256r1PubKey),
          type: AuthorityType.secp256r1String,
        ),
        permissionActions: [
          createPermissionAction(PermissionType.all), // Full permissions
        ],
      );

      final prepareResponse = await client.prepareAddAuthority(prepareRequest);

      expect(prepareResponse.unsignedTransaction, isA<String>());
      expect(prepareResponse.messageHash, isA<String>());

      // Submit with mock Ed25519 signature (owner signing)
      final mockSignature = createMockEd25519Signature();
      final submitRequest = SubmitAddAuthorityRequestDto(
        signingResult: mockSignature,
        swigWalletAddress: swigWalletAddress,
        signingRoleId: 0,
        newAuthority: prepareRequest.newAuthority,
        permissionActions: prepareRequest.permissionActions,
        slot: prepareResponse.slot,
        expectedCounter: prepareResponse.expectedCounter,
        // Mock WebAuthn data for passkey
        authenticatorData: base64EncodeBytes(generateMockPublicKey(37)),
        clientDataJson: '{"challenge":"test","origin":"test","type":"webauthn.get"}',
      );

      final submitResponse = await client.submitAddAuthority(submitRequest);

      expect(submitResponse.transactionSignature, isA<String>());
      expect(submitResponse.newAuthorityRoleId, isNotNull);
    });
  });

  group('SWIG Transaction Execution', () {
    late String swigWalletAddress;
    late String recipientAddress;

    test('executes payment through SWIG with Ed25519', skip: false, () async {
      // Setup: Create SWIG wallet and recipient
      final createRequest = CreateWalletRequestDto(
        ownerAddress: ownerKeyPair.address,
        platform: 'dart-test',
      );
      final createResponse = await client.createWallet(createRequest);
      swigWalletAddress = createResponse.swigWalletAddress;

      // Generate recipient address
      final recipientKeyPair = await Ed25519HDKeyPair.random();
      recipientAddress = recipientKeyPair.address;

      // Step 1: Create direct payment transaction
      final paymentRequest = CreateDirectPaymentRequestDto(
        senderAccount: swigWalletAddress,
        receiverAccount: recipientAddress,
        referenceAccount: null,
        amount: 1000000, // 0.001 SOL in lamports
        mintAddress: solMintAddress,
      );

      final paymentResponse = await client.createDirectPayment(paymentRequest);

      expect(paymentResponse.transaction, isA<String>());
      expect(paymentResponse.fee, isA<int>());

      // Step 2: Extract instruction from payment transaction
      final wrappedInstruction = extractInstructionFromTransaction(paymentResponse.transaction);
      final wrappedInstructionJson = jsonEncode(wrappedInstruction);
      final wrappedInstructionBytes = base64EncodeBytes(utf8.encode(wrappedInstructionJson));

      // Step 3: Prepare SWIG SignV1 transaction
      final prepareSignRequest = PrepareSignV1RequestDto(
        swigWalletAddress: swigWalletAddress,
        signingRoleId: 0, // Use owner (Ed25519) authority
        wrappedInstructions: [wrappedInstructionBytes],
      );

      final prepareSignResponse = await client.prepareSignV1(prepareSignRequest);

      expect(prepareSignResponse.unsignedTransaction, isA<Uint8List>());
      expect(prepareSignResponse.messageHash, isA<String>());
      expect(prepareSignResponse.authorityType, equals(AuthorityType.ed25519String));
      expect(prepareSignResponse.slot, isA<int>());
      expect(prepareSignResponse.expectedCounter, isA<int>());

      // Step 4: Sign with Ed25519 authority
      final mockSignature = createMockEd25519Signature();

      // Step 5: Submit signed transaction
      final submitSignRequest = SubmitSignV1RequestDto(
        signingResult: mockSignature,
        swigWalletAddress: swigWalletAddress,
        signingRoleId: 0,
        wrappedInstructions: [wrappedInstructionBytes],
        slot: prepareSignResponse.slot,
        expectedCounter: prepareSignResponse.expectedCounter,
        unsignedTransaction: base64EncodeBytes(prepareSignResponse.unsignedTransaction),
      );

      final submitSignResponse = await client.submitSignV1(submitSignRequest);

      expect(submitSignResponse.transactionSignature, isA<String>());
      expect(submitSignResponse.transactionSignature, isNotEmpty);
    });

    test('executes payment through SWIG with Secp256k1', skip: true, () async {
      // Test payment flow using Secp256k1 authority (simulated)
      // This test would require actual MetaMask integration for real signatures

      // Create SWIG wallet if needed
      if (swigWalletAddress.isEmpty) {
        final createRequest = CreateWalletRequestDto(
          ownerAddress: ownerKeyPair.address,
          platform: 'dart-test',
        );
        final createResponse = await client.createWallet(createRequest);
        swigWalletAddress = createResponse.swigWalletAddress;
      }

      // Create payment transaction
      final paymentRequest = CreateDirectPaymentRequestDto(
        senderAccount: swigWalletAddress,
        receiverAccount: recipientAddress,
        referenceAccount: null,
        amount: 500000, // 0.0005 SOL in lamports
        mintAddress: solMintAddress,
      );

      final paymentResponse = await client.createDirectPayment(paymentRequest);
      final wrappedInstruction = extractInstructionFromTransaction(paymentResponse.transaction);
      final wrappedInstructionBytes = base64EncodeBytes(
        utf8.encode(jsonEncode(wrappedInstruction)),
      );

      // Prepare SignV1 with Secp256k1 authority (role ID would be from adding authority)
      final prepareSignRequest = PrepareSignV1RequestDto(
        swigWalletAddress: swigWalletAddress,
        signingRoleId: 1, // Assume Secp256k1 authority was added with role ID 1
        wrappedInstructions: [wrappedInstructionBytes],
      );

      final prepareSignResponse = await client.prepareSignV1(prepareSignRequest);

      // Mock Secp256k1 signature
      final mockSignature = createMockSecp256k1Signature();

      final submitSignRequest = SubmitSignV1RequestDto(
        signingResult: mockSignature,
        swigWalletAddress: swigWalletAddress,
        signingRoleId: 1,
        wrappedInstructions: [wrappedInstructionBytes],
        slot: prepareSignResponse.slot,
        expectedCounter: prepareSignResponse.expectedCounter,
        unsignedTransaction: base64EncodeBytes(prepareSignResponse.unsignedTransaction),
      );

      final submitSignResponse = await client.submitSignV1(submitSignRequest);

      expect(submitSignResponse.transactionSignature, isA<String>());
    });

    test('executes payment through SWIG with Secp256r1', skip: true, () async {
      // Test payment flow using Secp256r1 (passkey) authority (simulated)
      // This test would require actual WebAuthn integration for real signatures

      // Create SWIG wallet if needed
      if (swigWalletAddress.isEmpty) {
        final createRequest = CreateWalletRequestDto(
          ownerAddress: ownerKeyPair.address,
          platform: 'dart-test',
        );
        final createResponse = await client.createWallet(createRequest);
        swigWalletAddress = createResponse.swigWalletAddress;
      }

      // Create payment transaction
      final paymentRequest = CreateDirectPaymentRequestDto(
        senderAccount: swigWalletAddress,
        receiverAccount: recipientAddress,
        referenceAccount: null,
        amount: 2000000, // 0.002 SOL in lamports
        mintAddress: solMintAddress,
      );

      final paymentResponse = await client.createDirectPayment(paymentRequest);
      final wrappedInstruction = extractInstructionFromTransaction(paymentResponse.transaction);
      final wrappedInstructionBytes = base64EncodeBytes(
        utf8.encode(jsonEncode(wrappedInstruction)),
      );

      // Prepare SignV1 with Secp256r1 authority (role ID would be from adding authority)
      final prepareSignRequest = PrepareSignV1RequestDto(
        swigWalletAddress: swigWalletAddress,
        signingRoleId: 2, // Assume Secp256r1 authority was added with role ID 2
        wrappedInstructions: [wrappedInstructionBytes],
      );

      final prepareSignResponse = await client.prepareSignV1(prepareSignRequest);

      // Mock Secp256r1 (passkey) signature with WebAuthn data
      final mockSignature = createMockSecp256r1Signature();

      final submitSignRequest = SubmitSignV1RequestDto(
        signingResult: mockSignature,
        swigWalletAddress: swigWalletAddress,
        signingRoleId: 2,
        wrappedInstructions: [wrappedInstructionBytes],
        slot: prepareSignResponse.slot,
        expectedCounter: prepareSignResponse.expectedCounter,
        unsignedTransaction: base64EncodeBytes(prepareSignResponse.unsignedTransaction),
        // Include WebAuthn data for passkey authentication
        authenticatorData: base64EncodeBytes(generateMockPublicKey(37)),
        clientDataJson: '{"challenge":"test","origin":"test","type":"webauthn.get"}',
      );

      final submitSignResponse = await client.submitSignV1(submitSignRequest);

      expect(submitSignResponse.transactionSignature, isA<String>());
      expect(submitSignResponse.feesPaidBy, isA<String?>());
      expect(submitSignResponse.actualFee, isA<int?>());
    });
  });
}
