[![melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square)](https://github.com/invertase/melos)

## Packages

This is a collection of packages necessary to build Solana enabled applications in dart or flutter.

The core package is the `solana` package. It contains an implementation of all the needed api to interact with the solana blockchain.

We split the package in such a way that it is clear what each class or function should be used for. The encoding classes are separate from the RPC endpoints responses, even if some times it looks like the types are exactly the same, an accurate representation is easier with this separation.

- The [solana](packages/solana) library. This is the implementation of the Solana [transaction codec](https://docs.solana.com/developing/programming-model/transactions) and the [JSON RPC api](https://docs.solana.com/developing/clients/jsonrpc-api).
- The [jsonrpc_client](packages/jsonrpc_client) is used to generate the RPC api methods from their definitions. This technique helps us stick to the DRY principle very easily.
- The Borsh serialization package which is itself divided in two packages [borsh](packages/borsh) and [borsh_annotation](packages/borsh_annotation). The former is a code generator that generates borsh serialization and deserialization for a Dart class. And the latter is an annotation used to annotate these classes.
