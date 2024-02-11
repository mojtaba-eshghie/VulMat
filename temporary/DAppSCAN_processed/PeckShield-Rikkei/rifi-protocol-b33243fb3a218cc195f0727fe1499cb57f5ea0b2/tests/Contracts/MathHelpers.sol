// File: ../sc_datasets/DAppSCAN/PeckShield-Rikkei/rifi-protocol-b33243fb3a218cc195f0727fe1499cb57f5ea0b2/tests/Contracts/MathHelpers.sol

pragma solidity ^0.5.16;

contract MathHelpers {

    /*
     * @dev Creates a number like 15e16 as a uint256 from scientific(15, 16).
     */
    function scientific(uint val, uint expTen) pure internal returns (uint) {
        return val * ( 10 ** expTen );
    }

}
