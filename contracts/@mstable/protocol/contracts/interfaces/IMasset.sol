pragma solidity ^0.6.12;

import { MassetStructs } from "../masset/shared/MassetStructs.sol";

/**
 * @title IMasset
 * @dev   (Internal) Interface for interacting with Masset
 *        VERSION: 1.0
 *        DATE:    2020-05-05
 */
abstract contract IMasset is MassetStructs {
//contract IMasset is MassetStructs {

    /** @dev Calc interest */
    function collectInterest() external virtual returns (uint256 massetMinted, uint256 newTotalSupply);

    /** @dev Minting */
    function mint(address _basset, uint256 _bassetQuantity)
        external virtual returns (uint256 massetMinted);
    function mintTo(address _basset, uint256 _bassetQuantity, address _recipient)
        external virtual returns (uint256 massetMinted);
    function mintMulti(address[] calldata _bAssets, uint256[] calldata _bassetQuantity, address _recipient)
        external virtual returns (uint256 massetMinted);

    /** @dev Swapping */
    function swap( address _input, address _output, uint256 _quantity, address _recipient)
        external virtual returns (uint256 output);
    function getSwapOutput( address _input, address _output, uint256 _quantity)
        external virtual view returns (bool, string memory, uint256 output);

    /** @dev Redeeming */
    function redeem(address _basset, uint256 _bassetQuantity)
        external virtual returns (uint256 massetRedeemed);
    function redeemTo(address _basset, uint256 _bassetQuantity, address _recipient)
        external virtual returns (uint256 massetRedeemed);
    function redeemMulti(address[] calldata _bAssets, uint256[] calldata _bassetQuantities, address _recipient)
        external virtual returns (uint256 massetRedeemed);
    function redeemMasset(uint256 _mAssetQuantity, address _recipient) external virtual;

    /** @dev Setters for the Manager or Gov to update module info */
    function upgradeForgeValidator(address _newForgeValidator) external virtual;

    /** @dev Setters for Gov to set system params */
    function setSwapFee(uint256 _swapFee) external virtual;

    /** @dev Getters */
    function getBasketManager() external virtual view returns(address);
    function forgeValidator() external virtual view returns (address);
    function totalSupply() external virtual view returns (uint256);
    function swapFee() external virtual view returns (uint256);
}
