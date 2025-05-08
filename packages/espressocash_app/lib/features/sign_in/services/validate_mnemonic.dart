import 'package:bip39/bip39.dart' as bip39;

bool isValidMnemonic(String mnemonic) => bip39.validateMnemonic(mnemonic);
