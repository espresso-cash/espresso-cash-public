# Dart library for Solana

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

For more information view the library [documentation](https://pub.dev/documentation/solana_dart/latest/)
