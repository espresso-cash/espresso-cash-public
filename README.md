[![melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square)](https://github.com/invertase/melos)

## Packages

This is a collection of packages necessary to build Solana enabled applications in dart or flutter.

The core package is the _solana_ package. It contains an implementation of all the needed api to interact with the
solana blockchain.

We split the package in such a way that it is clear what each class or function should be used for. The encoding classes
are separate from the rpc endpoints responses, even if some times it looks like the types are exactly the same, an
accurate representation is easier with this separation.

- The [solana](https://github.com/cryptoplease/cryptoplease-dart/tree/master/packages/solana) library. This is the
  implementation of the Solana [transaction codec](https://docs.solana.com/developing/programming-model/transactions)
  and the [JSON RPC api](https://docs.solana.com/developing/clients/jsonrpc-api).
- The [jsonrpc_client](https://github.com/cryptoplease/cryptoplease-dart/tree/master/packages/jsonrpc_client) is used to
  generate the RPC api methods from their definitions. This technique helps us stick to the DRY principle very easily.
- The Borsh serialization package which is itself divided in two
  packages [borsh](https://github.com/cryptoplease/cryptoplease-dart/tree/master/packages/borsh)
  and [borsh_annotation](https://github.com/cryptoplease/cryptoplease-dart/tree/master/packages/borsh_annotation). The
  former is a code generator that generates borsh serialization and deserialization for a Dart class. And the latter is
  an annotation used to annotate these classes.

### The [solana](https://github.com/cryptoplease/cryptoplease-dart/tree/master/packages/solana) package

Implements the following features,

- Complete implementation of the [JSON RPC api](https://docs.solana.com/developing/clients/jsonrpc-api).
- Complete implementation of a subscription client (using the JSON RPC subscription variant of the API).
- Complete implementation of the following programs
    - System Program
    - Token Program
    - Memo Program
    - Stake Program
    - Associated Token Account Program
- Support for key generation/importation using Hierarchical Deterministic derivation.
- Support for importing keys by using a bip39 seed phrase.
- Support for importing keys by using raw private key bytes.
- Transaction encoding and signing.
- Building and signing offline transactions, as well as convenience methods to sign and send the transaction. Also, the
  ability to listen for a status change on a given signature. The latter can be used to wait for a transaction to be in
  the _confirmed_ or _finalized_ state.
- Support for decoding [Metaplex](https://www.metaplex.com/) NFT metadata.

### Adding other programs

Other programs can easily be added to these by implementing their instructions and sometimes additional methods that use
two or more instructions. The convention is to create 1 directory child of
the [programs](https://github.com/cryptoplease/cryptoplease-dart/tree/master/packages/solana/lib/src/programs)
directory.

The subdirectory shall be called `${program_name}_program` and it should contain 2 files, `${program_name}_program.dart`
and `${program_name}_instructions.dart`.

Each of these files will have one or more factory constructors that build messages with one or more instructions for
the `_program.dart` file or single instructions for the `_instructions.dart` file.

Additional files may be included in case the author thinks that it is important to somehow separate some code from the
definitions.

### Updating the RPC client

If you notice that there is a missing RPC method in the RPC client or that, the RPC client has outdated and no longer
valid methods you can submit a Pull Request with the adequate change to update it. In case of the deletion it is pretty
much straight forward.

In case of an addition you have to add the method to
the [client.dart](https://github.com/cryptoplease/cryptoplease-dart/tree/master/packages/solana/lib/src/rpc/client.dart)
.

For additions just add the method definition to the abstract class
in [client.dart](https://github.com/cryptoplease/cryptoplease-dart/tree/master/packages/solana/lib/src/rpc/client.dart)
and rebuild the package. The implementation will be automatically generated for you.

Parameters are specified in the method definition by writing normal dart code however, some methods may require the
creation of new types for parameters or responses, in this case please put the definitions of such classes in
the [dto](https://github.com/cryptoplease/cryptoplease-dart/tree/master/packages/solana/lib/src/rpc/dto/) directory.

### Contributing

All your contributions are welcome, no matter how tiny if it helps the community to have a high quality full feature
library for solana it will be considered. Please submit a Pull Request if you want to help ;)

### Further Help & Documentation

We tried to document most of the important things, so please go to [pub.dev](https://pub.dev/packages/solana/score) and
browse the documentation if you need help. If you still don't find the answer, please feel free to ask us.