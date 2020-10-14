pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { SafeMath } from "@openzeppelin/contracts/math/SafeMath.sol";


contract NftAuthToken is ERC721 {
    using SafeMath for uint;

    uint public currentAuthTokenId;

    constructor() public ERC721("NFT Auth Token", "NAT") {}

    function createAuthToken(address to, string memory authTokenURI) public returns (uint _newAuthTokenId) {
        _createAuthToken(to, authTokenURI);
    }

    function _createAuthToken(address to, string memory authTokenURI) internal returns (uint _newAuthTokenId) {
        uint newAuthTokenId = getNextAuthTokenId();
        currentAuthTokenId++;
        _mint(to, newAuthTokenId);
        _setTokenURI(newAuthTokenId, authTokenURI);

        return newAuthTokenId;
    }


    /***
     * @notice - Private functions
     **/
    function getNextAuthTokenId() private view returns (uint nextAuthTokenId) {
        return currentAuthTokenId.add(1);
    }

}
