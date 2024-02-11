// File: ../sc_datasets/DAppSCAN/PeckShield-Atlantis/atlantis-protocol-bsc-766acebba9316eced1c15abf6158b31f470a947f/tests/Contracts/MathHelpers.sol

pragma solidity ^0.5.16;

contract MathHelpers {

    /*
     * @dev Creates a number like 15e16 as a uint256 from scientific(15, 16).
     */
    function scientific(uint val, uint expTen) pure internal returns (uint) {
        return val * ( 10 ** expTen );
    }

}
