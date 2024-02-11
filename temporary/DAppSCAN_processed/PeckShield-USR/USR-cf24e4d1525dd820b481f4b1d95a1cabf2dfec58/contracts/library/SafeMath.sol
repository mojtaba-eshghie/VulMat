// File: ../sc_datasets/DAppSCAN/PeckShield-USR/USR-cf24e4d1525dd820b481f4b1d95a1cabf2dfec58/contracts/library/SafeMath.sol

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
