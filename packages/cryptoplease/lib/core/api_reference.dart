enum ApiReference { cryptoplease, solana }

ApiReference findReferenceByName(String name) => ApiReference.values.firstWhere(
      (ref) => ref.name == name,
      orElse: () => ApiReference.solana,
    );
