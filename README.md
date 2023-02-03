[![melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square)](https://github.com/invertase/melos)
[![Twitter Follow](https://img.shields.io/twitter/follow/espresso_cash?style=social)](https://twitter.com/espresso_cash)
[![Solana Dart developers discord](https://img.shields.io/discord/943071824525262849?label=Solana+Dart+developers+discord)](https://discord.gg/wK6WX7974J)

## Packages

- [cryptoplease]: full-fledged mobile wallet for iOS and Android on Solana built with [solana] library.
- [cryptoplease_link]: backend code for the Expresso Cash Universal Links protocol support.
- The [solana] library. This is the implementation of the Solana [transaction codec][transaction_codec] and the [JSON RPC api][json_rpc_api].
- The [jsonrpc_client] is used to generate the RPC api methods from their definitions. This technique helps us stick to the DRY principle very easily.
- The Borsh serialization package which is itself divided in two packages [borsh] and [borsh_annotation]. The former is a code generator that generates borsh serialization and deserialization for a Dart class. And the latter is an annotation used to annotate these classes.
- The [solana_mobile_wallet] and [solana_mobile_client] packages. The former is a reference implementation of the [Solana Mobile Wallet Adapter][mobile_wallet_spec], containing a [Fake Wallet][solana_mobile_wallet_example] to exemplify the scenario callbacks. The latter is the client-side implementation for the [solana_mobile_wallet] scenarios, also containing a [Fake DApp example][solana_mobile_client_example].
- The [solana_seed_vault] package, which implements the [Solana Seed Vault SDK][seed_vault_spec] for Flutter.

[cryptoplease]: packages/cryptoplease
[cryptoplease_link]: packages/cryptoplease_link
[borsh]: packages/borsh
[borsh_annotation]: packages/borsh_annotation
[jsonrpc_client]: packages/jsonrpc_client
[solana]: packages/solana
[solana_mobile_wallet]: packages/solana_mobile_wallet
[solana_mobile_client]: packages/solana_mobile_client
[solana_seed_vault]: packages/solana_seed_vault
[transaction_codec]: https://docs.solana.com/developing/programming-model/transactions
[json_rpc_api]: https://docs.solana.com/developing/clients/jsonrpc-api
[mobile_wallet_spec]: https://github.com/solana-mobile/mobile-wallet-adapter/blob/main/spec/spec.md
[seed_vault_spec]: https://github.com/solana-mobile/seed-vault-sdk/blob/main/docs/integration_guide.md
[solana_mobile_wallet_example]: packages/solana_mobile_wallet/example
[solana_mobile_client_example]: packages/solana_mobile_client/example
