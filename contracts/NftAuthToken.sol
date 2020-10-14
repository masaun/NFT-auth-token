pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { SafeMath } from "@openzeppelin/contracts/math/SafeMath.sol";


contract NftAuthToken is ERC721 {
    using SafeMath for uint;

    uint public currentAuthTokenId;

    constructor() public ERC721("NFT Auth Token", "NAT") {}


    /***
     * @notice - Private functions
     **/
    function getNextAuthTokenId() private view returns (uint nextAuthTokenId) {
        return currentAuthTokenId.add(1);
    }

}
