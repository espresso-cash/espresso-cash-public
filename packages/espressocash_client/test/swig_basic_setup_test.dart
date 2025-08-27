import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart' hide AuthorityType;
import 'package:test/test.dart';

import 'utils.dart';

/// Basic SWIG wallet setup test that mirrors the wallet setup interface.
///
/// This test demonstrates the complete flow shown in the UI with real blockchain interactions:
/// 1. Generate Owner Wallet
/// 2. Airdrop to Owner (real Solana RPC call)
/// 3. Create SWIG Wallet (prepare unsigned transaction)
/// 4. Sign and send SWIG creation transaction to blockchain
/// 5. Airdrop to SWIG (real Solana RPC call)
/// 6. Display final addresses and balances (real on-chain data)
///
/// Prerequisites:
/// - Solana test validator running on localhost:8899
/// - Backend running on localhost:8080
void main() {
  test('SWIG Basic Setup Flow', () async {
    EspressoCashClient client;
    Ed25519HDKeyPair ownerKeyPair;
    RpcClient rpcClient;

    print('🚀 Starting SWIG Basic Setup Flow...\n');

    // Initialize Solana RPC client for localnet
    const localnetRpcUrl = 'http://localhost:8899';
    rpcClient = RpcClient(localnetRpcUrl);
    print('🔗 Connected to Solana localnet: $localnetRpcUrl');

    // Step 1: Generate Owner Wallet
    print('📝 Step 1: Generate Owner Wallet');
    ownerKeyPair = await Ed25519HDKeyPair.random();
    print('✅ Owner wallet generated');
    print('   Address: ${ownerKeyPair.address}');

    // Initialize client
    client = await createClient(local: true, keyPair: ownerKeyPair);
    await client.login();
    print('✅ Client authenticated\n');

    // Step 2: Airdrop to Owner (real RPC call)
    print('📝 Step 2: Airdrop to Owner');
    try {
      final airdropSignature = await rpcClient.requestAirdrop(
        ownerKeyPair.address,
        lamportsPerSol, // 1 SOL
        commitment: Commitment.confirmed,
      );
      print('✅ Owner airdrop completed');
      print('   Transaction: ${airdropSignature.substring(0, 16)}...');
      
      // Wait a bit for confirmation to propagate
      await Future<void>.delayed(const Duration(seconds: 2));
      
      // Check actual balance
      final ownerBalanceResult = await rpcClient.getBalance(
        ownerKeyPair.address,
        commitment: Commitment.confirmed,
      );
      final ownerBalance = ownerBalanceResult.value;
      final ownerSolBalance = ownerBalance / lamportsPerSol;
      print('   Balance: ${ownerSolBalance.toStringAsFixed(4)} SOL\n');
    } catch (e) {
      print('❌ Owner airdrop failed: $e');
      print('⚠️  Make sure Solana test validator is running on localhost:8899\n');
      rethrow;
    }

    // Step 3: Create SWIG Wallet
    print('📝 Step 3: Create SWIG Wallet');
    final createRequest = CreateWalletRequestDto(
      ownerAddress: ownerKeyPair.address,
      platform: 'dart-test-setup',
    );

    final createResponse = await client.createWallet(createRequest);
    final swigWalletAddress = createResponse.swigWalletAddress;

    print('✅ SWIG wallet request created');
    print('   SWIG Address: $swigWalletAddress');
    print('   Unsigned Transaction: ${createResponse.unsignedTransaction.substring(0, 32)}...');

    // Step 3.1: Sign and send the SWIG wallet creation transaction
    print('📝 Step 3.1: Sign and send SWIG creation transaction');
    try {
      // Decode the unsigned transaction to get the message
      final unsignedTx = SignedTx.decode(createResponse.unsignedTransaction);
      
      // Decompile the message from the backend
      final message = unsignedTx.decompileMessage();
      
      // Get a fresh blockhash since the backend's blockhash may be stale
      final latestBlockhash = await rpcClient.getLatestBlockhash(commitment: Commitment.confirmed);
      
      // Recompile the message with the fresh blockhash
      final compiledMessage = message.compile(
        recentBlockhash: latestBlockhash.value.blockhash,
        feePayer: ownerKeyPair.publicKey,
      );
      
      // Sign the compiled message with fresh blockhash
      final messageBytes = compiledMessage.toByteArray();
      final signature = await ownerKeyPair.sign(messageBytes);
      
      final signedTx = SignedTx(
        signatures: [signature],
        compiledMessage: compiledMessage,
      );
      
      // Send the signed transaction
      final createTxSignature = await rpcClient.sendTransaction(
        signedTx.encode(),
        preflightCommitment: Commitment.confirmed,
      );
      
      print('✅ SWIG wallet creation transaction sent');
      print('   Transaction: ${createTxSignature.substring(0, 16)}...');
      
      // Wait for confirmation (optional - helps ensure wallet exists before airdrop)
      await Future<void>.delayed(const Duration(seconds: 2));
      
    } catch (e) {
      print('❌ SWIG wallet creation transaction failed: $e');
      print('⚠️  The SWIG wallet may not exist on-chain');
      rethrow;
    }
    print('');

    // Step 5: Airdrop to SWIG (real RPC call)
    print('📝 Step 5: Airdrop to SWIG');
    try {
      final swigAirdropSignature = await rpcClient.requestAirdrop(
        swigWalletAddress,
        lamportsPerSol, // 1 SOL
        commitment: Commitment.confirmed,
      );
      print('✅ SWIG airdrop completed');
      print('   Transaction: ${swigAirdropSignature.substring(0, 16)}...');
      
      // Check actual SWIG balance
      final swigBalanceResult = await rpcClient.getBalance(
        swigWalletAddress,
        commitment: Commitment.confirmed,
      );
      final swigBalance = swigBalanceResult.value;
      final swigSolBalance = swigBalance / lamportsPerSol;
      print('   Balance: ${swigSolBalance.toStringAsFixed(4)} SOL\n');
    } catch (e) {
      print('❌ SWIG airdrop failed: $e');
      print('⚠️  Make sure Solana test validator is running\n');
      rethrow;
    }

    // Step 6: Display Final Status with real balances
    print('🎉 SWIG Setup Complete!\n');
    print('=' * 60);
    print('📋 FINAL WALLET STATUS');
    print('=' * 60);
    print('');
    
    // Get current balances
    final finalOwnerBalanceResult = await rpcClient.getBalance(
      ownerKeyPair.address,
      commitment: Commitment.confirmed,
    );
    final finalOwnerBalance = finalOwnerBalanceResult.value / lamportsPerSol;
    
    final finalSwigBalanceResult = await rpcClient.getBalance(
      swigWalletAddress,
      commitment: Commitment.confirmed,
    );
    final finalSwigBalance = finalSwigBalanceResult.value / lamportsPerSol;
    
    print('👤 Owner Wallet:');
    print('   Address: ${ownerKeyPair.address}');
    print('   Balance: ${finalOwnerBalance.toStringAsFixed(4)} SOL');
    print('');
    print('🏗️  SWIG Wallet:');
    print('   Address: $swigWalletAddress');
    print('   Balance: ${finalSwigBalance.toStringAsFixed(4)} SOL');
    print('');
    print('✅ Ready for authority management and transactions!');
    print('=' * 60);

    // Step 7: Get and display wallet authorities
    print('\n📝 Step 7: Get SWIG Wallet Authorities');
    final authoritiesRequest = GetWalletAuthoritiesRequestDto(
      swigWalletAddress: swigWalletAddress,
    );
    
    final authoritiesResponse = await client.getWalletAuthorities(authoritiesRequest);
    print('✅ Retrieved wallet authorities');
    print('   Total authorities: ${authoritiesResponse.authorities.length}');
    print('');
    
    for (int i = 0; i < authoritiesResponse.authorities.length; i++) {
      final authority = authoritiesResponse.authorities[i];
      print('   🔑 Authority ${i + 1}:');
      print('      Role ID: ${authority.roleId}');
      print('      Type: ${authority.authorityType}');
      print('      Permissions: ${authority.permissions.length} permission(s)');
      
      for (int j = 0; j < authority.permissions.length; j++) {
        final permission = authority.permissions[j];
        print('         • Permission ${j + 1}: Type ${permission.permissionType}');
        final dataPreview = permission.permissionData.length > 32 
            ? '${permission.permissionData.substring(0, 32)}...' 
            : permission.permissionData;
        print('           Data: $dataPreview');
      }
      print('');
    }

    // Verify the addresses are valid
    expect(ownerKeyPair.address, isA<String>());
    expect(ownerKeyPair.address, hasLength(44)); // Base58 Solana address length
    expect(swigWalletAddress, isA<String>());
    expect(swigWalletAddress, hasLength(44));
    expect(createResponse.unsignedTransaction, isNotEmpty);

    // Verify addresses are different
    expect(swigWalletAddress, isNot(equals(ownerKeyPair.address)));
    
    // Verify both wallets have positive balances
    expect(finalOwnerBalance, greaterThan(0));
    expect(finalSwigBalance, greaterThan(0));

    // Verify authorities response
    expect(authoritiesResponse.authorities, isA<List<SWIGAuthorityDto>>());
    expect(authoritiesResponse.authorities, isNotEmpty);
    expect(authoritiesResponse.authorities.length, greaterThan(0));
    
    // Verify the first authority is properly configured
    final firstAuthority = authoritiesResponse.authorities.first;
    expect(firstAuthority.roleId, isA<int>());
    expect(firstAuthority.authorityType, isA<String>());
    expect(firstAuthority.authorityType, isNotEmpty);
    expect(firstAuthority.permissions, isA<List<PermissionActionDto>>());

    print('\n✅ All validations passed!');
    print('🚀 SWIG wallet setup completed successfully with real blockchain interactions!');
  });
}
