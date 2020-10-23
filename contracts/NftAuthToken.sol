pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
//import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
//import { SafeERC20 }  from "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import { SafeMath } from "@openzeppelin/contracts/math/SafeMath.sol";

import "@openzeppelin/contracts/access/AccessControl.sol";

//import { IMasset } from "./@mstable/protocol/contracts/interfaces/IMasset.sol";
//import { IMStableHelper } from "./@mstable/protocol/contracts/interfaces/IMStableHelper.sol";
//import { ISavingsContract } from "./@mstable/protocol/contracts/interfaces/ISavingsContract.sol";

//import { PoolWithNftAuthToken } from "./PoolWithNftAuthToken.sol";


contract NftAuthToken is ERC721, AccessControl {
// contract NftAuthToken is ERC721, PoolWithNftAuthToken {
    using SafeMath for uint;
    //using SafeERC20 for IERC20;

    uint public currentAuthTokenId;

    bytes32 public constant USER_ROLE = keccak256("USER_ROLE");

    constructor(
        address to,
        string memory ipfsHash
        //IERC20 _mUSD,
        //ISavingsContract _save,
        //IMStableHelper _helper
    ) 
        public 
        ERC721("NFT Auth Token", "NAT")
        //PoolWithNftAuthToken(_mUSD, _save, _helper)
    {
        _mintAuthToken(to, ipfsHash);

        /// Grant the creator of this contract the default admin role: it will be able
        /// to grant and revoke any roles
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function mintAuthToken(address to, string memory ipfsHash) public returns (uint _newAuthTokenId) {
        _mintAuthToken(to, ipfsHash);

        /// Grant an user who is minted the AuthToken the user-role
        _setupRole(USER_ROLE, to);
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
    function loginWithAuthToken(uint authTokenId, address userAddress, string memory ipfsHash) public view returns (bool _isAuth) {
        /// [Note]: Check whether a login user has role or not
        require(hasRole(USER_ROLE, msg.sender), "Caller is not a user");

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
     * @notice - deposit/withdrawal/collectInterest via mStable
     **/
    // function stakeIntoNftPool(uint256 stakeAmount) public returns (bool) {
    //     _stakeIntoNftPool(stakeAmount);
    // }
    
    // function withdrawFromNftPool(uint256 withdrawalAmount) public returns (bool) {
    //     _withdrawFromNftPool(withdrawalAmount);
    // }

    // function collectInterest(address beneficiary) public returns (bool) {
    //     _collectInterest(beneficiary);
    // }


    /***
     * @notice - Deposit (Stake) DAI into the specified AuthToken contract address
     **/
    // function depositDaiIntoAuthToken(address _authToken, uint depositAmount) public returns (bool) {
    //     /// Deposit DAI from msg.sender to specified AuthToken contract address via this contract address 
    //     dai.transferFrom(msg.sender, address(this), depositAmount);
    //     dai.transfer(_authToken, depositAmount);
    // }


    /***
     * @notice - Private functions
     **/
    function getNextAuthTokenId() private view returns (uint nextAuthTokenId) {
        return currentAuthTokenId.add(1);
    }

}
