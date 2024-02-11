// File: ../sc_datasets/DAppSCAN/PeckShield-USR/USR-05cfe29ac4d66b0169d7545562eb40536352fd63/contracts/library/SafeMath.sol

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
