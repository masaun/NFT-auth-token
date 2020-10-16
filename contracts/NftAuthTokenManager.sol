pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import { NftAuthToken } from "./NftAuthToken.sol";

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { SafeMath } from "@openzeppelin/contracts/math/SafeMath.sol";


contract NftAuthTokenManager {
    using SafeMath for uint;

    address[] authTokenList;  /// [Note]: This array is for using for-loop

    IERC20 public dai;

    constructor(address _dai) public {
        dai = IERC20(_dai);    
    }

    /***
     * @notice - Create new AuthToken contract address
     **/
    function createAuthToken() public returns (address _authToken) {
        NftAuthToken authToken = new NftAuthToken();  /// [Note]: There is no constructor
        authTokenList.push(address(authToken));
        return address(authToken);
    }

    // function _saveauthTokenMetadata() internal returns (bool) {
    //     authTokenMetadata storage authTokenMetadata = authTokenMetadatas[address(asuthToken)];
    //     return address(authToken);
    // }


    


    /***
     * @notice - Deposit (Stake) DAI into the specified AuthToken contract address
     **/
    function depositDaiIntoAuthToken(address _authToken, uint depositAmount) public returns (bool) {
        /// Deposit DAI from msg.sender to specified AuthToken contract address via this contract address 
        dai.transferFrom(msg.sender, address(this), depositAmount);
        dai.transfer(_authToken, depositAmount);
    }


}
