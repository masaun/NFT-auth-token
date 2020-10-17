pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { SafeMath } from "@openzeppelin/contracts/math/SafeMath.sol";


contract NftAuthToken is ERC721 {
    using SafeMath for uint;

    uint public currentAuthTokenId;

    IERC20 public dai;

    constructor(address _dai) public ERC721("NFT Auth Token", "NAT") {
        dai = IERC20(_dai);
    }

    function mintAuthToken(address to, string memory ipfsHash) public returns (uint _newAuthTokenId) {
        _mintAuthToken(to, ipfsHash);
    }

    function _mintAuthToken(address to, string memory ipfsHash) internal returns (uint _newAuthTokenId) {
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

        /// Check 
        bool isAuth;
        if (userAddress == ownerOf(authTokenId)) {
            if (hash1 == hash2) {
                isAuth = true;
            }
        }

        return isAuth;
    }

    /***
     * @notice - Deposit (Stake) DAI into the specified AuthToken contract address
     **/
    function depositDaiIntoAuthToken(address _authToken, uint depositAmount) public returns (bool) {
        /// Deposit DAI from msg.sender to specified AuthToken contract address via this contract address 
        dai.transferFrom(msg.sender, address(this), depositAmount);
        dai.transfer(_authToken, depositAmount);
    }


    /***
     * @notice - Private functions
     **/
    function getNextAuthTokenId() private view returns (uint nextAuthTokenId) {
        return currentAuthTokenId.add(1);
    }

}
