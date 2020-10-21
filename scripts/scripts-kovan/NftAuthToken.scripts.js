require('dotenv').config();

const Tx = require('ethereumjs-tx').Transaction;
const Web3 = require('web3');
const provider = new Web3.providers.HttpProvider(`https://kovan.infura.io/v3/${ process.env.INFURA_KEY }`);
const web3 = new Web3(provider);

let NftAuthToken = {};
let NftAuthTokenManager = {};
NftAuthToken = require("../../build/contracts/NftAuthToken.json");
NftAuthTokenManager = require("../../build/contracts/NftAuthTokenManager.json");

const walletAddress = process.env.WALLET_ADDRESS;
const privateKey = process.env.PRIVATE_KEY;


/* Global variable */
let nftAuthTokenABI;
let nftAuthTokenAddr;
let nftAuthToken;

let nftAuthTokenManagerABI;
let nftAuthTokenManagerAddr;
let nftAuthTokenManager;

/* Set up contract */
// nftAuthTokenABI = NftAuthToken.abi;
// nftAuthTokenAddr = NftAuthToken["networks"]["42"]["address"];    /// Deployed address on Kovan
// nftAuthToken = new web3.eth.Contract(nftAuthTokenABI, nftAuthTokenAddr);

nftAuthTokenManagerABI = NftAuthTokenManager.abi;
nftAuthTokenManagerAddr = NftAuthTokenManager["networks"]["42"]["address"];    /// Deployed address on Kovan
nftAuthTokenManager = new web3.eth.Contract(nftAuthTokenManagerABI, nftAuthTokenManagerAddr);


/*** 
 * @dev - Send mintAuthToken() of NftAuthToken contract 
 **/
async function mintAuthToken() {
    /* Check authTokenList after createAuthToken() is executed */
    const authTokenList = await getAuthTokenList();
    console.log('\n=== authTokenList ===\n', authTokenList);

    /* Choose 1 contract address which is created by NftAuthTokenManager.sol */
    /* Create a contact instance */
    let nftAuthTokenABI = NftAuthToken.abi;
    let nftAuthTokenAddr = authTokenList[0];
    let nftAuthToken = new web3.eth.Contract(nftAuthTokenABI, nftAuthTokenAddr);

    /* Execute */
    const to = walletAddress;
    const ipfsHash = "QmTifnbzEpboKEFmxbs7RTrhx2rnDnWWRv3pcdSxZKtfky";
    let inputData1 = await nftAuthToken.methods.mintAuthToken(to, ipfsHash).encodeABI();
    let transaction1 = await sendTransaction(walletAddress, privateKey, nftAuthTokenAddr, inputData1)
}
mintAuthToken();

/*** 
 * @dev - Call getAuthTokenList() of NftAuthTokenManager contract
 **/
async function getAuthTokenList() {
    let _authTokenList = await nftAuthTokenManager.methods.getAuthTokenList().call();
    return _authTokenList;
}





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
