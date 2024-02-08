import 'package:solana/src/crypto/crypto.dart';

export 'dto.dart' show Commitment;
export 'encoder.dart' show Message;
export 'src/borsh_ext.dart';
export 'src/crypto/crypto.dart';
export 'src/exceptions/exceptions.dart';
export 'src/helpers.dart';
export 'src/programs/associated_token_account_program/program.dart';
export 'src/programs/compute_budget_program/program.dart';
export 'src/programs/memo_program/program.dart';
export 'src/programs/stake_program/program.dart';
export 'src/programs/system_program/program.dart';
export 'src/programs/token_program/program.dart';
export 'src/rpc/client.dart';
export 'src/solana_client.dart';
export 'src/subscription_client/optional_error.dart';
export 'src/subscription_client/subscription_client.dart';
export 'src/subscription_client/subscription_client_exception.dart';
export 'src/subscription_client/subscription_client_ext.dart';

/// The first signature in a transaction, which can be used to uniquely identify
/// the transaction across the complete ledger.
typedef TransactionId = String;

typedef Wallet = Ed25519HDKeyPair;

const int lamportsPerSol = 1000000000;
const int solDecimalPlaces = 9;
