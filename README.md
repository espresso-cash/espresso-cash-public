Cryptoplease Dart Packages

This is a collection of packages necessary to build Solana enabled applications in dart or flutter.

Currently it is composed of 2 packages,

- The Borsh serialization package which is itself divided in two packages [borsh](https://github.com/cryptoplease/cryptoplease-dart/tree/master/packages/borsh) and [borsh_annotation](https://github.com/cryptoplease/cryptoplease-dart/tree/master/packages/borsh_annotation). The former is a code generator that generates borsh serialization and deserialization for a Dart class. And the latter is an annotation used to annotate these classes.
- The [solana](https://github.com/cryptoplease/cryptoplease-dart/tree/master/packages/solana) library. This is the implementation of the Solana [transaction codec](https://docs.solana.com/developing/programming-model/transactions) and the [JSON RPC api](https://docs.solana.com/developing/clients/jsonrpc-api).
