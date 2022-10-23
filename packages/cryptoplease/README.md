# EspressoCash

[![E2E tests](https://github.com/cryptoplease/cryptoplease-dart/actions/workflows/e2e_tests.yml/badge.svg)](https://github.com/cryptoplease/cryptoplease-dart/actions/workflows/e2e_tests.yml)
[![Twitter Follow](https://img.shields.io/twitter/follow/cryptopleasecom?style=social)](https://twitter.com/cryptopleasecom)
[![Discord](https://img.shields.io/discord/943071824525262849?label=Discord)](https://discord.gg/wK6WX7974J)

[<img src="https://cdn.animaapp.com/projects/60f68843e4a8f4765ef9aee6/releases/62063634af75239eab619754/img/apple-appstore@2x.png" width="153">](https://apps.apple.com/us/app/crypto-please/id1559625715)
[<img src="https://cdn.animaapp.com/projects/60f68843e4a8f4765ef9aee6/releases/62063634af75239eab619754/img/googleplay-store@2x.png" width="153">](https://play.google.com/store/apps/details?id=com.pleasecrypto.flutter)

EspressoCash Wallet is the first crypto wallet that allows users to send crypto with just a link. You can send and receive any Solana tokens like SOL tokens and also SPL tokens. You can receive NFT as well! Our wallet is totally non-custodial which means that only you own your funds. EspressoCash Wallet is available on all platforms.

Other features include:

- Send Crypto with just a link
- Create a new wallet
- Import your existing wallet by typing your recovery phrase (12 words or 24 words)
- Send and Receive SOL Token
- Send and Receive SPL Tokens like USDT, USDC
- History of transactions

## Architecture overview

We use BLoC-inspired architecture with BLoCs as pure business-logic components and Functional Programming principles in mind.

All the states and events are immutable `freezed` classes.

## `cryptoplease` package structure

### `core`

Core feature modules, other feature modules are free to depend on them.

### `features`

Feature modules. They are free to depend on `core` modules, but the dependencies on other `feature` modules should be avoided.

### `l10n`

Everything related to the localization and internationalization.

### `app`

Main app screens. It should be kept minimal and serve as an entrypoint to features.

## Running

1. Clone the project.
2. run `make app_get app_build`.
3. Run the application.

## Tests

1. Running unit and golden tests:

   ```sh
   make flutter_generate_test_schemas flutter_test
   ```

2. Running solana-related integration tests (make sure that local solana instance is installed and running):

   ```sh
   # Ensure that SOLANA_RPC_URL and SOLANA_WEBSOCKET_URL environment variables are set
   make flutter_test_solana
   ```

3. Running E2E tests:

   ```sh
   make flutter_test_e2e
   ```
