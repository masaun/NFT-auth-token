pragma solidity ^0.6.12;

/**
 * @title ISavingsManager
 */
interface ISavingsManager {

    /** @dev Admin privs */
    function withdrawUnallocatedInterest(address _mAsset, address _recipient) external;

    /** @dev Public privs */
    function collectAndDistributeInterest(address _mAsset) external;

}
