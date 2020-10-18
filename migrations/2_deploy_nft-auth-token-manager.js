const NftAuthTokenManager = artifacts.require("NftAuthTokenManager");

//@dev - Import from exported file
var contractAddressList = require('./contractAddress/contractAddress.js');
var tokenAddressList = require('./tokenAddress/tokenAddress.js');
var walletAddressList = require('./walletAddress/walletAddress.js');

const _mUSD = tokenAddressList["Kovan"]["mStable"]["mUSD"];
const _save = contractAddressList["Kovan"]["mStable"]["mUSD SAVE"];
const _helper = contractAddressList["Kovan"]["mStable"]["mStable Helper"];

module.exports = function(deployer) {
    deployer.deploy(NftAuthTokenManager, _mUSD, _save, _helper);
};
