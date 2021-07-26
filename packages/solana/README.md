# Dart library for Solana

This is the Solana library for dart using the [JSON RPC API](https://docs.solana.com/apps/jsonrpc-api)

Currently, it supports

- Creating arbitrary transactions with an API similar to that of the Rust SDK.
- Partial implementation of the system program. Transfer and Create Account instructions for the current version.  
- Partial implementation of the SPL token program.
- Memo program.  
- Manually writing anchor compatible programs through a simple API.
- Generating a keypair from a 12 word mnemonic seed.
- Partial RPC Api implementation.

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

Complete the RPC api and implement all methods. Implement all methods in the System program and SPL Token program.
