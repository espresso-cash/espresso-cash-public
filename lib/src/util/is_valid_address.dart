RegExp _regularExpression = RegExp(r'[1-9A-HJ-NP-Za-km-z]{32,44}');

bool isValidAddress(String address) => _regularExpression.hasMatch(address);
