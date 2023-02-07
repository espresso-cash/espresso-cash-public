[![Pub Version](https://img.shields.io/pub/v/solana)](https://pub.dev/packages/solana)
[![codecov](https://codecov.io/gh/espresso-cash/espresso-cash-public/branch/master/graph/badge.svg?token=8UF2LVQMS7)](https://codecov.io/gh/espresso-cash/espresso-cash-public)
[![Twitter Follow](https://img.shields.io/twitter/follow/espresso_cash?style=social)](https://twitter.com/espresso_cash)
[![Discord](https://img.shields.io/discord/943071824525262849?label=Discord)](https://discord.gg/wK6WX7974J)

### Dart library for Solana

Implements the following features:

- Complete implementation of the [JSON RPC api](https://docs.solana.com/developing/clients/jsonrpc-api).
- Complete implementation of a subscription client (using the JSON RPC subscription variant of the API).
- Complete implementation of the following programs
  - System Program
  - Token Program
  - Memo Program
  - Stake Program
  - Associated Token Account Program
- Support for key generation/importing using Hierarchical Deterministic derivation.
- Support for importing keys by using a bip39 seed phrase.
- Support for importing keys by using raw private key bytes.
- Transaction encoding and signing.
- Building and signing offline transactions, as well as convenience methods to sign and send the transaction. Also, the ability to listen for a status change on a given signature. The latter can be used to wait for a transaction to be in the _confirmed_ or _finalized_ state.
- Support for decoding [Metaplex](https://www.metaplex.com/) NFT metadata.

### Adding other programs

Other programs can easily be added to these by implementing their instructions and sometimes additional methods that use two or more instructions. The convention is to create 1 directory child of the [programs](lib/src/programs) directory.

The subdirectory shall be called `${program_name}_program` and it should contain 2 files, `${program_name}_program.dart` and `${program_name}_instructions.dart`.

Each of these files will have one or more factory constructors that build messages with one or more instructions for the `_program.dart` file or single instructions for the `_instructions.dart` file.

Additional files may be included in case the author thinks that it is important to somehow separate some code from the definitions.

### Updating the RPC client

If you notice that there is a missing RPC method in the RPC client or that, the RPC client has outdated and no longer valid methods you can submit a Pull Request with the adequate change to update it. In case of the deletion it is pretty much straight forward.

In case of an addition you have to add the method to the [client.dart](https://github.com/espresso-cash/espresso-cash-public/tree/master/packages/solana/lib/src/rpc/client.dart) .

For additions just add the method definition to the abstract class in [client.dart](https://github.com/espresso-cash/espresso-cash-public/tree/master/packages/solana/lib/src/rpc/client.dart) and rebuild the package. The implementation will be automatically generated for you.

Parameters are specified in the method definition by writing normal dart code however, some methods may require the creation of new types for parameters or responses, in this case please put the definitions of such classes in the [dto](https://github.com/espresso-cash/espresso-cash-public/tree/master/packages/solana/lib/src/rpc/dto/) directory.

### Contributing

All your contributions are welcome, no matter how tiny if it helps the community to have a high quality full feature library for solana it will be considered. Please submit a Pull Request if you want to help ;)

### Further Help & Documentation

We tried to document most of the important things, so please go to [pub.dev](https://pub.dev/documentation/solana/latest/) and browse the documentation if you need help. If you still don't find the answer, please feel free to ask us.

Also, join our [Solana Dart developers](https://discord.gg/wK6WX7974J) Discord server.

## Testing

To run the tests you need to install the [Solana Tool Suite](https://docs.solana.com/cli/install-solana-cli-tools) and start the test validator by calling

```shell
solana-test-validator
```

You can also use `solanalabs/solana` Docker image.

## Publishing new version (for maintainers)

- Use [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/)
- Run `melos version`. This will create a new commit with automatic changelog. Push the commit with the tag to the repository via PR.
