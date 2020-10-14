pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import { NftAuthToken } from "./NftAuthToken.sol";

import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { SafeMath } from "@openzeppelin/contracts/math/SafeMath.sol";


contract NftAuthTokenManager {
    using SafeMath for uint;

    address[] nftAuthTokenList;

    constructor() public {}

    /***
     * @notice - Create new NftAuthToken contract address
     **/
    function createNftAuthToken() public returns (address _nftAuthToken) {
        NftAuthToken nftAuthToken = new NftAuthToken();  /// [Note]: There is no constructor
        nftAuthTokenList.push(address(nftAuthToken));
        return address(nftAuthToken);
    }

    // function _saveNftAuthTokenMetadata() internal returns (bool) {
    //     NftAuthTokenMetadata storage nftAuthTokenMetadata = nftAuthTokenMetadatas[address(nftAuthToken)];
    //     return address(nftAuthToken);
    // }


    /***
     * @notice - Deposit (Stake) DAI into the specified NftAuthToken contract address
     **/
    function depositDaiIntoNftAuthToken(uint depositAmount) public returns (bool) {
        /// In progress
    }
    
}
