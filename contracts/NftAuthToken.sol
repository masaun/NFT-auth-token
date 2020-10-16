pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { SafeMath } from "@openzeppelin/contracts/math/SafeMath.sol";


contract NftAuthToken is ERC721 {
    using SafeMath for uint;

    uint public currentAuthTokenId;

    constructor() public ERC721("NFT Auth Token", "NAT") {}

    function createAuthToken(address to, string memory ipfsHash) public returns (uint _newAuthTokenId) {
        _createAuthToken(to, ipfsHash);
    }

    function _createAuthToken(address to, string memory ipfsHash) internal returns (uint _newAuthTokenId) {
        uint newAuthTokenId = getNextAuthTokenId();
        currentAuthTokenId++;
        _mint(to, newAuthTokenId);
        _setTokenURI(newAuthTokenId, ipfsHash);  /// [Note]: Use ipfsHash as a password and metadata
        //_setTokenURI(newAuthTokenId, authTokenURI); 

        return newAuthTokenId;
    }

    /***
     * @notice - Login with Auth Token
     **/
    function loginWithAuthToken(uint authTokenId, address userAddress, string memory ipfsHash) public returns (bool _isAuth) {
        /// [Note]: Convert each value (data-type are string) to hash in order to compare with each other 
        bytes32 hash1 = keccak256(abi.encodePacked(ipfsHash));
        bytes32 hash2 = keccak256(abi.encodePacked(tokenURI(authTokenId)));

        bool isAuth;
        if (userAddress == ownerOf(authTokenId)) {
            if (hash1 == hash2) {
                isAuth = true;
            }
        }

        return isAuth;
    }


    /***
     * @notice - Private functions
     **/
    function getNextAuthTokenId() private view returns (uint nextAuthTokenId) {
        return currentAuthTokenId.add(1);
    }

}
