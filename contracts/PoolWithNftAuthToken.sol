pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import { NftAuthToken } from "./NftAuthToken.sol";

import { SafeMath } from "@openzeppelin/contracts/math/SafeMath.sol";


contract PoolWithNftAuthToken {
    using SafeMath for uint;

    constructor() public {}

    /***
     * @notice - Stake
     **/
    function stake(address _authToken) public returns (bool) {
        NftAuthToken authToken = NftAuthToken(_authToken);
    }


}
