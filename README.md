[![melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square)](https://github.com/invertase/melos)
[![Twitter Follow](https://img.shields.io/twitter/follow/cryptopleasecom?style=social)](https://twitter.com/cryptopleasecom)
[![Discord](https://img.shields.io/discord/943071824525262849?label=Discord)](https://discord.gg/wK6WX7974J)

## Packages

- [cryptoplease](packages/cryptoplease): full-fledged mobile wallet for Solana built with [solana](packages/solana) library.
- [cryptoplease-ui](packages/cryptoplease-ui): UI library for mobile wallet.
- The [solana](packages/solana) library. This is the implementation of the Solana [transaction codec](https://docs.solana.com/developing/programming-model/transactions) and the [JSON RPC api](https://docs.solana.com/developing/clients/jsonrpc-api).
- The [jsonrpc_client](packages/jsonrpc_client) is used to generate the RPC api methods from their definitions. This technique helps us stick to the DRY principle very easily.
- The Borsh serialization package which is itself divided in two packages [borsh](packages/borsh) and [borsh_annotation](packages/borsh_annotation). The former is a code generator that generates borsh serialization and deserialization for a Dart class. And the latter is an annotation used to annotate these classes.
