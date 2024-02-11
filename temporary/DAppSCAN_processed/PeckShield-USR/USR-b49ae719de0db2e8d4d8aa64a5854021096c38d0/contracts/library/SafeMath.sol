// File: ../sc_datasets/DAppSCAN/PeckShield-USR/USR-b49ae719de0db2e8d4d8aa64a5854021096c38d0/contracts/library/SafeMath.sol

pragma solidity 0.5.12;

library SafeMath {
    function add(uint x, uint y) internal pure returns (uint z) {
        require((z = x + y) >= x);
    }

    function sub(uint x, uint y) internal pure returns (uint z) {
        require((z = x - y) <= x);
    }

    function mul(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x);
    }
}
