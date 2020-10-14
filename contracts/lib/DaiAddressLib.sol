pragma solidity >=0.4.21 <0.7.0;


library DaiAddressLib {
    /**
     * @dev returns the address used within the protocol to identify DAI
     * @return the address assigned to DAI
     */
    function DaiAddress() internal pure returns (address) {
        return 0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa;  // DAI address on Kovan
    }
}
