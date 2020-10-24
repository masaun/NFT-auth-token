pragma solidity ^0.6.12;

/***
 * @notice - This is interface file of the EthereumDIDRegistry.sol
 *         - Original contract: https://github.com/uport-project/ethr-did-registry/blob/develop/contracts/EthereumDIDRegistry.sol
 **/
interface IEthereumDIDRegistry {

    function identityOwner(address identity) external view returns(address) {}

}
