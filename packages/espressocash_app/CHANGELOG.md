## 1.123.1

 - **REFACTOR**: moneygram pr (#1533).
 - **FIX**: Temporary change for webview package dependency (#1534).

## 1.123.0

 - **REFACTOR**: update outgoing escrow signing (#1500).
 - **FIX**: coinflow additional verification redirect (#1516).
 - **FIX**: portfolio amount value (#1504).
 - **FEAT**: add moneygram cash out (#1506).
 - **FEAT**: add moneygram cash in (#1502).
 - **FEAT**: android target sdk version to 34 (#1523).
 - **FEAT**: upgrade to Flutter 3.22 (#1517).
 - **FEAT**: add logging for link tx creation (#1513).

## 1.122.1

 - **FIX**: durable tx signing.

## 1.122.0

 - **FIX**: home spacing (#1489).
 - **FEAT**: use durable nonce for escrow txs (#1459).
 - **FEAT**: integrate stellar wallet (#1497).
 - **FEAT**: new lock screen theme  (#1494).

## 1.121.1

 - **FIX**: do not wait for intercom login (#1493).
 - **FIX**: profile spacing colors (#1490).
 - **FIX**: sol conversion matching (#1491).

## 1.121.0

 - **REFACTOR**: balances module (#1476).
 - **FIX**: main screen flow (#1487).
 - **FIX**: ignore usdc token on crypto portfolio (#1478).
 - **FIX**: activity tile text color to white (#1477).
 - **FEAT**: log total crypto balance (#1488).
 - **FEAT**: sort crypto portfolio list (#1480).
 - **FEAT**: home & payment improved buttons (#1468).

## 1.120.0

 - **REFACTOR**: request feature flag cleanup (#1455).
 - **REFACTOR**: remove tx failure logging (#1453).
 - **REFACTOR**: enable profiling (#1447).
 - **FIX**: transaction request fixes (#1449).
 - **FEAT**: show users list of tokens (#1433).
 - **FEAT**: black background in activity and profile page (#1461).
 - **FEAT**: fetch usd rate from backend (#1465).
 - **FEAT**: homepage theme (#1452).
 - **FEAT**: update local token list data (#1454).
 - **FEAT**: update analytics (#1451).

## 1.119.0

 - **FEAT**: optmize startup time (#1444).

## 1.118.0

 - **REFACTOR**: use dcm 1.17.0 (#1441).
 - **FIX**: show proper tx status for common tile (#1443).
 - **FIX**: MobileWalletRepository lifecycle (#1437).
 - **FEAT**: increase text button tap area (#1438).
 - **FEAT**: add performance monitoring for app start (#1442).
 - **FEAT**: re add puzzle quiz screen flow (#1430).
 - **FEAT**: show loading title on webview (#1429).
 - **FEAT**: integrate mixpanel (#1436).

## 1.117.0

 - **FIX**: camera overlay rendering (#1423).
 - **FEAT**: unlock functionality behind FF (#1422).
 - **FEAT**: validate shortened link hash (#1420).
 - **FEAT**: minor padding adjustment (#1421).

## 1.116.0

 - **FEAT**: update evm qr parsing (#1418).
 - **FEAT**: resolve incoming shortened deep links (#1419).
 - **FEAT**: show only USDC transfers on transaction list (#1350).
 - **FEAT**: validate solana pay reference if paid (#1379).

## 1.115.0

 - **REFACTOR**: restructure qr_scanner.
 - **REFACTOR**: break outgoing_direct_payments -> wallet_flow.
 - **REFACTOR**: break fees -> ramp.
 - **REFACTOR**: break balances -> conversion_rates.
 - **REFACTOR**: break conversion_rates -> wallet_flow.
 - **REFACTOR**: break activities -> authenticated.
 - **REFACTOR**: restructure accounts.
 - **REFACTOR**: remove nested dependency (#1401).
 - **FEAT**: update pay verification interval on opened request (#1410).
 - **FEAT**: show add cash notice on zero balance (#1388).

## 1.114.0

 - **REFACTOR**: remove go_router (#1399).
 - **FEAT**: update share screen uis (#1400).

## 1.113.0

 - **REFACTOR**: migrate to Flutter 3.19 (#1393).
 - **REFACTOR**: update linter (#1392).
 - **FEAT**: request payment module updates (#1375).

## 1.112.0

 - **FIX**: dynamic links on cold start (#1376).
 - **FEAT**: add support to solana pay transaction request (#1366).
 - **FEAT**: add feature flag for incoming dln request (#1384).

## 1.111.0

 - **REFACTOR**: remove common package (#1360).
 - **REFACTOR**: remove logout listener (#1357).
 - **REFACTOR**: tx updater (#1355).
 - **REFACTOR**: remove unused code.
 - **REFACTOR**: remove some obsolete modules (#1354).
 - **REFACTOR**: restructure core (#1353).
 - **REFACTOR**: remove internal src folders (#1352).
 - **REFACTOR**: update lints.
 - **REFACTOR**: transfer core to common package  (#1349).
 - **FIX**: scalex minimum amount (#1373).
 - **FIX**: odp failure message for no funds (#1339).
 - **FEAT**: cache usdc balance (#1348).
 - **FEAT**: simplify balance tracking  (#1343).
 - **FEAT**: payment request tile title update (#1351).
 - **FEAT**: update payment request link (#1341).
 - **FEAT**: update request message label (#1342).

## 1.110.2

 - **FIX**: coinflow kyc flow  (#1347).

## 1.110.1

 - **FIX**: clear secure storage on first run (#1340).

## 1.110.0

 - **REFACTOR**: remove landing code from main app (#1336).
 - **FEAT**: add cancel for failed direct payments (#1337).
 - **FEAT**: update onboarding flow (#1324).

## 1.109.0

 - **FIX**: ramp redirect (#1323).
 - **FIX**: resend tx when blockhash is valid.
 - **FEAT**: remove scalex offramp fee (#1329).
 - **FEAT**: ensure current countries not ofac blocklisted (#1328).

## 1.108.0

 - **FEAT**: resend tx on waiting.

## 1.107.0

 - **REFACTOR**: remove unused code.
 - **REFACTOR**: update lint rules (#1320).
 - **FEAT**: update ws subscription timeout.
 - **FEAT**: remove investments section (#1327).
 - **FEAT**: scalex ramp theme update (#1321).
 - **FEAT**: remove banned countries from selector (#1326).
 - **FEAT**: update profile error dialog (#1322).
 - **FEAT**: remove onboarding notice banner (#1325).
 - **FEAT**: update coinflow webview theme (#1307).
 - **FEAT**: add compute unit price measurement (#1319).
 - **FEAT**: remove Guardarian for US on ramp (#1306).

## 1.106.0

 - **REFACTOR**: simplify FormPage layout (#1304).
 - **REFACTOR**: extract FormPage (#1303).
 - **REFACTOR**: move link listeners (#1302).
 - **REFACTOR**: remove saga code (#1297).
 - **REFACTOR**: migrate to go_router (#1294).
 - **FIX**: coinflow plaid bug (#1305).
 - **FIX**: sending by link amount.
 - **FIX**: ramp page scroll (#1296).
 - **FEAT**: update confirmation dialog theme (#1308).
 - **FEAT**: update ramp header title (#1318).
 - **FEAT**: update tx performance monitoring.
 - **FEAT**: web landing pages redesign (#1301).
 - **FEAT**: routing navigation updates (#1298).
 - **FEAT**: add last name field to ramp onboarding (#1295).

## 1.105.0

 - **REFACTOR**: remove declarative routes (#1288).
 - **REFACTOR**: use DCM 1.14.0 (#1282).
 - **REFACTOR**: rename ec client (#1281).
 - **FIX**: scalex onramp fee calculation (#1279).
 - **FIX**: scalex offramp  (#1277).
 - **FEAT**: add last name (#1287).
 - **FEAT**: payment screens redesign (#1272).
 - **FEAT**: outgoing dln module updates (#1266).

## 1.104.0

 - **FIX**: intercom initialization (#1275).
 - **FIX**: pay screen background blink (#1268).
 - **FEAT**: update carousel for ios (#1274).
 - **FEAT**: add intercom support (#1265).
 - **FEAT**: make order id copyable (#1271).

## 1.103.0

 - **FIX**: incorrect token balance (#1259).
 - **FEAT**: move Contact us and FAQ buttons (#1260).

## 1.102.0

 - **REFACTOR**: update ramp structure (#1251).
 - **FEAT**: add FF for outgoing DLN (#1258).
 - **FEAT**: outgoing cross chain payments (#1107).
 - **FEAT**: update popular token list (#1257).
 - **FEAT**: add tx waiting performance monitoring (#1255).
 - **FEAT**: enable offramp for everyone (#1254).
 - **FEAT**: splash animation update (#1236).
 - **FEAT**: redesign investment widget (#1248).
 - **FEAT**: update scalex cashout flow (#1249).
 - **FEAT**: redesign web landing pages (#1237).

## 1.101.1

 - **FIX**: ODP service (#1245).
 - **FIX**: receive link loading bug (#1241).
 - **FIX**: checking status of outgoing escrow (#1244).

## 1.101.0

 - **REFACTOR**: splash dependency (#1230).
 - **FIX**: update profile saving logic (#1239).
 - **FIX**: webview camera (#1232).
 - **FEAT**: add Guardarian partner for US onramp (#1229).

## 1.100.0

 - **FEAT**: disable saga functionality.
 - **FEAT**: save country code to backend (#1235).
 - **FEAT**: add name on pay request (#1134).
 - **FEAT**: update fee calculation for withdraw (#1226).

## 1.99.1

 - **FIX**: backend client url.

## 1.99.0

 - **REFACTOR**: update linter (#1223).
 - **FIX**: offramp watcher (#1221).
 - **FEAT**: update l10n.
 - **FEAT**: update scalex withdrawals (#1216).
 - **FEAT**: splash screen updates (#1225).
 - **FEAT**: wallet fee updates (#1220).
 - **FEAT**: minor wallet label update (#1219).
 - **FEAT**: add quiz module (#1158).

## 1.98.0

 - **FIX**: cancel cash out bug (#1213).
 - **FEAT**: onboarding updates (#1214).
 - **FEAT**: update flutter splash screen (#1215).
 - **FEAT**: popular token ui (#1218).

## 1.97.0

 - **REFACTOR**: getting simulated balance.
 - **FIX**: transaction waiting.
 - **FIX**: coinflow withdrawal flow.
 - **FIX**: coinflow build (#1209).
 - **FEAT**: update l10n (#1211).
 - **FEAT**: splash screen updates (#1201).

## 1.96.0

 - **REFACTOR**: move FileManager to data (#1190).
 - **REFACTOR**: restructure features (#1183).
 - **REFACTOR**: remove unused dependencies (#1182).
 - **REFACTOR**: update dependencies (#1181).
 - **REFACTOR**: update dependencies (#1179).
 - **REFACTOR**: restructure features (#1178).
 - **FIX**: coinflow versioned transactions (#1184).
 - **FIX**: added generator build order (#1185).
 - **FEAT**: update token list source (#1191).
 - **FEAT**: dynamic first incoming fee (#1197).
 - **FEAT**: minor label update (#1192).
 - **FEAT**: auth backend requests (#1188).
 - **FEAT**: updated popular token list (#1186).

## 1.95.0

 - **FEAT**: prefer ramp network in Europe (#1174).

## 1.94.0

 - **FEAT**: enable coinflow in Europe (#1173).

## 1.93.0

 - **REFACTOR**: update linter (#1170).
 - **REFACTOR**: remove unused code (#1165).
 - **REFACTOR**: partner select logic (#1164).
 - **FIX**: auth scope init (#1171).
 - **FEAT**: add onramp manual bank transfer support (#1168).
 - **FEAT**: coinflow cashout integration  (#1166).
 - **FEAT**: timeline widget updates (#1169).
 - **FEAT**: ramp updates (#1161).
 - **FEAT**: trigger ramp watchers immediately (#1167).
 - **FEAT**: add fee message on incoming link payment (#1162).
 - **FEAT**: add ramp transaction tiles (#1163).
 - **FEAT**: redirect after kado onramp (#1159).

## 1.92.0

 - **REFACTOR**: migrate to Flutter 3.16.2 (#1157).
 - **FEAT**: update onramp status screen  (#1155).
 - **FEAT**: update offramp status screen (#1154).

## 1.91.0

 - **FIX**: remove home tab animation transition (#1141).
 - **FIX**: webview onLoaded call (#1118).
 - **FIX**: splash screen background color (#1140).
 - **FIX**: image background load blink (#1145).
 - **FIX**: timeline gap (#1131).
 - **FEAT**: update l10n (#1152).
 - **FEAT**: add scalex ramp (#1108).
 - **FEAT**: Update l10n (#1151).
 - **FEAT**: update l10n (#1150).
 - **FEAT**: home screen ui updates (#1148).
 - **FEAT**: update onboarding flow (#1142).
 - **FEAT**: remove hardcoded keys (#1144).
 - **FEAT**: offramp updates  (#1143).
 - **FEAT**: onramp updates (#1117).
 - **FEAT**: update profile qr code (#1129).
 - **FEAT**: splash and sign-in update (#1132).

## 1.90.0

 - **FEAT**: update ramp screens ui (#1133).

## 1.89.0

 - **FEAT**: add kado off-ramp (#1137).
 - **FEAT**: update home carousel (#1128).
 - **FEAT**: add experimental flag (#1114).

## 1.88.0

 - **REFACTOR**: bump dependencies (#1113).
 - **REFACTOR**: bump dependencies (#1109).
 - **FIX**: crypto cash balance label (#1116).
 - **FIX**: payment request amount (#1115).
 - **FEAT**: update translations.

## 1.87.1

 - **FIX**: kado webview update (#1105).

## 1.87.0

 - **REFACTOR**: update lint rules (#1102).
 - **FIX**: updated android 12 native splash (#1103).
 - **FEAT**: reduce splash duration (#1100).
 - **FEAT**: pay method ui update (#1099).

## 1.86.0

 - **FIX**: payment request link format (#1094).
 - **FIX**: ramp ui updates (#1096).
 - **FEAT**: update translations.
 - **FEAT**: update splash screen (#1095).
 - **FEAT**: various ui updates (#1097).
 - **FEAT**: keypad and wallet ui (#1098).
 - **FEAT**: update landing page config.

## 1.85.0

 - **REFACTOR**: update lint rules (#1091).
 - **FIX**: app bar on investments screen (#1092).
 - **FIX**: clear on-ramp orders on logout (#1090).
 - **FIX**: kado order status (#1089).
 - **FIX**: various UI updates (#1080).
 - **FEAT**: add single link payments (#1071).
 - **FEAT**: investment screen redesign (#1081).
 - **FEAT**: payment request creation (#1088).
 - **FEAT**: add payment landing site (#1069).

## 1.84.0

 - **REFACTOR**: migrate to Flutter 3.13.6 (#1077).
 - **FEAT**: add pay method selection (#1075).
 - **FEAT**: update remaning screens to black theme (#1076).
 - **FEAT**: investment screen ui updates (#1065).
 - **FEAT**: update to black theme (#1073).

## 1.83.0

 - **FIX**: small ui fixes (#1056).
 - **FEAT**: update kado on-ramp (#1074).
 - **FEAT**: add off-ramp amount screen (#1067).
 - **FEAT**: add ramp onboarding screen (#1066).
 - **FEAT**: update partner select screen layout (#1064).

## 1.82.0

 - **FEAT**: remove localizely ota (#1055).
 - **FEAT**: provide email to onramp partners (#1054).
 - **FEAT**: add email to profile (#1053).

## 1.81.0

 - **FEAT**: migrate to flutter_inappwebview (#1052).

## 1.80.0

 - **FEAT**: Integrate guardarian onramp (#1051).

## 1.79.1

 - **FIX**: kado onramp parameters (#1050).

## 1.79.0

 - **REFACTOR**: restructure some modules (#1048).
 - **REFACTOR**: move BalancesBloc to get_it.
 - **REFACTOR**: update linter (#1030).
 - **REFACTOR**: migrate some freezed classes to sealed (#1029).
 - **FIX**: remove 1d from token chart (#1049).
 - **FIX**: make amount formatting more consistent (#1034).
 - **FIX**: move BalancesBloc under authenticated flow.
 - **FEAT**: add kado on-ramp (#1047).

## 1.78.0

 - **REFACTOR**: clean Amount and Currency (#1028).
 - **REFACTOR**: remove UserPreferences (#1027).
 - **REFACTOR**: update balances logic (#1026).
 - **REFACTOR**: update routes handling (#1024).
 - **FIX**: provide valid router keys.
 - **FIX**: add padding to country selector.
 - **FEAT**: add ramp flow logic (#1022).

## 1.77.3

 - **FIX**: center button in onboarding notice (#1021).

## 1.77.2

 - **REFACTOR**: consolidate profile screens (#1009).
 - **REFACTOR**: update l10n keys.
 - **REFACTOR**: update l10n keys.
 - **REFACTOR**: update l10n keys.
 - **FIX**: sign-in flow (#1010).

## 1.77.1

 - **REFACTOR**: update l10n keys (#1007).

## 1.77.0

 - **REFACTOR**: add AccountRepository (#1002).
 - **REFACTOR**: decouple profile and account modules (#1001).
 - **REFACTOR**: restructure code (#997).
 - **FIX**: remove duplicated LogoutListener (#1000).
 - **FIX**: padding in ProfileScreen (#998).
 - **FEAT**: add l10n to ramp network add cash flow (#974).
 - **FEAT**: add country selector on profile screen (#999).

## 1.76.0

 - **REFACTOR**: bump linter (#993).
 - **REFACTOR**: update dfunc (#992).
 - **FIX**: back button on app locked screen (#987).
 - **FEAT**: update get started screen (#996).
 - **FEAT**: skip wallet creation when receiving links on new wallet (#936).
 - **FEAT**: curated list of popular tokens (#926).
 - **FEAT**: localize chart time interval (#971).
 - **FEAT**: upgrade auto router, refactor routes (#932).

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
