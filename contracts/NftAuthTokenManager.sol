pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import { NftAuthToken } from "./NftAuthToken.sol";

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
//import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { SafeMath } from "@openzeppelin/contracts/math/SafeMath.sol";

import { IMasset } from "./@mstable/protocol/contracts/interfaces/IMasset.sol";
import { IMStableHelper } from "./@mstable/protocol/contracts/interfaces/IMStableHelper.sol";
import { ISavingsContract } from "./@mstable/protocol/contracts/interfaces/ISavingsContract.sol";


contract NftAuthTokenManager {
    using SafeMath for uint;

    address[] authTokenList;  /// [Note]: This array is for using for-loop

    //address DAI;
    IERC20 public mUSD;
    ISavingsContract public save;
    IMStableHelper public helper;

    constructor(
        //address _dai
        IERC20 _mUSD,
        ISavingsContract _save,
        IMStableHelper _helper
    ) public {
        //DAI = _dai;
        mUSD = _mUSD;
        save = _save;
        helper = _helper;
    }

    /***
     * @notice - Create new AuthToken contract address
     **/
    function createAuthToken() public returns (address _authToken) {
        NftAuthToken authToken = new NftAuthToken(mUSD, save, helper);
        authTokenList.push(address(authToken));
        return address(authToken);
    }

    // function _saveauthTokenMetadata() internal returns (bool) {
    //     authTokenMetadata storage authTokenMetadata = authTokenMetadatas[address(asuthToken)];
    //     return address(authToken);
    // }



    ///-------------------------- Getter methods ----------------------------///

    function getAuthTokenList() public view returns (address[] memory _authTokenList) {
        return authTokenList;
    }
    

}
