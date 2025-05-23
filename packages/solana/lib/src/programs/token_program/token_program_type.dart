import 'package:solana/solana.dart';

enum TokenProgramType { tokenProgram, token2022Program }

extension TokenProgramTypeExt on TokenProgramType {
  Ed25519HDPublicKey get id => switch (this) {
    TokenProgramType.tokenProgram => TokenProgram.id,
    TokenProgramType.token2022Program => Token2022Program.id,
  };

  String get programId => switch (this) {
    TokenProgramType.tokenProgram => TokenProgram.programId,
    TokenProgramType.token2022Program => Token2022Program.programId,
  };
}
