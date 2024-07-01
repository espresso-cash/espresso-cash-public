import 'package:solana/solana.dart';

enum TokenProgramType {
  tokenProgram,
  token2022Program,
}

extension TokenProgramTypeExt on TokenProgramType {
  Ed25519HDPublicKey get id {
    switch (this) {
      case TokenProgramType.tokenProgram:
        return TokenProgram.id;
      case TokenProgramType.token2022Program:
        return Token2022Program.id;
    }
  }

  String get programId {
    switch (this) {
      case TokenProgramType.tokenProgram:
        return TokenProgram.programId;
      case TokenProgramType.token2022Program:
        return Token2022Program.programId;
    }
  }
}
