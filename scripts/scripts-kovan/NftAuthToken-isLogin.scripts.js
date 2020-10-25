require('dotenv').config();

const Tx = require('ethereumjs-tx').Transaction;
const Web3 = require('web3');
const provider = new Web3.providers.HttpProvider(`https://kovan.infura.io/v3/${ process.env.INFURA_KEY }`);
const web3 = new Web3(provider);

let NftAuthToken = {};
let NftAuthTokenManager = {};
NftAuthToken = require("../../build/contracts/NftAuthToken.json");
NftAuthTokenManager = require("../../build/contracts/NftAuthTokenManager.json");

const walletAddress1 = process.env.WALLET_ADDRESS;
const privateKey1 = process.env.PRIVATE_KEY;

const walletAddress2 = process.env.WALLET_ADDRESS_2;


/* Global variable */
let nftAuthTokenABI;
let nftAuthTokenAddr;
let nftAuthToken;

let nftAuthTokenManagerABI;
let nftAuthTokenManagerAddr;
let nftAuthTokenManager;

/* Set up contract */
nftAuthTokenManagerABI = NftAuthTokenManager.abi;
nftAuthTokenManagerAddr = NftAuthTokenManager["networks"]["42"]["address"];    /// Deployed address on Kovan
nftAuthTokenManager = new web3.eth.Contract(nftAuthTokenManagerABI, nftAuthTokenManagerAddr);



/*** 
 * @dev - Call getAuthTokenList() of NftAuthTokenManager contract
 **/
async function getAuthTokenList() {
    let _authTokenList = await nftAuthTokenManager.methods.getAuthTokenList().call();
    return _authTokenList;
}



/*** 
 * @dev - loginWithAuthToken() method of NftAuthToken contract 
 **/
async function loginWithAuthToken() {
    /* Check authTokenList after createAuthToken() is executed */
    const authTokenList = await getAuthTokenList();
    console.log('\n=== authTokenList ===\n', authTokenList);

    /* Choose 1 contract address which is created by NftAuthTokenManager.sol */
    /* Create a contact instance */
    let nftAuthTokenABI = NftAuthToken.abi;
    let nftAuthTokenAddr = authTokenList[0];
    let nftAuthToken = new web3.eth.Contract(nftAuthTokenABI, nftAuthTokenAddr);

    /* Execute */
    const authTokenId = 1;
    const userAddress = walletAddress2;
    const ipfsHash = "QmTifnbzEpboKEFmxbs7RTrhx2rnDnWWRv3pcdSxZKtfky";
    let isAuth = await nftAuthToken.methods.loginWithAuthToken(authTokenId, userAddress, ipfsHash).call();
    console.log(`\n=== isAuth: ${ isAuth } ===\n`);   /// [Result]: === isAuth: true ===
}
loginWithAuthToken();
