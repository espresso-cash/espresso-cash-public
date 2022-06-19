const checkPhantom = function () {
  const isPhantomInstalled = window.solana && window.solana.isPhantom;

  if (isPhantomInstalled) {
    document.getElementById("phantom-button").style.visibility = "visible";
  } else {
    document.getElementById("phantom-button").style.visibility = "hidden";
  }
};

const connect = function () {
  window.solana.connect().then(_sendTransaction).catch(_onError);
};

const _onError = console.log;

const _createTransferTransaction = async (connection, publicKey, lamports) => {
  if (!publicKey) return;
  let transaction = new solanaWeb3.Transaction().add(
    solanaWeb3.SystemProgram.transfer({
      fromPubkey: publicKey,
      // TODO: change it
      toPubkey: publicKey,
      lamports: lamports,
    })
  );
  transaction.feePayer = publicKey;
  console.log("Getting recent blockhash");
  const anyTransaction = transaction;
  anyTransaction.recentBlockhash = (
    await connection.getRecentBlockhash()
  ).blockhash;
  return transaction;
};

const _sendTransaction = async function (data) {
    // TODO: get from env
    const { publicKey } = data;
    const network = "https://api.devnet.solana.com";
    const connection = new solanaWeb3.Connection(network);
    try {
      // TODO: change it
      const transaction = await _createTransferTransaction(connection, publicKey, 100);
      if (!transaction) return;
      const provider = window.solana;
      let signed = await provider.signTransaction(transaction);
      console.log("Got signature, submitting transaction");
      let signature = await connection.sendRawTransaction(signed.serialize());
      console.log("Submitted transaction " + signature + ", awaiting confirmation");
      await connection.confirmTransaction(signature);
      console.log("Transaction " + signature + " confirmed");
    } catch (err) {
      console.warn(err);
      console.log("[error] sendTransaction: " + JSON.stringify(err));
    }
  };
  