import 'package:solana/solana.dart';
import 'package:solana/src/crypto/ed25519_hd_public_key.dart';
import 'package:solana/src/encoder/account_meta.dart';
import 'package:solana/src/encoder/byte_array.dart';
import 'package:solana/src/encoder/constants.dart';
import 'package:solana/src/encoder/instruction.dart';
import 'package:solana/src/programs/associated_token_account_program/program.dart';
import 'package:solana/src/programs/cove_program/program.dart';
import 'package:solana/src/programs/system_program/program.dart';
import 'package:solana/src/programs/token_program/program.dart';

class CoveInstruction extends Instruction {
  /// Create an instruction for the [cove][1] program.
  ///
  /// [company_owner] is the public key that owns the company
  /// [company] is the public key of the company (pda)
  /// [collection_ref] is the address to the collection mint (pda) "mint-collection", company.key().as_ref(), collection_name.as_bytes()
  /// [model] is the address to the model account (pda), company.key().as_ref(), collection_ref.key().as_ref(), model_name.as_bytes()
  /// [product_mint] is the address to the product mint (pda), "mint-product",model.key().as_ref(), ref_id.as_bytes()
  /// [from_account] is the address to the associated token account of the product, associated_token::mint product_mint, associated_token::authority = product.to_account_info(), associated_token::token_program = token_program
  /// [to_account] is the address to the associated token account of the new_user, associated_token::mint product_mint, associated_token::authority = new_user, associated_token::token_program = token_program
  /// [product] is the address to the products onboard wallet, it has enough sol token to pay for the transaction
  /// [new_user] is the address to the new user that the nft will be minted to
  /// [nft_authority] is the address to the nft authority that can perform the transfer (pda)
  ///
  factory CoveInstruction.registerProduct({
    required Ed25519HDPublicKey company_owner,
    required Ed25519HDPublicKey company,
    required Ed25519HDPublicKey collection_ref,
    required Ed25519HDPublicKey model,
    required Ed25519HDPublicKey product_mint,
    required Ed25519HDPublicKey from_account,
    required Ed25519HDPublicKey to_account,
    required Ed25519HDPublicKey product,
    required Ed25519HDPublicKey new_user,
    required Ed25519HDPublicKey nft_authority,
  }) =>
      CoveInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: company_owner, isSigner: false),
          AccountMeta.writeable(pubKey: company, isSigner: false),
          AccountMeta.readonly(pubKey: collection_ref, isSigner: false),
          AccountMeta.readonly(pubKey: model, isSigner: false),
          AccountMeta.readonly(pubKey: product_mint, isSigner: false),
          AccountMeta.readonly(pubKey: from_account, isSigner: false),
          AccountMeta.readonly(pubKey: to_account, isSigner: false),
          AccountMeta.readonly(pubKey: product, isSigner: true),
          AccountMeta.readonly(pubKey: new_user, isSigner: false),
          AccountMeta.readonly(pubKey: nft_authority, isSigner: false),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(
              Token2022Program.id.toBase58(),
            ),
            isSigner: false,
          ),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(
              AssociatedTokenAccountProgram.id.toBase58(),
            ),
            isSigner: false,
          ),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(
              Token2022Program.id.toBase58(),
            ),
            isSigner: false,
          ),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(SystemProgram.programId),
            isSigner: false,
          ),
        ],
      );

  CoveInstruction._({
    required super.accounts,
  }) : super(
          programId: CoveProgram.id,
          data: const ByteArray.empty(),
        );
}
