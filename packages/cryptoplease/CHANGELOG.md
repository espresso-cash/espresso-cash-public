## 1.41.0

 - **FIX**: make system status bar transparent (#392).
 - **FIX**: add padding at the bottom of 'Select Token' list (#391).
 - **FIX**: fixed jank on swap page   (#386).
 - **FIX**: update failing e2e test (#384).
 - **FIX**: recover from error on incoming payment (#371).
 - **FIX**: request-pay info icon (#357).
 - **FIX**: add balance refresh on menu screen, reuse refresh logic (#366).
 - **FIX**: menu page when startup (#356).
 - **FIX**: font-size for numeric pad is 24 (#346).
 - **FIX**: size of buttons and remove uppercase (#347).
 - **FIX**: change size of button in menu (#348).
 - **FIX**: chevron color in menu (#349).
 - **FIX**: Make profile screen fullscreen dialog.
 - **FEAT**: redesign screens when receiving crypto from a link (#396).
 - **FEAT**: switch to payment api for usdc transfers (#381).
 - **FEAT**: add SignedTx.decode (#388).
 - **FEAT**: add cryptoplease_api (#377).
 - **FEAT**: moonpay sign logic on cryptoplease_link, allow buy usdc (#370).
 - **FEAT**: improve design on request-pay screen (#359).
 - **FEAT**: change amount format in menu screen (#352).
 - **FEAT**: keep request and pay buttons enabled (#353).
 - **FEAT**: change bottom menu arrangement (#351).
 - **FEAT**: remove stablecoin selector, set usdc as default token (#350).
 - **DOCS**: updated readme (#355).

## 1.40.0

 - **FIX**: home tabs.
 - **FIX**: Update tx handling.
 - **FEAT**: add new screen for request and pay (#332).
 - **FEAT**: new menu and profile screens (#335).
 - **FEAT**: use roboto font as default (#329).
 - **FEAT**: remove NFT tab (#330).

## 1.39.0

 - **FIX**: properly clear navigation stack after creating link (#331).
 - **FEAT**: switch to Firebase dynamic links.

## 1.38.1

 - **FIX**: Fix iOS deeplink parsing on start (#320).
 - **FIX**: predefined input tokens, invert amount on swap flow (#299).
 - **FIX**: swap keyboard above navbar (#319).

## 1.38.0

 - **REFACTOR**: Update structure (#311).
 - **FIX**: improves swap ux flow (#297).
 - **FIX**: sort token list in swap flow (#298).
 - **FEAT**: Add analytics for swap (#312).

## 1.37.0

 - **REFACTOR**: Bump solana.
 - **FEAT**: Add build number to version section.
 - **FEAT**: add swap token flow (#255).

## 1.36.0

- **REFACTOR**: Migrate to Dart 2.17 (#271).
- **REFACTOR**: Update API URL config (#268).
- **REFACTOR**: Add transactionId to PaymentRequest (#267).
- **FIX**: Buffer to ByteArray (#266).

## 1.35.0

- **REFACTOR**: Extract link hosts as constants.
- **REFACTOR**: Bump mews_pedantic.
- **FIX**: change share text for request payment (#253).
- **FIX**: fix label receive to request (#249).
- **FEAT**: Add InstallLinkManager.
- **FEAT**: Support new links schemes.
- **FEAT**: add fee in dolar currency (#233).

## 1.34.1

- **FIX**: Clear payment requests on log out (#247).
- **FIX**: Process initial pending request (#246).

## 1.34.0

- **FIX**: Pass initial token for link transfer (#244).
- **FIX**: Show fiat amount in payment request message (#242).
- **FEAT**: Update solana pay links format (#243).

## 1.33.1

- **FIX**: Enable receive flow for prod.

## 1.33.0

> Note: This release has breaking changes.

- **REFACTOR**: Restructure SolanaClient (#230).
- **REFACTOR**: Extract TokenFiatInputWidget (#224).
- **FIX**: QR code flow for NFT (#234).
- **FEAT**: Implement payment requests (#241).
- **FEAT**: Update Solana pay support (#235).
- **FEAT**: Add stub RequestAmountScreen (#225).
- **FEAT**: Update payer name screen (#222).
- **FEAT**: Initial screens for payments requests (#220).
- **BREAKING** **REFACTOR**: Update tokens and client (#228).
- **BREAKING** **REFACTOR**: Update parameters names in instructions (#227).
- **BREAKING** **REFACTOR**: Update types (#226).

## 1.32.0

- **REFACTOR**: Simplify SplashScreen (#216).
- **REFACTOR**: Remove unused l10n keys.
- **REFACTOR**: Rename activities to notifications.
- **REFACTOR**: Restructure transactions (#207).
- **REFACTOR**: Restructure components (#206).
- **REFACTOR**: Extract CpHeaderedList (#205).
- **FIX**: Remove debounce (#214).
- **FEAT**: improve QR code scan flow on address input (#201).
- **FEAT**: Update NFT handling (#204).
- **DOCS**: Fix twitter link.

## 1.31.0

- **REFACTOR**: Extract loadNftCollection (#199).
- **REFACTOR**: Extract parsing logic to QrScannerRequest (#198).
- **REFACTOR**: Extract snackbars to cryptoplease_ui (#197).
- **FIX**: Fix transfers routing.
- **FIX**: Update NFT description in notifications.
- **FEAT**: Add sending NFT (#200).
- **FEAT**: Add app packages (#196).
- **DOCS**: Add badges.
- **DOCS**: Fix typos in readme.
- **DOCS**: Update readme.
- **DOCS**: Update badge.

## 1.30.0

- **FEAT**: Initial open-source release.
