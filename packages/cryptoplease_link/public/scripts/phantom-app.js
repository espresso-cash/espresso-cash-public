const checkPhantom = function () {
  const isPhantomInstalled = window.solana && window.solana.isPhantom;

  if (isPhantomInstalled) {
    document.getElementById('phantom-button').style.visibility = 'visible';
  } else {
    document.getElementById('phantom-button').style.visibility = 'hidden';
  }
};

const sendTransaction = function (amount, recipient) {
  window.solana
    .connect()
    .then(({ publicKey }) => _createAndSendTransaction(publicKey, amount, recipient))
    .catch(_onError);
};

const _onError = console.warn;

const _getLamports = function (amount) {
  const multiplier = 10 ** 9;
  return amount * multiplier;
};

const _createTransfer = async (connection, publicKey, destination, lamports) => {
  if (!publicKey) return;
  let transaction = new solanaWeb3.Transaction().add(
    solanaWeb3.SystemProgram.transfer({
      fromPubkey: publicKey,
      toPubkey: destination,
      lamports: lamports,
    }),
  );
  transaction.feePayer = publicKey;
  const anyTransaction = transaction;
  anyTransaction.recentBlockhash = (await connection.getRecentBlockhash()).blockhash;
  return transaction;
};

const _createAndSendTransaction = async function (publicKey, amount, destination) {
  const network = 'https://api.mainnet-beta.solana.com';
  const connection = new solanaWeb3.Connection(network);

  try {
    const lamports = _getLamports(amount);
    const transaction = await _createTransfer(connection, publicKey, destination, lamports);
    if (!transaction) return;
    const provider = window.solana;
    const { signature } = await provider.signAndSendTransaction(transaction);
    await connection.confirmTransaction(signature);

    alert('Transaction confirmed!');
  } catch (err) {
    console.warn(err);
    alert('Error sending the transaction!');
  }
};
