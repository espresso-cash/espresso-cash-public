import 'package:solana/solana.dart';
import 'package:solana/src/anchor/instruction.dart';
import 'package:solana/src/anchor/programs/crypto_please/types/prepaid_notification.dart';
import 'package:solana/src/anchor/programs/crypto_please/types/send.dart';
import 'package:solana/src/encoder/account_meta.dart';
import 'package:solana/src/encoder/constants.dart';
import 'package:solana/src/rpc_client/transaction_signature.dart';

class PushNotifications {
  const PushNotifications(
    this._programId, {
    required String mainData,
  }) : _mainData = mainData;

  Future<TransactionSignature> prepaidNotification(
    RPCClient client,
    PrepaidNotification data, {
    required String vault,
    required String updater,
    required String payer,
    required List<Ed25519HDKeyPair> signers,
  }) async {
    final instructions = [
      await AnchorInstruction.forMethod(
        programId: _programId,
        method: 'prepaid_notification',
        arguments: data,
        accounts: <AccountMeta>[
          AccountMeta.writeable(pubKey: _mainData, isSigner: false),
          AccountMeta.writeable(pubKey: vault, isSigner: false),
          AccountMeta.readonly(pubKey: updater, isSigner: false),
          AccountMeta.readonly(pubKey: payer, isSigner: true),
          AccountMeta.readonly(
              pubKey: SystemProgram.programId, isSigner: false),
          AccountMeta.readonly(pubKey: Sysvar.rent, isSigner: false),
        ],
        namespace: 'global',
      )
    ];
    final message = Message(instructions: instructions);
    return client.signAndSendTransaction(message, signers);
  }

  Future<TransactionSignature> updateAndSend(
    RPCClient client,
    Send data, {
    required String updater,
    required String payer,
    required List<Ed25519HDKeyPair> signers,
  }) async {
    final instructions = [
      await AnchorInstruction.forMethod(
        programId: _programId,
        method: 'prepaid_notification',
        arguments: data,
        accounts: <AccountMeta>[
          AccountMeta.writeable(pubKey: _mainData, isSigner: false),
          AccountMeta.readonly(pubKey: updater, isSigner: false),
          AccountMeta.readonly(pubKey: payer, isSigner: true),
        ],
        namespace: 'global',
      )
    ];
    final message = Message(instructions: instructions);
    return client.signAndSendTransaction(message, signers);
  }

  Future<TransactionSignature> send(
    RPCClient client,
    Send data, {
    required String vault,
    required String payer,
    required List<Ed25519HDKeyPair> signers,
  }) async {
    final instructions = [
      await AnchorInstruction.forMethod(
        programId: _programId,
        method: 'prepaid_notification',
        arguments: data,
        accounts: <AccountMeta>[
          AccountMeta.writeable(pubKey: _mainData, isSigner: false),
          AccountMeta.readonly(pubKey: vault, isSigner: false),
          AccountMeta.readonly(pubKey: payer, isSigner: true),
          AccountMeta.readonly(
              pubKey: SystemProgram.programId, isSigner: false),
          AccountMeta.readonly(pubKey: Sysvar.rent, isSigner: false),
        ],
        namespace: 'global',
      )
    ];
    final message = Message(instructions: instructions);
    return client.signAndSendTransaction(message, signers);
  }

  final String _programId;
  final String _mainData;
}
