## 1.75.0

 - **REFACTOR**: update lint rules.
 - **FEAT**: update ramp network to latest version (#986).

## 1.74.1

 - **REFACTOR**: update linter.
 - **REFACTOR**: remove unused method.

## 1.74.0

 - **REFACTOR**: migrate to Dart 3 and Flutter 3.10 (#981).
 - **FIX**: update scenario handler.
 - **FEAT**: add custom icon to back button (#973).
 - **FEAT**: update second link animation (#972).
 - **FEAT**: add coingecko l10n support for token details page (#975).

## 1.73.0

 - **FIX**: second link animation artifacts (#960).
 - **FIX**: update l10n key.
 - **FEAT**: token details page enhancements  (#961).
 - **FEAT**: truncate usdc amount on messages (#959).

## 1.72.0

 - **FIX**: correctly sign old cancellation tx (#957).
 - **FEAT**: update sign in with saga flow (#958).

## 1.71.0

 - **FEAT**: don't show manual input button after first qr scanned (#954).

## 1.70.0

 - **FEAT**: update solanapay host (#951).

## 1.69.0

 - **FIX**: center iskp screen content (#887).
 - **FIX**: add safe area to screens (#917).
 - **FIX**: update iskp failure reason (#886).
 - **FIX**: investment header overflow  (#896).
 - **FIX**: usdc conversion rate on wallet main flow (#870).
 - **FIX**: add padding on navigation bar overlap (#868).
 - **FIX**: remove blank home screen after keyboard interaction (#906).
 - **FEAT**: updated token chart design (#929).
 - **FEAT**: update splash screen (#937).
 - **FEAT**: use smart contract for escrow payments app (#894).
 - **FEAT**: add mobile wallet adapter to app (#873).
 - **FEAT**: add seed vault integration (#851).
 - **FEAT**: remove intercom (#948).
 - **FEAT**: remove duplicate edit profile menu option (#918).
 - **FEAT**: cache coingecko results (#904).
 - **FEAT**: pins app bar on token details screen (#915).
 - **FEAT**: add custom route to open links in-app (#908).
 - **FEAT**: add token unavailable to swap notice (#931).
 - **FEAT**: add sentry logs to iskp (#930).
 - **FEAT**: add Brazilian Portuguese language support (#880).
 - **FEAT**: re tapping nav bar pops route (#905).
 - **FEAT**: enable languages for ios (#901).
 - **FEAT**: storybook updates (#871).
 - **FEAT**: Spanish translation (#895).
 - **FEAT**: qr links update (#909).
 - **FEAT**: style cancel popup on first link screen (#885).
 - **FEAT**: udpate minimum amount to send and request (#946).
 - **FEAT**: add dynamic texts to onboarding notice (#890).
 - **FEAT**: add scan qr button in investment screen (#916).
 - **FEAT**: add french translation (#892).
 - **FEAT**: polling to avoid websocket broken connection when waiting for transactions statuses (#866).
 - **FEAT**: remove hardcoded strings (#891).
 - **FEAT**: update first link screen (#940).
 - **FEAT**: set up localizely (#912).
 - **DOCS**: readme updates (#888).

## 1.68.0

 - **FIX**: swap token dropdown splash (#852).
 - **FIX**: wrap tip link with dynamic links (#840).
 - **FIX**: update transfer progress screen (#847).
 - **FEAT**: swap hide fees and button when searching route (#849).
 - **FEAT**: update swap label when amount is zero (#821).

## 1.67.0

 - **FIX**: expand qr scanner button tap size (#837).
 - **FIX**: update nav bar icons (#839).
 - **FEAT**: provide only USDC for ramp (#846).
 - **FEAT**: navigate to usdc token detail page from home (#842).
 - **FEAT**: add ramp.network on-ramp method (#801).
 - **FEAT**: improve activity screen tiles (#836).
 - **FEAT**: update oskp status screen (#800).
 - **FEAT**: add animation to transfer progress timeline (#805).
 - **FEAT**: token search enhancements (#838).
 - **FEAT**: add performance monitoring for watchers (#844).

## 1.66.0

 - **FIX**: popular token list cache mapping (#828).
 - **FIX**: bottom navigation bar padding  (#829).
 - **FEAT**: improve dialogs ui (#830).

## 1.65.1

 - **FIX**: confirmation dialog label (#827).

## 1.65.0

 - **REFACTOR**: update ISLP handling (#825).
 - **REFACTOR**: update ISKP handling (#823).
 - **REFACTOR**: update swap handling (#818).
 - **REFACTOR**: update ODP handling (#806).
 - **REFACTOR**: make CancelableJob reusable (#807).
 - **FEAT**: add cancel confirmation dialogs (#824).
 - **FEAT**: remove USDC info on receiving request screen (#822).
 - **FEAT**: update dialog and bottom sheet design (#826).
 - **FEAT**: update oskp cancel screen (#819).
 - **FEAT**: auto focus on new request note (#820).
 - **FEAT**: pop status screen when going to share screen for the first time (#808).

## 1.64.0

 - **REFACTOR**: use ContextResult.
 - **REFACTOR**: update OSKP handling.
 - **FIX**: blockhash validation.
 - **FEAT**: new investment screen (#781).

## 1.63.1

 - **FIX**: retry button behaviour (#797).
 - **FIX**: check tx in TxSender (#796).

## 1.63.0

- **REFACTOR**: extract ECWallet.
- **REFACTOR**: update lints (#783).
- **REFACTOR**: rename tips module (#743).
- **REFACTOR**: rename packages.
- **PERF**: add RepaintBoundary to OnboardingNotice (#791).
- **FIX**: improve error processing in outgoing payments (#795).
- **FIX**: bottom bar behaviour (#793).
- **FIX**: update e2e tests (#789).
- **FIX**: sytem overlay style (#790).
- **FIX**: remove suggestions from seed phrase textfield (#769).
- **FIX**: token price overflow on investment screen (#782).
- **FEAT**: add slider button to buy and sell (#766).
- **FEAT**: use new swap txs (#792).
- **FEAT**: move verifiers up tree (#780).
- **FEAT**: implement versioned transactions (#706).

## 1.62.1

- **FIX**: migrate camera permission api on qrscreen (#751).

## 1.62.0

- **REFACTOR**: rebuild generated code (#748).
- **REFACTOR**: migrate to Flutter 3.7.
- **FIX**: watch activities on transaction items (#750).
- **FIX**: handle firebase link shortener exceptions (#742).
- **FIX**: settings screen topbar overlay color (#721).
- **FIX**: hide crypto investments section if 0 balance (#727).
- **FIX**: swap tile copy in transaction list (#734).
- **FEAT**: add SOL in first item of popular token list (#737).
- **FEAT**: token detail enhancements (#733).
- **FEAT**: new success screen for direct payment (#716).
- **FEAT**: minor improvements for swap screen (#738).
- **FEAT**: added day for week chart tooltip (#711).
- **DOCS**: update readme.

## 1.61.0

- **FIX**: duplicate items on transaction list (#717).
- **FEAT**: add buy and sell to pending activities list (#715).
- **FEAT**: update navbar home icon (#718).
- **FEAT**: improve items on activities screen (#628).

## 1.60.0

- **FEAT**: allow user to cancel outgoing and request payments (#626).

## 1.59.0

- **FIX**: minor ui updates (#709).
- **FIX**: investments sync (#701).
- **FEAT**: add ramp buttons to usdc token page (#707).
- **FEAT**: improve token dropdown on swap screen (#704).
- **FEAT**: add swap tile to transaction list (#703).

## 1.58.1

- **FIX**: show low value decimal numbers (#685).
- **FIX**: update investments layout (#699).
- **FIX**: investment screen fixes (#698).

## 1.58.0

- **REFACTOR**: restructure modules (#697).
- **FIX**: update incoming transfer success message (#686).
- **FIX**: clear tip db on logout (#684).
- **FEAT**: enable transactions tab.
- **FEAT**: investment page redesign (#695).
- **FEAT**: allow user to enter recipient address manually (#675).
- **FEAT**: improve transaction list for oskp (#634).
- **FEAT**: improve buy and sell ux (#679).

## 1.57.0

- **FEAT**: add token search (#654).
- **FEAT**: add favorites module (#655).
- **FEAT**: add cache to popular tokens (#656).
- **FEAT**: intro screen redesign (#673).

## 1.56.0

- **FIX**: hide tokens based on fiat balance (#653).
- **FIX**: save reference in OutgoingDirectPayment.
- **FIX**: add BuildContext to LogoutListener callback (#645).
- **FIX**: add back button in app lock (#642).
- **FEAT**: add tip feature (#672).
- **FEAT**: add buy and sell flows to app (#537).
- **FEAT**: update token list (#677).
- **FEAT**: token detail page ui updates (#644).
- **FEAT**: add top tokens by market cap in popular tokens section (#617).
- **FEAT**: add Intercom support (#633).

## 1.55.0

- **FIX**: check if tx with expired bh already submitted (#640).
- **FIX**: update chart range selector hitbox (#616).
- **FEAT**: add toggle to hide zero balance tokens (#609).
- **FEAT**: update app lock ui (#636).
- **FEAT**: update puzzle reminder trigger (#611).
- **FEAT**: update analytics (#624).
- **FEAT**: update CpSwitch design (#629).

## 1.54.0

- **FEAT**: hide transactions tab behind FF (#623).
- **FEAT**: remove ftx from off ramp flow (#608).

## 1.53.0

- **FEAT**: add transaction tab to activity screen (#544).

## 1.52.1

- **FIX**: TxSender correctly waits for old txs (#612).
- **FIX**: update request page layout (#604).
- **FIX**: take reference into account when scanning QR code (#610).

## 1.52.0

- **FIX**: update successful payment label (#602).
- **FEAT**: add token details screen (#511).
- **FEAT**: add jupiter v3 client (#605).
- **DOCS**: update discord links.

## 1.51.0

- **FEAT**: share qr code on payment request (#589).

## 1.50.0

- **REFACTOR**: remove remaining cycles.
- **REFACTOR**: remove cycles from features.
- **REFACTOR**: conversion rates module.
- **REFACTOR**: tokens module structure.
- **REFACTOR**: remove cyclic dependencies in account.
- **REFACTOR**: restrict dependencies (#586).
- **REFACTOR**: pending_activities module.
- **REFACTOR**: payment_request module.
- **REFACTOR**: OSKP module.
- **REFACTOR**: odp module (#583).
- **REFACTOR**: onboarding module (#582).
- **REFACTOR**: qr_scanner module.
- **REFACTOR**: iskp module.
- **REFACTOR**: ramp module.
- **REFACTOR**: app_lock module.
- **REFACTOR**: backup_phrase module.
- **REFACTOR**: migrate to relative imports.
- **REFACTOR**: remove unused solana client extensions.
- **FIX**: add https for ftx url (#590).
- **FIX**: update layout (#580).
- **FEAT**: calculate fee dynamically.
- **FEAT**: add fee label to ODP.
- **FEAT**: update fee label for OSKP.
- **FEAT**: add animated error to wallet flow (#595).
- **FEAT**: add insufficient funds error label (#593).
- **FEAT**: update twitter link.
- **DOCS**: update twitter links.

## 1.49.1

- **FIX**: backup flow routing (#577).

## 1.49.0

- **REFACTOR**: remove icon parameter from InfoWidget.
- **REFACTOR**: update backup phrase routes (#572).
- **REFACTOR**: update payment request naming (#571).
- **REFACTOR**: update onboarding flow structure (#569).
- **FIX**: text style in InfoWidget (#576).
- **FIX**: menu screen.
- **FIX**: update icon button.
- **FIX**: update keypad.
- **FEAT**: update ftx support urls (#568).

## 1.48.0

- **REFACTOR**: remove unused code.
- **REFACTOR**: update onboarding screen.
- **REFACTOR**: move app components to UI.
- **REFACTOR**: update cash in/out flows.
- **REFACTOR**: add ShareMessageBubble.
- **FIX**: update ODP confirmation screen.
- **FIX**: update Contact Us layout.
- **FIX**: update BackupWarningScreen layout.
- **FIX**: remove keypad visibility if not enabled (#562).
- **FEAT**: update payment request note screen.
- **FEAT**: new add cash and cash out flows (#512).
- **FEAT**: update app name (#564).

## 1.47.0

- **FIX**: add amount to "creating links".
- **FIX**: menu screen layout.
- **FIX**: add horizontal padding on input amount (#553).
- **FEAT**: update date formatting.
- **FEAT**: update Contact Us sheet (#559).
- **FEAT**: update QR-scanner UI (#554).
- **FEAT**: add recovery phrase warning page (#551).
- **FEAT**: change help center url (#560).
- **FEAT**: redirect privacy policy and terms of use to webpages (#561).

## 1.46.0

- **FIX**: share message wrapper layout (#548).
- **FIX**: nav bar icon size (#547).
- **FEAT**: add oskp verifier (#550).
- **FEAT**: coming soon label for transactions (#549).

## 1.45.0

- **FIX**: NoActivity layout.
- **FIX**: remove retry delay on OSKP page.
- **FIX**: OSKP details layout.
- **FIX**: update investments header layout.
- **FIX**: unify icons.
- **FIX**: investment page ui fixes (#539).
- **FIX**: remove shadow artefact on onboarding screen (#495).
- **FIX**: share link layout margin (#538).
- **FIX**: navigation bar icons (#540).
- **FIX**: share payment request copy (#541).
- **FEAT**: listen for status update on payment request.
- **FEAT**: format date in activity tiles.
- **FEAT**: add link to ODPDetails page.
- **FEAT**: move status screen bg to widget.
- **FEAT**: update app name.
- **FEAT**: add NoActivity widget.

## 1.44.0

- **REFACTOR**: merge storybook into cryptoplease.
- **REFACTOR**: remove unused code (#531).
- **REFACTOR**: move ui to lib (#530).
- **REFACTOR**: remove unused code (#529).
- **REFACTOR**: merge cryptoplease_ui into cryptoplease (#525).
- **REFACTOR**: remove unused l10n strings (#522).
- **REFACTOR**: move payment request table data (#521).
- **REFACTOR**: integrate get_it (#520).
- **FIX**: fix WalletMainScreen layout for small screens.
- **FEAT**: add tabbar to activity screen (#524).
- **FEAT**: update OSKPTile in activity (#523).

## 1.43.0

- **REFACTOR**: remove obsolete deep links support (#514).
- **REFACTOR**: remove debug section from profile (#513).
- **REFACTOR**: remove old code (#509).
- **REFACTOR**: remove old iskp (#508).
- **REFACTOR**: extract SplitKey\*Link (#507).
- **REFACTOR**: restructure screens (#505).
- **REFACTOR**: remove old pending requests code (#504).
- **REFACTOR**: remove nft code (#480).
- **FIX**: clear repositories on logout (#510).
- **FIX**: request payment links layout (#478).
- **FIX**: adjusted vertical align for copy button (#477).
- **FIX**: request page design updates (#475).
- **FEAT**: partially implement new pending activities (#515).
- **FEAT**: update logo (#496).
- **FEAT**: added investments screen (#506).
- **FEAT**: add address to profile screen (#491).
- **FEAT**: connect ISKP to UI (#503).
- **FEAT**: use new models in incoming payment requests (#502).
- **FEAT**: implement data layer for iskp (#501).
- **FEAT**: update OSKP (#500).
- **FEAT**: connect ODP to UI (#497).
- **FEAT**: added outgoing split transfer status page (#441).
- **FEAT**: add txId to success statuses (#493).
- **FEAT**: scan qrcode to send usdc (#438).
- **FEAT**: add ODPModule (#492).
- **FEAT**: add new incoming split-key model and bloc (#490).
- **FEAT**: add new outgoing transfer (#489).
- **FEAT**: add new OutgoingDirectPayment model and bloc (#479).

## 1.42.0

- **REFACTOR**: move jupiter client to cryptoplease_api package (#452).
- **REFACTOR**: extract CpRoundedRectangle (#437).
- **FIX**: auto-update output when the selected input is same as the output token (#393).
- **FIX**: request pay screen ui updates (#412).
- **FEAT**: create TxSender (#465).
- **FEAT**: remove swap on bottom menu (#444).
- **FEAT**: add pull-to-refresh in balance page (#446).
- **FEAT**: redesign confirmation screen (#376).
- **FEAT**: redesign share links page (#414).
- **FEAT**: redesign onboarding screens (#405).

## 1.41.1

- **FIX**: add default value for version (#410).

## 1.41.0

- **FIX**: make system status bar transparent (#392).
- **FIX**: add padding at the bottom of 'Select Token' list (#391).
- **FIX**: fixed jank on swap page (#386).
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
