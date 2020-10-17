pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import { NftAuthToken } from "./NftAuthToken.sol";

import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { SafeMath } from "@openzeppelin/contracts/math/SafeMath.sol";


contract NftAuthTokenManager {
    using SafeMath for uint;

    address[] authTokenList;  /// [Note]: This array is for using for-loop

    address DAI;

    constructor(address _dai) public {
        DAI = _dai;
    }

    /***
     * @notice - Create new AuthToken contract address
     **/
    function createAuthToken() public returns (address _authToken) {
        NftAuthToken authToken = new NftAuthToken(DAI);  /// [Note]: There is no constructor
        authTokenList.push(address(authToken));
        return address(authToken);
    }

    // function _saveauthTokenMetadata() internal returns (bool) {
    //     authTokenMetadata storage authTokenMetadata = authTokenMetadatas[address(asuthToken)];
    //     return address(authToken);
    // }


}
