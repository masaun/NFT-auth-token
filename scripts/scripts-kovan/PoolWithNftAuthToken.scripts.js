require('dotenv').config();

const Tx = require('ethereumjs-tx').Transaction;
const Web3 = require('web3');
const provider = new Web3.providers.HttpProvider(`https://kovan.infura.io/v3/${ process.env.INFURA_KEY }`);
const web3 = new Web3(provider);

let PoolWithNftAuthToken = {};
PoolWithNftAuthToken = require("../../build/contracts/PoolWithNftAuthToken.json");

const walletAddress = process.env.WALLET_ADDRESS;
const privateKey = process.env.PRIVATE_KEY;

/***
 * @dev - [Execution]: $ node ./scripts/scripts-kovan/PoolWithNftAuthToken.scripts.js
 **/

/* Global variable */
let poolWithNftAuthTokenABI;
let poolWithNftAuthTokenAddr;
let poolWithNftAuthToken;

/* Set up contract */
async function _stakeIntoNftPool() {
    poolWithNftAuthTokenABI = PoolWithNftAuthToken.abi;
    poolWithNftAuthTokenAddr = PoolWithNftAuthToken["networks"]["42"]["address"];    /// Deployed address on Kovan
    poolWithNftAuthToken = await new web3.eth.Contract(poolWithNftAuthTokenABI, poolWithNftAuthTokenAddr);

    /// Log
    console.log('=== poolWithNftAuthTokenAddr ===', poolWithNftAuthTokenAddr);

    /* Send _stakeIntoNftPool() of NftAuthTokenManager contract */
    const amount = web3.utils.toWei(`${ 1 }`, 'ether');  /// 1 mUSD
    let inputData1 = await poolWithNftAuthToken.methods._stakeIntoNftPool(amount).encodeABI();
    let transaction1 = await sendTransaction(walletAddress, privateKey, poolWithNftAuthTokenAddr, inputData1)
}
_stakeIntoNftPool();




/***
 * @notice - Sign and Broadcast the transaction
 **/
async function sendTransaction(walletAddress, privateKey, contractAddress, inputData) {
    try {
        const txCount = await web3.eth.getTransactionCount(walletAddress);
        const nonce = await web3.utils.toHex(txCount);
        console.log('=== txCount, nonce ===', txCount, nonce);

        /// Build the transaction
        const txObject = {
            nonce:    web3.utils.toHex(txCount),
            from:     walletAddress,
            to:       contractAddress,  /// Contract address which will be executed
            value:    web3.utils.toHex(web3.utils.toWei('0', 'ether')),
            gasLimit: web3.utils.toHex(2100000),
            gasPrice: web3.utils.toHex(web3.utils.toWei('6', 'gwei')),
            data: inputData  
        }
        console.log('=== txObject ===', txObject)

        /// Sign the transaction
        privateKey = Buffer.from(privateKey, 'hex');
        let tx = new Tx(txObject, { 'chain': 'kovan'});  /// Chain ID = kovan
        tx.sign(privateKey);

        const serializedTx = tx.serialize();
        const raw = '0x' + serializedTx.toString('hex');

        /// Broadcast the transaction
        const transaction = await web3.eth.sendSignedTransaction(raw);
        console.log('=== transaction ===', transaction)

        /// Return the result above
        return transaction;
    } catch(e) {
        console.log('=== e ===', e);
        return String(e);
    }
}
