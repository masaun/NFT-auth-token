pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import { NftAuthToken } from "./NftAuthToken.sol";

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { SafeMath } from "@openzeppelin/contracts/math/SafeMath.sol";


contract NftAuthTokenManager {
    using SafeMath for uint;

    address[] nftAuthTokenList;

    IERC20 public dai;

    constructor(address _dai) public {
        dai = IERC20(_dai);    
    }

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
    function depositDaiIntoNftAuthToken(address _nftAuthToken, uint depositAmount) public returns (bool) {
        /// Deposit DAI from msg.sender to specified NftAuthToken contract address via this contract address 
        dai.transferFrom(msg.sender, address(this), depositAmount);
        dai.transfer(_nftAuthToken, depositAmount);
    }
    
}
