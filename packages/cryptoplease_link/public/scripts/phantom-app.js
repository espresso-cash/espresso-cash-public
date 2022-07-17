const checkPhantom = function () {
  const isPhantomInstalled = window.solana && window.solana.isPhantom;

  if (isPhantomInstalled) {
    document.getElementById('phantom-button').style.visibility = 'visible';
  } else {
    document.getElementById('phantom-button').style.visibility = 'hidden';
  }
};

const sendTransaction = function (recipient) {
  window.solana
  .connect()
  .then(({ publicKey }) => _createAndSendTransaction(publicKey, recipient))
  .catch(_onError);
};

const _onError = console.warn;

const _buildSolanaPayParameters = async (recipient) => {
  const protocol = 'solana:'
  const params = window.location.search;
  const uri = protocol + recipient + params
  return solanaPay.parseURL(uri)
}

const _createTransfer = async (connection, publicKey, recipient) => {
  if (!publicKey) return;

  const data = await _buildSolanaPayParameters(recipient)
  const transaction = await solanaPay.createTransfer(connection, publicKey, data);
  transaction.feePayer = publicKey;
  const anyTransaction = transaction;
  anyTransaction.recentBlockhash = (await connection.getRecentBlockhash()).blockhash;

  return transaction;
};

const _createAndSendTransaction = async function (publicKey, recipient) {
  const network = 'https://api.mainnet-beta.solana.com';
  const connection = new solanaWeb3.Connection(network);

  try {
    const transaction = await _createTransfer(connection, publicKey, recipient);
    if (!transaction) return;
    const provider = window.solana;
    await provider.signAndSendTransaction(transaction);

    alert('Payment has been sent successfully!');
  } catch (err) {
    console.warn(err);
    alert('Error sending the transaction!');
  }
};
