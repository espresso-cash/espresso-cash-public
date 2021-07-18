# Dart library for Solana

This is the Solana library for dart using the [JSON RPC API](https://docs.solana.com/apps/jsonrpc-api)

Currently, it supports

- Getting the balance in SOL of an address
- Transferring SOL
- Listing all the transactions for a given address
- Generate a keypair from a 12 word mnemonic seed
- Sign transactions with the `SolanaWallet` object

### Our pub.dev package
We have [the package published here](https://pub.dev/packages/solana) if you like to use it in your project

### Documentation
You can find the documentation for the existing API [right here](https://pub.dev/documentation/solana/latest/)

## Publishing new version

- Use [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/)
- Run `melos version`. This will create a new commit with automatic changelog. Push the commit with the tag to the
  repository via PR.

## Testing

To run the tests you need to install the [Solana Tool Suite](https://docs.solana.com/cli/install-solana-cli-tools) and
start the test validator by calling

```shell
solana-test-validator
```

You can also create an image from [Dockerfile](Dockerfile) and run it.

## Next steps

We are actively working on the library and adding features to as well as fixing bugs.

The very next step is to build a layer to use SPL tokens as a `SolanaClient`